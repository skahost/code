#!/bin/bash

# ==========================================
# SKA HOST MULTI-TOOL (V5.2 - RESPONSIVE UI)
# STYLE: NEON CYBERPUNK + AUTO ADJUSTABLE
# MODULES: NATIVE PLAYIT + NATIVE FXTUNNEL
# ==========================================

# 🎨 Premium Colors (High-Intensity ANSI)
R='\033[1;91m'      # Bright Red
G='\033[1;92m'      # Bright Green
Y='\033[1;93m'      # Bright Yellow
B='\033[1;94m'      # Bright Blue
P='\033[1;95m'      # Bright Magenta
C='\033[1;96m'      # Bright Cyan
W='\033[1;97m'      # Bright White
DG='\033[1;90m'     # Dark Gray
BLINK='\033[5m'     # Blinking
NC='\033[0m'        # No Color

# ==========================================
# 📐 RESPONSIVE TERMINAL WIDTH CHECK
# ==========================================
get_term_width() {
    local width=$(tput cols 2>/dev/null)
    if [[ -z "$width" || "$width" -lt 20 ]]; then
        width=70 # Default fallback
    fi
    echo "$width"
}

# ==========================================
# 🎬 ANIMATIONS & EFFECTS
# ==========================================

# Smooth Typing Effect
type_effect() {
    local text="$1"
    local speed="$2"
    for (( i=0; i<${#text}; i++ )); do
        echo -en "${text:$i:1}"
        sleep "$speed"
    done
    echo ""
}

# Cyberpunk Spinner Loading Screen
boot_sequence() {
    clear
    echo -e "\n\n"
    local text="${C}  [SYS] Establishing secure connection to SKA HOST servers...${NC}"
    type_effect "$text" 0.02
    
    local chars="/-\|"
    echo -ne "  ${P}Authenticating: ${NC}"
    for i in {1..15}; do
        echo -ne "\b${G}${chars:i%4:1}${NC}"
        sleep 0.1
    done
    
    echo -e "\b${G}SUCCESS!${NC}"
    echo -ne "  ${C}Booting Core Engine [${NC}"
    for ((i = 0; i < 35; i++)); do
        echo -ne "${P}■${NC}"
        sleep 0.02
    done
    echo -e "${C}] 100%${NC}"
    sleep 0.3
}

# ==========================================
# 🖥️ BANNERS & DASHBOARDS (RESPONSIVE)
# ==========================================

show_dashboard() {
    clear
    local UPTIME=$(uptime -p | sed -e 's/up //' -e 's/ hours/h/' -e 's/ hour/h/' -e 's/ minutes/m/' -e 's/ minute/m/' -e 's/ days/d/' -e 's/ day/d/' -e 's/,//g') 
    local CPU_LOAD=$(top -bn1 | grep load | awk '{printf "%.2f", $(NF-2)}')
    local RAM_FREE=$(free -m | awk '/Mem:/ { printf("%.0f%%", $3/$2 * 100.0) }')
    local WIDTH=$(get_term_width)

    if [[ "$WIDTH" -lt 68 ]]; then
        # 📱 MOBILE / SMALL TERMINAL LAYOUT
        echo -e "${C}═════════════════════════════════════════════${NC}"
        echo -e " ${C}⚡ SKA HOST MULTI-TOOL (SYS ONLINE) ⚡${NC}"
        echo -e "${C}═════════════════════════════════════════════${NC}"
        echo -e " ${BLINK}${G}● ONLINE${NC} ${DG}|${NC} ⏱️ ${W}UP: ${UPTIME:0:12}${NC}"
        echo -e " 🧠 ${W}CPU: ${CPU_LOAD}%${NC} ${DG}|${NC} 💾 ${W}RAM: ${RAM_FREE}${NC}"
        echo -e "${C}─────────────────────────────────────────────${NC}"
    else
        # 💻 PC / WIDE TERMINAL LAYOUT
        printf -v PAD_UPTIME "UP: %-12s" "${UPTIME:0:12}"
        printf -v PAD_CPU "CPU: %-5s" "${CPU_LOAD}%"
        printf -v PAD_RAM "RAM: %-4s" "${RAM_FREE}"

        echo -e "${C}╔════════════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${C}║${NC}   ${C}███████╗██╗  ██╗ █████╗     ██╗  ██╗ ██████╗ ███████╗████████╗${NC}   ${C}║${NC}"
        echo -e "${C}║${NC}   ${B}██╔════╝██║ ██╔╝██╔══██╗    ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝${NC}   ${C}║${NC}"
        echo -e "${C}║${NC}   ${P}███████╗█████╔╝ ███████║    ███████║██║   ██║███████╗   ██║   ${NC}   ${C}║${NC}"
        echo -e "${C}║${NC}   ${Y}╚════██║██╔═██╗ ██╔══██║    ██╔══██║██║   ██║╚════██║   ██║   ${NC}   ${C}║${NC}"
        echo -e "${C}║${NC}   ${G}███████║██║  ██╗██║  ██║    ██║  ██║╚██████╔╝███████║   ██║   ${NC}   ${C}║${NC}"
        echo -e "${C}║${NC}   ${W}╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   ${NC}   ${C}║${NC}"
        echo -e "${C}╠════════════════════════════════════════════════════════════════════╣${NC}"
        echo -e "${C}║${NC} ${BLINK}${G}● ONLINE${NC} ${DG}│${NC} ⏱️ ${W}${PAD_UPTIME}${NC} ${DG}│${NC} 🧠 ${W}${PAD_CPU}${NC} ${DG}│${NC} 💾 ${W}${PAD_RAM}${NC}      ${C}║${NC}"
        echo -e "${C}╚════════════════════════════════════════════════════════════════════╝${NC}"
    fi
}

show_playit_dash() {
    clear
    local WIDTH=$(get_term_width)
    if [[ "$WIDTH" -lt 68 ]]; then
        echo -e "${P}═════════════════════════════════════════════${NC}"
        echo -e " ${Y}⚡ PLAYIT.GG MODULE ⚡${NC}"
        echo -e "${P}═════════════════════════════════════════════${NC}"
    else
        echo -e "${P}╔════════════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${P}║${NC} ${W}██████╗ ██╗      █████╗ ██╗   ██╗██╗████████╗${NC}                      ${P}║${NC}"
        echo -e "${P}║${NC} ${W}██╔══██╗██║     ██╔══██╗╚██╗ ██╔╝██║╚══██╔══╝${NC}                      ${P}║${NC}"
        echo -e "${P}║${NC} ${W}██████╔╝██║     ███████║ ╚████╔╝ ██║   ██║   ${NC}                      ${P}║${NC}"
        echo -e "${P}║${NC} ${W}██╔═══╝ ██║     ██╔══██║  ╚██╔╝  ██║   ██║   ${NC}                      ${P}║${NC}"
        echo -e "${P}║${NC} ${W}██║     ███████╗██║  ██║   ██║   ██║   ██║   ${NC}                      ${P}║${NC}"
        echo -e "${P}║${NC} ${W}╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝   ╚═╝   ${NC}                      ${P}║${NC}"
        echo -e "${P}╠════════════════════════════════════════════════════════════════════╣${NC}"
        echo -e "${P}║${NC}                   ${Y}⚡ PLAYIT.GG MODULE ⚡${NC}                           ${P}║${NC}"
        echo -e "${P}╚════════════════════════════════════════════════════════════════════╝${NC}"
    fi
    echo ""
}

show_fxtunnel_dash() {
    clear
    local WIDTH=$(get_term_width)
    if [[ "$WIDTH" -lt 68 ]]; then
        echo -e "${B}═════════════════════════════════════════════${NC}"
        echo -e " ${C}🚇 FXTUNNEL MODULE 🚇${NC}"
        echo -e "${B}═════════════════════════════════════════════${NC}"
    else
        echo -e "${B}╔════════════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${B}║${NC} ${W}███████╗██╗  ██╗████████╗██╗   ██╗███╗   ██╗███╗   ██╗███████╗${NC}     ${B}║${NC}"
        echo -e "${B}║${NC} ${W}██╔════╝╚██╗██╔╝╚══██╔══╝██║   ██║████╗  ██║████╗  ██║██╔════╝${NC}     ${B}║${NC}"
        echo -e "${B}║${NC} ${W}█████╗   ╚███╔╝    ██║   ██║   ██║██╔██╗ ██║██╔██╗ ██║█████╗  ${NC}     ${B}║${NC}"
        echo -e "${B}║${NC} ${W}██╔══╝   ██╔██╗    ██║   ██║   ██║██║╚██╗██║██║╚██╗██║██╔══╝  ${NC}     ${B}║${NC}"
        echo -e "${B}║${NC} ${W}██║     ██╔╝ ██╗   ██║   ╚██████╔╝██║ ╚████║██║ ╚████║███████╗${NC}     ${B}║${NC}"
        echo -e "${B}║${NC} ${W}╚═╝     ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝${NC}     ${B}║${NC}"
        echo -e "${B}╠════════════════════════════════════════════════════════════════════╣${NC}"
        echo -e "${B}║${NC}                   ${C}🚇 FXTUNNEL MODULE 🚇${NC}                            ${B}║${NC}"
        echo -e "${B}╚════════════════════════════════════════════════════════════════════╝${NC}"
    fi
    echo ""
}

# ==========================================
# 🛠️ PORT FORWARDING LOGIC
# ==========================================

playit_menu() {
    while true; do
        show_playit_dash
        local WIDTH=$(get_term_width)
        
        if [[ "$WIDTH" -lt 68 ]]; then
            echo -e " ${G}[A]${NC} 📥 Install & Configure Playit"
            echo -e " ${G}[B]${NC} 📊 Check Status"
            echo -e " ${R}[C]${NC} 🔙 Back to Menu"
        else
            echo -e "${C}╭────────────────────────────────────────────────────────────────────╮${NC}"
            echo -e "${C}│${NC}  ${G}[A]${NC} 📥 Install & Configure Playit.GG                                ${C}│${NC}"
            echo -e "${C}│${NC}  ${G}[B]${NC} 📊 Check Connection Status                                      ${C}│${NC}"
            echo -e "${C}│${NC}  ${R}[C]${NC} 🔙 Back to Port Forwarding Menu                                 ${C}│${NC}"
            echo -e "${C}╰────────────────────────────────────────────────────────────────────╯${NC}"
        fi
        echo ""
        
        echo -en "  ${Y}root@skahost${W}:~${P}/playit${NC}# "
        read -r subopt
        case "$subopt" in
            [Aa]) 
                echo -e "\n${C}  [SYS] Initializing Playit Installation...${NC}"
                echo -ne "  ${Y}● Updating system & dependencies...${NC}\r"
                sudo apt update -y >/dev/null 2>&1 && sudo apt upgrade -y >/dev/null 2>&1
                sudo apt install -y sudo curl gpg >/dev/null 2>&1
                echo -e "  ${G}✔️ System & dependencies updated.                 ${NC}"

                echo -ne "  ${Y}● Downloading Playit components...${NC}\r"
                curl -fsSL https://playit-cloud.github.io/ppa/key.gpg 2>/dev/null | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null 2>&1
                echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" | sudo tee /etc/apt/sources.list.d/playit-cloud.list >/dev/null 2>&1
                sudo apt update -y >/dev/null 2>&1
                sudo apt install -y playit >/dev/null 2>&1
                sudo systemctl enable --now playit >/dev/null 2>&1
                echo -e "  ${G}✔️ Download & Installation Successful!            ${NC}"

                echo -e "\n${C}  [SYS] Running Playit Setup...${NC}"
                playit setup

                type_effect "\n${G}✅ Playit installation complete!${NC}" 0.02
                type_effect "${DG}➡️ Run 'playit status' to check the tunnel status.${NC}" 0.02
                
                echo -en "  ${Y}root@skahost${W}:~${DG}/sys/pause${NC} (Press ENTER) "
                read -r 
                ;;
            [Bb]) 
                playit
                echo -en "\n  ${Y}root@skahost${W}:~${DG}/sys/pause${NC} (Press ENTER to return) "
                read -r 
                ;;
            [Cc]) 
                break 
                ;;
            *) 
                echo -e "${R}  [!] Invalid command sequence!${NC}"
                sleep 1 
                ;;
        esac
    done
}

