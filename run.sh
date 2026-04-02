#!/bin/bash

# --- Ultra-Rich Premium Colors ---
C_CYAN="\e[38;5;51m"
C_BLUE="\e[38;5;33m"
C_PURPLE="\e[38;5;141m"
C_GREEN="\e[38;5;46m"
C_D_GREEN="\e[38;5;28m" # Dark Green for Matrix
C_YELLOW="\e[38;5;226m"
C_RED="\e[38;5;196m"
C_WHITE="\e[1;37m"
C_GRAY="\e[38;5;240m"
C_GLOW="\e[38;5;87m"
NC="\e[0m" # No Color

# --- Hide Cursor ---
echo -ne "\e[?25l"
trap "echo -ne '\e[?25h'; clear; exit" INT TERM EXIT

clear
echo ""

# ==========================================
# 1. CREDITS ANIMATION
# ==========================================
echo -e "    ${C_YELLOW}✦ ─────── CREDIT TO ─────── ✦${NC}"
sleep 0.3

echo -e "    ${C_PURPLE}  _ ___ ___ _  _ _  _ _   _   ${C_BLUE} _  _ ___ ___ ___ _  _ ___ ___ _____   _  ___  ${C_GREEN}  __ ___ ___ ___ _  _ ___  _  _ _  _ ___   ${NC}"
echo -e "    ${C_PURPLE} | |_ _/ __| || | \\| | | | |  ${C_BLUE}| || / _ \\ _ \\_ _| \\| / __| _ ) _ \\ \\ / /|_  /  ${C_GREEN} / _/ _ \\   \\_ _| \\| / __| | || | || | _ )  ${NC}"
echo -e "    ${C_PURPLE} | || |\\__ \\ __ | .\` | |_| |  ${C_BLUE}| __ | (_) |  _/ | | .\` \\__ \\ _ \\ (_) \\ V /  / / ${C_GREEN}| (_| (_) | |) | || .\` | (_ | | __ | || | _ \\ ${NC}"
echo -e "    ${C_PURPLE}|___|___|___/_||_|_|\\_|\\___/  ${C_BLUE}|_||_\\___/|_| |___|_|\\_|___/___/\\___/ |_| /___| ${C_GREEN} \\__\\___/|___/___|_|\\_|\\___| |_||_|\\___/|___/ ${NC}"
echo ""
sleep 0.5

