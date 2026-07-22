#!/bin/bash

# ==================================================
#  SERVER CONTROL CENTER | PROXMOX ONLY
#  Enhanced & Beautified UI
# ==================================================

# --- 1. COLORS & STYLING ---
BG_BLUE="\e[44;97m"
BG_GREEN="\e[42;97m"
BG_RED="\e[41;97m"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
C="\e[36m"
M="\e[35m"
W="\e[97m"
GREY="\e[90m"
RESET="\e[0m"
BOLD="\e[1m"

# --- 2. CONFIG ---
PROXMOX_PORT_FILE="/root/.proxmox_port"

# Fetch IP once at startup to prevent menu lag
SERVER_IP=$(curl -s ifconfig.me || hostname -I | awk '{print $1}')

# --- 3. UTILITY ---
pause() { 
    echo -e "\n  ${GREY}╭─────────────────────────────────────────────────────────╮${RESET}"
    read -p "$(echo -e "  ${GREY}│${RESET} ↩ Press ${BOLD}Enter${RESET} to continue... ")" _ 
}

get_port() {
    if [ -f "$PROXMOX_PORT_FILE" ]; then 
        cat "$PROXMOX_PORT_FILE"
    else 
        echo "8006"
    fi
}

check_container_exists() {
    docker ps -a --format '{{.Names}}' | grep -q "^proxmox$"
}

check_container_running() {
    docker ps --format '{{.Names}}' | grep -q "^proxmox$"
}

# --- 4. HEADER ---
draw_header() {
    clear
    local user=$(whoami)
    local host=$(hostname)

    # Docker Status
    local doc_pill="${BG_RED}  OFF  ${RESET}"
    if command -v docker &>/dev/null; then doc_pill="${BG_GREEN}   ON  ${RESET}"; fi

    # Proxmox Status
    local pmx_pill="${BG_RED}  OFF  ${RESET}"
    local pmx_port=$(get_port)
    if check_container_running; then 
        pmx_pill="${BG_GREEN}   ON  ${RESET}"
    elif check_container_exists; then
        pmx_pill="${BG_RED} STOPPED ${RESET}"
    fi

    echo -e "${C}╭────────────────────────────────────────────────────────────╮${RESET}"
    echo -e "${C}│${RESET} ${BOLD}⚡ SERVER CONTROL CENTER | PROXMOX MANAGER               ${C}│${RESET}"
    echo -e "${C}├────────────────────────────────────────────────────────────┤${RESET}"
    echo -e "${C}│${RESET}  ${C}User:${RESET} ${W}$user${RESET}   ${GREY}|${RESET}   ${C}Host:${RESET} ${W}$host${RESET}"
    echo -e "${C}│${RESET}  ${C}IP:  ${RESET} ${W}$SERVER_IP${RESET}"
    echo -e "${C}├────────────────────────────────────────────────────────────┤${RESET}"
    echo -e "${C}│${RESET}  ${BOLD}SERVICES STATUS:${RESET}"
    printf "${C}│${RESET}  ├── ${W}%-10s${RESET} %b\n" "Docker" "$doc_pill"
    printf "${C}│${RESET}  └── ${W}%-10s${RESET} %b  ${GREY}➜ Port: ${Y}$pmx_port${RESET}\n" "Proxmox" "$pmx_pill"
    echo -e "${C}╰────────────────────────────────────────────────────────────╯${RESET}"
    echo
}

# --- 5. INSTALL DOCKER ---
install_docker() {
    if ! command -v docker &>/dev/null; then
        echo -e "  ${B}🚀 Installing Docker...${RESET}"
        curl -fsSL https://get.docker.com | sh >/dev/null 2>&1
        systemctl enable --now docker >/dev/null 2>&1
        echo -e "  ${G}✔️ Docker Installed Successfully.${RESET}\n"
    fi
}