fxtunnel_menu() {
    while true; do
        show_fxtunnel_dash
        local WIDTH=$(get_term_width)
        
        if systemctl is-active --quiet skahost-fxtunnel.service 2>/dev/null; then
            echo -e "  ${DG}STATUS:${NC} ${G}● RUNNING${NC}\n"
        else
            echo -e "  ${DG}STATUS:${NC} ${R}● STOPPED${NC}\n"
        fi
        
        if [[ "$WIDTH" -lt 68 ]]; then
            echo -e " ${G}[1]${NC} 📥 Install FXTUNNEL Core"
            echo -e " ${Y}[2]${NC} 🚀 Setup & Start Tunnel"
            echo -e " ${R}[3]${NC} 🛑 Stop & Delete Tunnel"
            echo -e " ${DG}[0]${NC} 🔙 Back to Menu"
        else
            echo -e "${C}╭────────────────────────────────────────────────────────────────────╮${NC}"
            echo -e "${C}│${NC}  ${G}[1]${NC} 📥 Install FXTUNNEL Core                                        ${C}│${NC}"
            echo -e "${C}│${NC}  ${Y}[2]${NC} 🚀 Setup & Start Tunnel (Port & Token)                          ${C}│${NC}"
            echo -e "${C}│${NC}  ${R}[3]${NC} 🛑 Stop & Delete Tunnel                                         ${C}│${NC}"
            echo -e "${C}│${NC}  ${DG}[0]${NC} 🔙 Back to Port Forwarding Menu                                 ${C}│${NC}"
            echo -e "${C}╰────────────────────────────────────────────────────────────────────╯${NC}"
        fi
        echo ""
        
        echo -en "  ${Y}root@skahost${W}:~${B}/fxtunnel${NC}# "
        read -r subopt
        case "$subopt" in
            1|01) 
                echo -e "\n${C}  [SYS] Installing FXTUNNEL Core Dependencies...${NC}"
                echo -ne "  ${Y}● Downloading and Installing FXTUNNEL...${NC}\r"
                curl -fsSL https://fxtun.dev/install.sh | sh >/dev/null 2>&1
                
                if ! grep -q "/root/.local/bin" /root/.bashrc 2>/dev/null; then
                    echo 'export PATH=$PATH:/root/.local/bin' >> /root/.bashrc
                fi
                export PATH=$PATH:/root/.local/bin
                echo -e "  ${G}✔️ Download & Installation Successful!            ${NC}"
                echo -en "  ${Y}root@skahost${W}:~${DG}/sys/pause${NC} (Press ENTER) "
                read -r 
                ;;
            2|02) 
                echo -e "\n${C}  [SYS] Configuring FXTUNNEL Connection...${NC}"
                echo -en "  ${Y}root@skahost${W}:~${B}/fxtunnel/set-port${NC} (e.g. 22)# "
                read -r port
                echo -en "  ${Y}root@skahost${W}:~${B}/fxtunnel/set-token${NC}# "
                read -r token
                
                if [[ -n "$port" && -n "$token" ]]; then
                    FX_BIN=$(command -v fxtunnel || echo "/root/.local/bin/fxtunnel")
                    cat > /etc/systemd/system/skahost-fxtunnel.service << EOF