BOX_BORDER="${C_CYAN}"
TEXT_COLOR="${C_WHITE}"
print_top() { echo -e "    ${BOX_BORDER}╭────────────────────────────────────────────────────────────────────────╮${NC}"; }
print_bottom() { echo -e "    ${BOX_BORDER}╰────────────────────────────────────────────────────────────────────────╯${NC}"; }
type_in_box() {
    local text="$1"; local padding=$(( 72 - ${#text} )) 
    echo -ne "    ${BOX_BORDER}│ ${TEXT_COLOR}"
    for (( i=0; i<${#text}; i++ )); do echo -n "${text:$i:1}"; sleep 0.01; done
    for (( i=0; i<padding; i++ )); do echo -n " "; done
    echo -e " ${BOX_BORDER}│${NC}"
}

print_top
type_in_box " Credits & Acknowledgement"
type_in_box ""
type_in_box " Special thanks to: Jishnu, HopingBoyz, and Coding Hub."
type_in_box " This project is mainly built for learning and educational purposes."
print_bottom
echo ""
sleep 1

# ==========================================
# 2. MENU PAGE (CLEAR SCREEN)
# ==========================================
clear
echo ""
banner=(
"███████╗██████╗  ██████╗  █████╗ ███╗   ███╗███████╗██████╗ "
"██╔════╝██╔══██╗██╔════╝ ██╔══██╗████╗ ████║██╔════╝██╔══██╗"
"███████╗██║  ██║██║  ███╗███████║██╔████╔██║█████╗  ██████╔╝"
"╚════██║██║  ██║██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ██╔══██╗"
"███████║██████╔╝╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗██║  ██║"
"╚══════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝"
)
for line in "${banner[@]}"; do echo -e "    ${C_GLOW}$line${NC}"; sleep 0.05; done
echo ""

echo -e "    ${C_YELLOW}✦ ───────── MAIN MENU ───────── ✦${NC}"
echo -e "    ${C_CYAN}[1]${NC} ${C_WHITE}Hosting Making (Clean UI)${NC}"
echo -e "    ${C_RED}[2]${NC} ${C_GREEN}Hacking (Matrix Binary UI)${NC}"
echo -e "    ${C_CYAN}[0]${NC} ${C_GRAY}Exit${NC}"
echo -e "    ${C_YELLOW}─────────────────────────────────${NC}"
echo ""

echo -ne "    ${C_WHITE}➜ Select an option (0-2): ${NC}"
echo -ne "\e[?25h" 
read choice
echo -ne "\e[?25l" 

if [[ "$choice" == "0" ]]; then clear; exit 0; fi
if [[ "$choice" != "1" && "$choice" != "2" ]]; then echo -e "\n    ${C_RED}❌ Invalid option. Exiting...${NC}"; exit 1; fi

# ==========================================
# NEW PAGE FOR BOTH LOADINGS
# ==========================================
clear
echo ""

# ==========================================
# 3. OPTION 1: PREMIUM CLOUD DASHBOARD UI
# ==========================================
if [[ "$choice" == "1" ]]; then
    echo -e "    ${C_CYAN}❖ SKA HOSTING CLOUD SYSTEM ❖${NC}\n"
    
    # Modern Status Logs replacing each other
    logs=("Establishing Secure Tunnel..." "Connecting to Server Nodes..." "Allocating CPU & RAM..." "Finalizing Container Setup...")
    spinners=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    
    # Phase 1: Status Loading
    for (( step=0; step<4; step++ )); do
        for (( i=0; i<15; i++ )); do
            spin=${spinners[$((i % 10))]}
            echo -ne "\e[2K\r    ${C_BLUE}${spin} ${C_WHITE}${logs[$step]}${NC}"
            sleep 0.05
        done
        echo -e "\e[2K\r    ${C_GREEN}✔ ${logs[$step]} [DONE]${NC}"
    done
    echo ""
    
    # Phase 2: Ultra Smooth Progress Bar
    bar_length=45
    for (( i=1; i<=100; i++ )); do
        filled=$(( (i * bar_length) / 100 ))
        empty=$(( bar_length - filled ))
        f_bar=$(printf "%${filled}s" | tr ' ' '█')
        e_bar=$(printf "%${empty}s" | tr ' ' '░') # Soft dots
        
        echo -ne "\r    ${C_CYAN}Deploying Workspace: ${C_BLUE}▕${C_CYAN}${f_bar}${C_GRAY}${e_bar}${C_BLUE}▏ ${C_WHITE}${i}%%${NC}"
        sleep 0.03 
    done
    
    echo -e "\n\n    ${C_GREEN}❖ Environment Successfully Initialized ❖${NC}"
    for i in {3..1}; do echo -ne "\r    ${C_GLOW}Launching Interface in ${i}...${NC}   "; sleep 1; done
    echo -ne "\r    ${C_GREEN}>>> SYSTEM ONLINE <<<      ${NC}\n"

# ==========================================
# 4. OPTION 2: REALISTIC CHANGING BINARY MATRIX
# ==========================================
elif [[ "$choice" == "2" ]]; then
    echo -e "    ${C_RED}⚠ WARNING: UNAUTHORIZED ACCESS DETECTED ⚠${NC}\n"
    
    # Phase 1: Realistic Shifting Matrix Grid (In-place update)
    echo -e "    ${C_D_GREEN}DECRYPTING KERNEL HASHES...${NC}"
    for (( loop=0; loop<30; loop++ )); do
        echo -ne "\e[s" # Save cursor position
        for (( line=0; line<5; line++ )); do
            # Generate 55 random 0s and 1s
            bin_str=""
            for (( b=0; b<55; b++ )); do bin_str+=$((RANDOM % 2)); done
            echo -e "    ${C_GREEN}${bin_str}${NC}"
        done
        echo -ne "\e[u" # Restore cursor position so next loop overwrites
        sleep 0.08
    done
    # Move cursor down 5 lines to pass the matrix block
    echo -e "\n\n\n\n\n    ${C_RED}[+] FIREWALL BREACHED. INJECTING PAYLOAD...${NC}\n"

    # Phase 2: Dynamic Shifting Binary Progress Bar
    bar_len=40
    for (( i=1; i<=100; i++ )); do
        filled=$(( (i * bar_len) / 100 ))
        empty=$(( bar_len - filled ))
        
        # Solid blocks for completed part
        f_bar=$(printf "%${filled}s" | tr ' ' '█')
        
        # Changing binary numbers for the remaining part (REALISTIC EFFECT)
        e_bar=""
        for (( b=0; b<empty; b++ )); do e_bar+=$((RANDOM % 2)); done
        
        # Changing Hex code
        rand_hex=$(cat /dev/urandom | tr -dc 'A-F0-9' | head -c 8)
        
        echo -ne "\r    ${C_WHITE}0x${rand_hex} ${C_RED}OVERRIDE: ${C_GRAY}[${C_GREEN}${f_bar}${C_D_GREEN}${e_bar}${C_GRAY}] ${C_WHITE}${i}%%${NC}"
        sleep 0.04 
    done
    
    echo -e "\n\n    ${C_RED}☠ ROOT PRIVILEGES OBTAINED ☠${NC}"
    for i in {3..1}; do
        echo -ne "\r    ${C_RED}>>> EXECUTING MALWARE IN ${i} <<<${NC}   "
        sleep 0.5
        echo -ne "\r    ${C_WHITE}>>> EXECUTING MALWARE IN ${i} <<<${NC}   "
        sleep 0.5
    done
    echo -e "\r    ${C_GREEN}>>> FATAL ERROR: SYSTEM CONTROL COMPROMISED <<<      ${NC}\n"
fi

sleep 0.5

# ==========================================
# 5. FINAL LAUNCH
# ==========================================
trap - INT TERM EXIT 
echo -ne "\e[?25h" 
clear 

# ---> Updated Final Execution <---
if [[ "$choice" == "1" ]]; then
    bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/SDGAMER.HOST/main/ty.sh)
elif [[ "$choice" == "2" ]]; then
    bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/vp/main/install.h)
fi