# --- 6. PROXMOX FUNCTIONS ---
install_proxmox() {
    if check_container_exists; then
        echo -e "  ${Y}⚠️ Proxmox is already installed! Uninstall it first to reinstall.${RESET}"
        pause
        return
    fi

    install_docker

    # PORT SELECTION
    echo -e "  ${C}╭─[ 🌐 PROXMOX PORT ]${RESET}"
    echo -e "  ${C}│${RESET}"
    echo -e "  ${C}│${RESET}  ${GREY}[${Y}1${GREY}]${RESET} Default Port ${C}(8006)${RESET}"
    echo -e "  ${C}│${RESET}  ${GREY}[${Y}2${GREY}]${RESET} Custom Port"
    echo -e "  ${C}│${RESET}"
    read -p "$(echo -e "  ${C}╰─➤${RESET} Select Option: ")" port_choice

    if [ "$port_choice" == "2" ]; then
        read -p "$(echo -e "      ${C}➤${RESET} Enter Custom Port: ")" CUSTOM_PORT
        # Validate if input is a number
        if [[ "$CUSTOM_PORT" =~ ^[0-9]+$ ]]; then
            PORT=$CUSTOM_PORT
        else
            echo -e "      ${R}Invalid port! Defaulting to 8006.${RESET}"
            PORT=8006
        fi
    else
        PORT=8006
    fi
    echo "$PORT" > "$PROXMOX_PORT_FILE"
    echo

    # PASSWORD SELECTION
    echo -e "  ${M}╭─[ 🔒 PROXMOX PASSWORD ]${RESET}"
    echo -e "  ${M}│${RESET}"
    echo -e "  ${M}│${RESET}  ${GREY}[${Y}1${GREY}]${RESET} Default Password ${M}(root)${RESET}"
    echo -e "  ${M}│${RESET}  ${GREY}[${Y}2${GREY}]${RESET} Custom Password"
    echo -e "  ${M}│${RESET}"
    read -p "$(echo -e "  ${M}╰─➤${RESET} Select Option: ")" pass_choice

    if [ "$pass_choice" == "2" ]; then
        read -p "$(echo -e "      ${M}➤${RESET} Enter Custom Password: ")" CUSTOM_PASS
        if [ -z "$CUSTOM_PASS" ]; then
            PROXMOX_PASS="root"
        else
            PROXMOX_PASS="$CUSTOM_PASS"
        fi
    else
        PROXMOX_PASS="root"
    fi

    echo -e "\n  ${B}📁 Creating persistent directories...${RESET}"
    mkdir -p /opt/proxmox/data
    mkdir -p /opt/proxmox/config

    echo -e "  ${B}⏳ Installing Proxmox on port ${PORT}... (This may take a moment)${RESET}"

    docker rm -f proxmox >/dev/null 2>&1
    docker run -d \
      --name proxmox \
      --hostname pve \
      --privileged \
      --restart unless-stopped \
      --stop-timeout 120 \
      -e PASSWORD="${PROXMOX_PASS}" \
      -p ${PORT}:8006 \
      -v /opt/proxmox/data:/var/lib/vz \
      -v /opt/proxmox/config:/var/lib/pve-cluster \
      nobitaa/proxmox >/dev/null 2>&1

    echo -e "\n  ${G}🎉 Successfully Installed!${RESET}"
    echo -e "  ${C}====================================================${RESET}"
    echo -e "  ${W}🔗 Access URL :${RESET} ${C}https://${SERVER_IP}:${PORT}${RESET}"
    echo -e "  ${W}👤 Username   :${RESET} ${Y}root${RESET}"
    echo -e "  ${W}🔑 Password   :${RESET} ${Y}${PROXMOX_PASS}${RESET}"
    echo -e "  ${C}====================================================${RESET}"
    echo -e "  ${GREY}(Note: Accept the self-signed SSL warning in your browser)${RESET}"
    pause
}

uninstall_proxmox() {
    if ! check_container_exists; then
        echo -e "  ${Y}⚠️ Proxmox is not installed.${RESET}"
        pause
        return
    fi

    echo -e "\n  ${R}🗑️ Removing Proxmox container...${RESET}"
    docker rm -f proxmox >/dev/null 2>&1
    rm -f "$PROXMOX_PORT_FILE"
    echo -e "  ${G}✔️ Removed Successfully.${RESET}"
    echo -e "  ${GREY}Volumes in /opt/proxmox were kept intact. Delete manually if needed.${RESET}"
    pause
}

start_proxmox() {
    if ! check_container_exists; then echo -e "  ${Y}⚠️ Proxmox is not installed.${RESET}"; pause; return; fi
    docker start proxmox >/dev/null 2>&1
    echo -e "  ${G}🟢 Proxmox Started${RESET}"
    pause
}