[Unit]
Description=SKA HOST - fxTunnel SSH Tunnel
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=root
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/.local/bin"
ExecStart=${FX_BIN} tcp ${port} -t ${token}
Restart=on-failure
RestartSec=10
TimeoutStartSec=30
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF
                    systemctl daemon-reload
                    systemctl stop skahost-fxtunnel.service 2>/dev/null
                    systemctl enable skahost-fxtunnel.service 2>/dev/null
                    systemctl start skahost-fxtunnel.service
                    type_effect "\n${G}✔️ Tunnel Configured & Started!${NC}" 0.02
                else
                    echo -e "\n${R}  [!] Error: Port or Token cannot be empty!${NC}"
                fi
                echo -en "  ${Y}root@skahost${W}:~${DG}/sys/pause${NC} (Press ENTER) "
                read -r 
                ;;
            3|03)
                echo -e "\n${R}  [SYS] Terminating Tunnel Processes...${NC}"
                systemctl stop skahost-fxtunnel.service 2>/dev/null
                systemctl disable skahost-fxtunnel.service 2>/dev/null
                rm -f /etc/systemd/system/skahost-fxtunnel.service
                systemctl daemon-reload
                pkill -f "fxtunnel" 2>/dev/null || true
                type_effect "\n${G}✔️ Tunnel Stopped & Removed.${NC}" 0.02
                echo -en "  ${Y}root@skahost${W}:~${DG}/sys/pause${NC} (Press ENTER) "
                read -r
                ;;
            0|00) 
                break 
                ;;
            *) 
                echo -e "${R}  [!] Invalid command sequence!${NC}"
                sleep 1 
                ;;
        esac
    done
}

