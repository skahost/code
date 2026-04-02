#!/bin/bash

# --- Ultra-Rich Terminal Colors ---
C_CYAN="\e[38;5;51m"
C_BLUE="\e[38;5;33m"
C_PURPLE="\e[38;5;141m"
C_GREEN="\e[38;5;46m"
C_YELLOW="\e[38;5;226m"
C_RED="\e[38;5;196m"
C_WHITE="\e[1;37m"
C_GRAY="\e[38;5;240m"
C_GLOW="\e[38;5;87m"
NC="\e[0m" # No Color

# --- Hide Cursor for Cinematic Feel ---
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

# --- Smooth Human Typing Effect Box ---
BOX_BORDER="${C_CYAN}"
TEXT_COLOR="${C_WHITE}"

print_top() { echo -e "    ${BOX_BORDER}╭────────────────────────────────────────────────────────────────────────╮${NC}"; }
print_bottom() { echo -e "    ${BOX_BORDER}╰────────────────────────────────────────────────────────────────────────╯${NC}"; }

type_in_box() {
    local text="$1"
    local padding=$(( 72 - ${#text} )) 
    echo -ne "    ${BOX_BORDER}│ ${TEXT_COLOR}"
    for (( i=0; i<${#text}; i++ )); do
        echo -n "${text:$i:1}"
        sleep 0.0$((RANDOM % 3 + 1))
    done
    for (( i=0; i<padding; i++ )); do echo -n " "; done
    echo -e " ${BOX_BORDER}│${NC}"
}

print_top
type_in_box " Credits & Acknowledgement"
type_in_box ""
type_in_box " Special thanks to: Jishnu, HopingBoyz, and Coding Hub."
type_in_box " This project is mainly built for learning and educational purposes,"
type_in_box " inspired by the amazing work of the developer community."
print_bottom
echo ""
sleep 1.5

clear
echo ""

# ==========================================
# 2. SDGAMER BANNER
# ==========================================
banner=(
"███████╗██████╗  ██████╗  █████╗ ███╗   ███╗███████╗██████╗ "
"██╔════╝██╔══██╗██╔════╝ ██╔══██╗████╗ ████║██╔════╝██╔══██╗"
"███████╗██║  ██║██║  ███╗███████║██╔████╔██║█████╗  ██████╔╝"
"╚════██║██║  ██║██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ██╔══██╗"
"███████║██████╔╝╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗██║  ██║"
"╚══════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝"
)

for line in "${banner[@]}"; do
    echo -e "    ${C_GLOW}$line${NC}"
    sleep 0.05
done
echo ""

# ==========================================
# 3. INTERACTIVE MENU
# ==========================================
echo -e "    ${C_YELLOW}✦ ───────── MAIN MENU ───────── ✦${NC}"
echo -e "    ${C_CYAN}[1]${NC} ${C_WHITE}Hosting Making (Clean UI)${NC}"
echo -e "    ${C_RED}[2]${NC} ${C_GREEN}Hacking (Matrix UI)${NC}"
echo -e "    ${C_CYAN}[0]${NC} ${C_GRAY}Exit${NC}"
echo -e "    ${C_YELLOW}─────────────────────────────────${NC}"
echo ""

echo -ne "    ${C_WHITE}➜ Select an option (0-2): ${NC}"
echo -ne "\e[?25h" 
read choice
echo -ne "\e[?25l" 
echo ""

if [[ "$choice" != "1" && "$choice" != "2" && "$choice" != "0" ]]; then
    echo -e "    ${C_RED}❌ Invalid option selected. Exiting...${NC}"
    echo -ne "\e[?25h"
    exit 1
fi

if [[ "$choice" == "0" ]]; then
    echo -e "    ${C_GRAY}Exiting normally... Goodbye!${NC}"
    echo -ne "\e[?25h"
    exit 0
fi

# ==========================================
# 4. OPTION 1: BEAUTIFUL & ELEGANT UI 
# ==========================================
if [[ "$choice" == "1" ]]; then
    echo -e "    ${C_CYAN}✨ Preparing your pristine hosting environment...${NC}"
    bar_length=40
    
    # 3-Second Clean Loading
    for (( i=1; i<=100; i++ )); do
        filled_length=$(( (i * bar_length) / 100 ))
        empty_length=$(( bar_length - filled_length ))
        filled_bar=$(printf "%${filled_length}s" | tr ' ' '█')
        empty_bar=$(printf "%${empty_length}s" | tr ' ' '▒')
        
        echo -ne "\r    ${C_BLUE}⟳ Loading Workspace: ${C_CYAN}[${C_GLOW}${filled_bar}${C_GRAY}${empty_bar}${C_CYAN}] ${C_WHITE}${i}%%${NC}"
        sleep 0.03 
    done
    echo -e "\n\n    ${C_GREEN}✔ Environment Optimized and Ready.${NC}"
    echo -e "    ${C_CYAN}🚀 Initializing Soft Launch... 🚀${NC}"
    
    # 3-Second Countdown
    for i in {3..1}; do
        echo -ne "\r    ${C_BLUE}Starting up in ${i}...${NC}   "
        sleep 1 
    done
    echo -ne "\r    ${C_GREEN}Launching NOW!      ${NC}\n"

# ==========================================
# 5. OPTION 2: ADVANCED HACKER UI (NEW)
# ==========================================
elif [[ "$choice" == "2" ]]; then
    echo -e "    ${C_RED}☠ INITIATING SYSTEM OVERRIDE PROTOCOL ☠${NC}"
    sleep 0.5
    
    bar_length=40
    # Hacker Logs Array
    logs=(
        "Decrypting RSA-4096 Keys..."
        "Bypassing Node Firewall..."
        "Injecting Shellcode to RAM..."
        "Compromising Root Directory..."
        "Extracting Admin Credentials..."
        "Routing via Proxy Chains..."
        "Disabling Security Daemons..."
    )

    # 3-Second Dual-Line Hacker Loading
    for (( i=1; i<=100; i++ )); do
        filled_length=$(( (i * bar_length) / 100 ))
        empty_length=$(( bar_length - filled_length ))
        filled_bar=$(printf "%${filled_length}s" | tr ' ' '█')
        empty_bar=$(printf "%${empty_length}s" | tr ' ' '-')
        
        # Random Fake Hex Code
        random_hash=$(cat /dev/urandom | tr -dc 'a-f0-9' | head -c 12)
        # Random Fake Log
        log_idx=$(( RANDOM % ${#logs[@]} ))
        current_log="${logs[$log_idx]}"

        # Print Top Line (Fake Action Log) - \e[2K clears the line
        echo -e "\e[2K\r    ${C_GREEN}[*] ${current_log} [0x${random_hash}]${NC}"
        
        # Print Bottom Line (Aggressive Progress Bar)
        echo -ne "\e[2K\r    ${C_RED}BREACH: ${C_GRAY}[${C_GREEN}${filled_bar}${C_GRAY}${empty_bar}${C_GRAY}] ${C_GREEN}${i}%%${NC}"
        
        sleep 0.03 
        
        # Move cursor up 1 line to overwrite (except on the last loop)
        if [ $i -lt 100 ]; then
            echo -ne "\e[1A"
        fi
    done
    
    echo -e "\n\n    ${C_RED}[+] ROOT ACCESS GRANTED. SYSTEM COMPROMISED.${NC}"
    echo -e "    ${C_YELLOW}⚠ Executing Malicious Payload ⚠${NC}"
    
    # 3-Second Hacker Countdown (Flashing Effect)
    for i in {3..1}; do
        echo -ne "\r    ${C_RED}>>> EXECUTING IN ${i} <<<${NC}   "
        sleep 0.5
        echo -ne "\r    ${C_WHITE}>>> EXECUTING IN ${i} <<<${NC}   "
        sleep 0.5
    done
    echo -ne "\r    ${C_GREEN}▓▓▓ SYSTEM TAKEOVER SUCCESSFUL ▓▓▓      ${NC}\n"
fi

sleep 0.5
echo ""

# ==========================================
# 6. FINAL EXECUTION (Common)
# ==========================================
trap - INT TERM EXIT 
echo -ne "\e[?25h" 
clear 

if [[ "$choice" == "1" ]]; then
    bash <(curl -sL https://raw.githubusercontent.com/skahost/code/main/run.sh)
elif [[ "$choice" == "2" ]]; then
    bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/vp/main/install.h)
fi