stop_proxmox() {
    if ! check_container_exists; then echo -e "  ${Y}⚠️ Proxmox is not installed.${RESET}"; pause; return; fi
    echo -e "  ${Y}⏳ Stopping Proxmox...${RESET}"
    docker stop proxmox >/dev/null 2>&1
    echo -e "  ${R}🔴 Proxmox Stopped${RESET}"
    pause
}

restart_proxmox() {
    if ! check_container_exists; then echo -e "  ${Y}⚠️ Proxmox is not installed.${RESET}"; pause; return; fi
    echo -e "  ${Y}⏳ Restarting Proxmox...${RESET}"
    docker restart proxmox >/dev/null 2>&1
    echo -e "  ${G}🔄 Proxmox Restarted${RESET}"
    pause
}

open_terminal() {
    if ! check_container_running; then
        echo -e "\n  ${R}⚠️ Proxmox container is not running! Please start it first.${RESET}"
        pause
        return
    fi
    echo -e "\n  ${B}💻 Opening Proxmox Terminal...${RESET}"
    echo -e "  ${GREY}Type '${Y}exit${GREY}' to return to the menu.${RESET}\n"
    docker exec -it proxmox /bin/bash
    pause
}

download_template() {
    if ! check_container_running; then
        echo -e "\n  ${R}⚠️ Proxmox container is not running! Please start it first.${RESET}"
        pause
        return
    fi
    echo -e "\n  ${B}📥 Downloading and starting OS Template Downloader inside Proxmox...${RESET}"
    
    # Execute the download and script directly inside the container
    docker exec -it proxmox /bin/bash -c "wget -q https://github.com/ConvoyPanel/downloader/releases/latest/download/downloader_x86 && chmod +x downloader_x86 && ./downloader_x86"
    pause
}

# --- 7. PROXMOX MENU ---
proxmox_menu() {
    while true; do
        draw_header
        echo -e "  ${BOLD}╭─[ MENU OPTIONS ]${RESET}"
        echo -e "  ${BOLD}│${RESET}"
        echo -e "  ${BOLD}│${RESET}  ${GREY}[${Y}1${GREY}]${RESET} ${G}🚀 Install Proxmox${RESET}"
        echo -e "  ${BOLD}│${RESET}  ${GREY}[${Y}2${GREY}]${RESET} ${G}🟢 Turn ON${RESET}"
        echo -e "  ${BOLD}│${RESET}  ${GREY}[${Y}3${GREY}]${RESET} ${R}🔴 Turn OFF${RESET}"
        echo -e "  ${BOLD}│${RESET}  ${GREY}[${Y}4${GREY}]${RESET} ${Y}🔄 Restart${RESET}"
        echo -e "  ${BOLD}│${RESET}  ${GREY}[${Y}5${GREY}]${RESET} ${C}💻 Open Terminal${RESET}"
        echo -e "  ${BOLD}│${RESET}  ${GREY}[${Y}6${GREY}]${RESET} ${M}📥 Download OS Template${RESET}"
        echo -e "  ${BOLD}│${RESET}  ${GREY}[${Y}7${GREY}]${RESET} ${R}🗑️ Uninstall Proxmox${RESET}"
        echo -e "  ${BOLD}│${RESET}"
        echo -e "  ${BOLD}│${RESET}  ${GREY}[${R}0${GREY}]${RESET} ${GREY}❌ Exit${RESET}"
        echo -e "  ${BOLD}╰──────────────────────────────────────${RESET}"
        echo

        read -p "$(echo -e "  ${BOLD}➤${RESET} root@ska/vps/proxmox: ")" opt
        case $opt in
            1) install_proxmox ;;
            2) start_proxmox ;;
            3) stop_proxmox ;;
            4) restart_proxmox ;;
            5) open_terminal ;;
            6) download_template ;;
            7) uninstall_proxmox ;;
            0) echo -e "\n  ${G}👋 Goodbye!${RESET}\n"; exit 0 ;;
            *) echo -e "  ${R}⚠️ Invalid option${RESET}"; sleep 1 ;;
        esac
    done
}

# --- RUN ---
proxmox_menu