port_forward_menu() {
    while true; do
        clear
        echo -e "\n"
        local WIDTH=$(get_term_width)

        if [[ "$WIDTH" -lt 68 ]]; then
            echo -e "${Y}═════════════════════════════════════════════${NC}"
            echo -e " ${C}⚡ PORT FORWARDING TOOL ⚡${NC}"
            echo -e "${Y}═════════════════════════════════════════════${NC}\n"
            echo -e "  ${G}[1]${NC} 🎮 PLAYIT.GG (Default Tunnel)"
            echo -e "  ${B}[2]${NC} 🚇 FXTUNNEL (Advanced Tunnel)"
            echo -e "  ${R}[0]${NC} 🔙 BACK TO MENU"
        else
            echo -e "${Y}╔════════════════════════════════════════════════════════════════════╗${NC}"
            echo -e "${Y}║${NC}                     ${C}⚡ PORT FORWARDING TOOL ⚡${NC}                     ${Y}║${NC}"
            echo -e "${Y}╠════════════════════════════════════════════════════════════════════╣${NC}"
            echo -e "${Y}║${NC}                                                                    ${Y}║${NC}"
            echo -e "${Y}║${NC}   ${G}[1]${NC} 🎮 PLAYIT.GG (Default Tunnel)                                ${Y}║${NC}"
            echo -e "${Y}║${NC}   ${B}[2]${NC} 🚇 FXTUNNEL (Advanced Tunnel)                                ${Y}║${NC}"
            echo -e "${Y}║${NC}                                                                    ${Y}║${NC}"
            echo -e "${Y}║${NC}   ${R}[0]${NC} 🔙 BACK TO MAIN DASHBOARD                                    ${Y}║${NC}"
            echo -e "${Y}╚════════════════════════════════════════════════════════════════════╝${NC}"
        fi
        echo ""
        
        echo -en "  ${Y}root@skahost${W}:~${C}/port-forward${NC}# "
        read -r pf_opt
        
        case "$pf_opt" in
            1|01) playit_menu ;;
            2|02) fxtunnel_menu ;;
            0|00) break ;;
            *) echo -e "${R}  [!] Error: Command not recognized.${NC}"; sleep 1 ;;
        esac
    done
}

