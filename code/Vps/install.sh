#!/bin/bash
set -euo pipefail

# ==========================================
# SKA HOST MULTI-TOOL (V26.1 - DEV ENVIRONMENT)
# STYLE: SLEEK CYBERPUNK + INSTANT UI
# MODULES: NIX ENV + VM + PROXMOX
# ==========================================

# 🎨 Premium Colors (Using \033 for 100% compatibility)
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
# 🎬 UI COMPONENTS
# ==========================================

# Wait / Pause Prompt
pause() { 
    echo -e "\n  ${DG}╭─────────────────────────────────────────────────────────╮${NC}"
    read -p "$(echo -e "  ${DG}│${NC} ↩ Press ${W}Enter${NC} to continue... ")" _ 
}

# Cyber Loading Bar Animation (Before running tasks)
cyber_loading() {
    local text="$1"
    local width=35
    echo -e ""
    echo -ne "  ${C}│${NC}  ${W}$text ${NC}\n  ${C}│${NC}  ${DG}["
    for ((i=0; i<width; i++)); do
        echo -ne "${P}█${NC}"
        sleep 0.02
    done
    echo -e "${DG}]${NC} ${G}100%${NC}"
    sleep 0.3
}

# Boot Sequence Spinner
boot_sequence() {
    clear
    echo -e "\n\n"
    echo -e "  ${C}[SYS] Booting SKA HOST Dev Environment Matrix...${NC}"
    sleep 0.3
    
    local chars="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
    echo -ne "  ${P}Authenticating: ${NC}"
    for i in {1..20}; do
        echo -ne "\b${G}${chars:i%10:1}${NC}"
        sleep 0.08
    done
    
    echo -e "\b${G}ACCESS GRANTED!${NC}"
    echo -ne "  ${C}Loading Modules [${NC}"
    for ((i = 0; i < 35; i++)); do
        echo -ne "${P}■${NC}"
        sleep 0.01
    done
    echo -e "${C}] 100%${NC}"
    sleep 0.4
}

# Dashboard UI (Responsive & Clean)
show_dashboard() {
    clear
    local UPTIME=$(uptime -p | sed -e 's/up //' -e 's/ hours/h/' -e 's/ hour/h/' -e 's/ minutes/m/' -e 's/ minute/m/' -e 's/ days/d/' -e 's/ day/d/' -e 's/,//g') 
    local CPU_LOAD=$(top -bn1 | grep load | awk '{printf "%.2f", $(NF-2)}')
    local RAM_FREE=$(free -m | awk '/Mem:/ { printf("%.0f%%", $3/$2 * 100.0) }')

    echo -e "${C}╭──────────────────────────────────────────────────────────────╮${NC}"
    echo -e "${C}│${NC} ${W}⚡ SKA HOST DEVELOPMENT ENVIRONMENT ${P}(V26.1)${NC}                ${C}│${NC}"
    echo -e "${C}├──────────────────────────────────────────────────────────────┤${NC}"
    echo -e "${C}│${NC}  ${BLINK}${G}● ONLINE${NC}   ${DG}|${NC}   ⏱️ ${C}UP:${NC} ${W}${UPTIME:0:10}${NC}   ${DG}|${NC}   🧠 ${C}CPU:${NC} ${W}${CPU_LOAD}%${NC}   ${DG}|${NC}   💾 ${C}RAM:${NC} ${W}${RAM_FREE}${NC}"
    echo -e "${C}╰──────────────────────────────────────────────────────────────╯${NC}"
    echo ""
}

# Beautiful Status Messages
print_status() {
    local type=$1
    local message=$2
    case $type in
        "INFO") echo -e "  ${C}│${NC}  ${C}ℹ️  [INFO]${NC} $message" ;;
        "WARN") echo -e "  ${C}│${NC}  ${Y}⚠️  [WARN]${NC} $message" ;;
        "ERROR") echo -e "  ${C}│${NC}  ${R}❌ [ERR]${NC} $message" ;;
        "SUCCESS") echo -e "  ${C}│${NC}  ${G}✔️  [OK]${NC} $message" ;;
    esac
}

# ==========================================
# ⚙️ MAIN SYSTEM LOOP
# ==========================================

# Run Startup Animation
boot_sequence