# ==========================================
# ⚙️ MAIN SYSTEM LOOP
# ==========================================

boot_sequence

while true; do
    show_dashboard
    local WIDTH=$(get_term_width)
    
    if [[ "$WIDTH" -lt 68 ]]; then
        # 📱 RESPONSIVE SINGLE COLUMN MENU (For Small Terminals)
        echo -e "${DG}╭─── ${W}SELECT DEPLOYMENT MODULE ${DG}───╮${NC}"
        echo -e "${DG}│${NC} ${P}[1]${NC} 🖥️ Setup VPS & Env"
        echo -e "${DG}│${NC} ${P}[2]${NC} 🎛️ Install Panels"
        echo -e "${DG}│${NC} ${P}[3]${NC} 🦅 Setup Wings"
        echo -e "${DG}│${NC} ${P}[4]${NC} 📜 Tooler Script"
        echo -e "${DG}│${NC} ${P}[5]${NC} 🎨 Theme Editor"
        echo -e "${DG}│${NC} ${P}[6]${NC} 🧹 Optimize Sys"
        echo -e "${DG}│${NC} ${P}[7]${NC} ⚡ Port Forward"
        echo -e "${DG}│${NC} ${P}[8]${NC} 🐍 24/7 Python"
        echo -e "${DG}│${NC} ${P}[9]${NC} ✏️ Edit Tooler Script"
        echo -e "${DG}├──────────────────────────────┤${NC}"
        echo -e "${DG}│${NC} ${R}[0] ❌ SYSTEM EXIT${NC}"
        echo -e "${DG}╰──────────────────────────────╯${NC}"
    else
        # 💻 ORIGINAL DOUBLE COLUMN MENU (For Wide Terminals)
        echo -e "${DG}╭───────────────────── ${W}SELECT DEPLOYMENT MODULE ${DG}─────────────────────╮${NC}"
        echo -e "${DG}│${NC}                                                                    ${DG}│${NC}"
        echo -e "${DG}│${NC}      ${P}[1]${NC} 🖥️ Setup VPS & Env       ${P}[5]${NC} 🎨 Theme Editor             ${DG}│${NC}"
        echo -e "${DG}│${NC}      ${P}[2]${NC} 🎛️ Install Panels        ${P}[6]${NC} 🧹 Optimize Sys             ${DG}│${NC}"
        echo -e "${DG}│${NC}      ${P}[3]${NC} 🦅 Setup Wings            ${P}[7]${NC} ⚡ Port Forward             ${DG}│${NC}"
        echo -e "${DG}│${NC}      ${P}[4]${NC} 📜 Tooler Script          ${P}[8]${NC} 🐍 24/7 Python              ${DG}│${NC}"
        echo -e "${DG}│${NC}                                                                    ${DG}│${NC}"
        echo -e "${DG}│${NC}      ${P}[9]${NC} ✏️ Edit Tooler Script                                     ${DG}│${NC}"
        echo -e "${DG}├────────────────────────────────────────────────────────────────────┤${NC}"
        echo -e "${DG}│${NC}                         ${R}[0] ❌ SYSTEM EXIT${NC}                         ${DG}│${NC}"
        echo -e "${DG}╰────────────────────────────────────────────────────────────────────╯${NC}"
    fi
    echo ""
    
    echo -en "  ${Y}root@skahost${W}:~${C}/home${NC}# "
    read -r mainopt

    case "$mainopt" in
        1|01) bash <(curl -sL https://raw.githubusercontent.com/skahost/code/main/code/Vps/install.sh) ;;
        2|02) bash <(curl -sL https://raw.githubusercontent.com/skahost/code/main/code/Panel/run.sh) ;;
        3|03) bash <(curl -sL https://raw.githubusercontent.com/skahost/Wings-setup/main/code/run.sh) ;;
        4|04) bash <(curl -sL https://raw.githubusercontent.com/skahost/tooler/main/code/run.sh) ;;
        5|05) bash <(curl -sL https://raw.githubusercontent.com/skahost/Theme/main/code/run.sh) ;;
        6|06) bash <(curl -sL https://raw.githubusercontent.com/skahost/code/main/code/ee/run.sh) ;;
        7|07) port_forward_menu; continue ;;
        8|08) python3 <(curl -sL https://raw.githubusercontent.com/JishnuTheGamer/24-7/refs/heads/main/24) ;;
        9|09) bash <(curl -sL https://raw.githubusercontent.com/skahost/code/main/code/Edit tool/System.sh) ;;
        0|00) 
            echo -e ""
            type_effect "${R}  [SYS] Terminating processes...${NC}" 0.03
            type_effect "${DG}  [SYS] Goodbye!${NC}" 0.05
            exit 0 
            ;;
        *) 
            echo -e "${R}  [!] Error: Command not recognized.${NC}"
            sleep 1
            continue
            ;;
    esac

    echo -e "\n${G}  [+] Sequence Completed Successfully!${NC}"
    
    echo -en "  ${Y}root@skahost${W}:~${DG}/sys/pause${NC} (Press ENTER) "
    read -r
done