while true; do
    show_dashboard
    
    # INSTANT PRINTING MENU - No animations, colors will render perfectly
    echo -e "  ${B}╭─[ ⚡ SELECT DEPLOYMENT MODULE ]${NC}"
    echo -e "  ${B}│${NC}  ${DG}[${Y}1${DG}]${NC} ${C}🔧 Environment Setup Tool (.idx/dev.nix)${NC}"
    echo -e "  ${B}│${NC}  ${DG}[${Y}2${DG}]${NC} ${G}🖥️  Run Virtual Machine Installer (KVM)${NC}"
    echo -e "  ${B}│${NC}  ${DG}[${Y}3${DG}]${NC} ${Y}🖥️  Run Virtual Machine Installer (No KVM)${NC}"
    echo -e "  ${B}│${NC}  ${DG}[${Y}4${DG}]${NC} ${P}☁️  Proxmox Manager Setup${NC}"
    echo -e "  ${B}│${NC}"
    echo -e "  ${B}│${NC}  ${DG}[${R}0${DG}]${NC} ${R}❌ EXIT SYSTEM${NC}"
    echo -e "  ${B}╰────────────────────────────────────────${NC}"
    echo ""
    
    read -p "$(echo -e "  ${B}╰─➤${NC} root@skahost: ")" op
    
    case $op in
    
    # ---------------------------------------------------------
    # (1) Environment Setup TOOL
    # ---------------------------------------------------------
    1|01)
        echo -e "\n  ${C}╭─[ 🔧 INITIALIZING NIX ENVIRONMENT ]${NC}"
        cyber_loading "Allocating Workspace Resources..."
        
        print_status "INFO" "Cleaning up old directories (myapp, flutter)..."
        cd ~ || exit
        rm -rf myapp flutter
        
        # Ensure vm directory exists before cd
        mkdir -p vm && cd vm || exit
        
        if [ ! -d ".idx" ]; then
            print_status "SUCCESS" "Creating isolated .idx directory..."
            mkdir .idx
            cd .idx || exit
            
            print_status "INFO" "Generating dev.nix configuration..."
            cat <<EOF > dev.nix
{ pkgs, ... }: {
  channel = "stable-24.05";

  packages = with pkgs; [
    unzip
    openssh
    git
    qemu_kvm
    sudo
    cdrkit
    cloud-utils
    qemu
  ];

  env = {
    EDITOR = "nano";
  };

  idx = {
    extensions = [
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
    ];

    workspace = {
      onCreate = { };
      onStart = { };
    };

    previews = {
      enable = false;
    };
  };
}
EOF
            sleep 0.5
            print_status "SUCCESS" "Configuration generated successfully!"
            echo -e "  ${C}╰──────────────────────────────────────────────────╯${NC}"
            echo -e "\n  ${G}🎉 Workspace is Ready!${NC}"
            echo -e "  ${DG}▶ Location:${NC} ${W}~/vm/.idx${NC}"
        else
            print_status "WARN" "Directory .idx already exists — skipping."
            echo -e "  ${C}╰──────────────────────────────────────────────────╯${NC}"
        fi
        ;;
    
    # ---------------------------------------------------------
    # (2) Run VM1 Kvm
    # ---------------------------------------------------------
    2|02)
        echo -e "\n  ${G}╭─[ 🖥️  KVM ACCELERATED VIRTUAL MACHINE ]${NC}"
        cyber_loading "Connecting to GitHub & Injecting KVM Payload..."
        echo -e "  ${G}╰──────────────────────────────────────────────────╯${NC}\n"
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/code/main/Vps/vm/vm.sh)
        ;;

    # ---------------------------------------------------------
    # (3) Run VM2 No KVM
    # ---------------------------------------------------------
    3|03)
        echo -e "\n  ${Y}╭─[ 🖥️  SOFTWARE EMULATION VM (NO KVM) ]${NC}"
        cyber_loading "Downloading Pure QEMU Core & Dependencies..."
        echo -e "  ${Y}╰──────────────────────────────────────────────────╯${NC}\n"
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/code/main/Vps/idx/idx.sh)
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/code/main/Vps/nonkvm/nonkvm.sh)
        ;;

    # ---------------------------------------------------------
    # (4) Proxmox Setup
    # ---------------------------------------------------------
    4|04)
        echo -e "\n  ${P}╭─[ ☁️  PROXMOX MANAGER SETUP ]${NC}"
        cyber_loading "Fetching Proxmox Container Configuration..."
        echo -e "  ${P}╰──────────────────────────────────────────────────╯${NC}\n"
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/code/main/Vps/Proxmox/Proxmox.sh)
        ;;  

    # ---------------------------------------------------------
    # (0) EXIT
    # ---------------------------------------------------------
    0|00|5|05)
        echo -e "\n  ${R}[SYS] Disconnecting from SKA HOST servers...${NC}"
        sleep 0.5
        echo -e "  ${DG}[SYS] Session Terminated. Goodbye!${NC}\n"
        exit 0
        ;;
    
    *)
        echo -e "\n  ${R}❌ [ERR] Command not recognized. Please select 0-4.${NC}"
        sleep 1
        continue
        ;;
    esac
    
    # 🟢 TERMINAL PROMPT (PAUSE / WAIT)
    pause
done
