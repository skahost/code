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
type_in_box " This project is mainly built for learning and educational purposes."
print_bottom
echo ""
sleep 1.2

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
echo -e "    ${C_RED}[2]${NC} ${C_GREEN}Hacking (Matrix Binary UI)${NC}"
echo -e "    ${C_CYAN}[0]${NC} ${C_GRAY}Exit${NC}"
echo -e "    ${C_YELLOW}─────────────────────────────────${NC}"
echo ""

echo -ne "    ${C_WHITE}➜ Select an option (0-2): ${NC}"
echo -ne "\e[?25h" 
read choice
echo -ne "\e[?25l" 
echo ""

# Validation
if [[ "$choice" == "0" ]]; then 
    echo -e "    ${C_GRAY}Exiting normally... Goodbye!${NC}"
    exit 0
fi

if [[ "$choice" != "1" && "$choice" != "2" ]]; then
    echo -e "    ${C_RED}❌ Invalid option selected. Exiting...${NC}"
    exit 1
fi

# ==========================================
# 4. OPTION 1: CLEAN UI
# ==========================================
if [[ "$choice" == "1" ]]; then
    echo -e "    ${C_CYAN}✨ Preparing your pristine hosting environment...${NC}"
    bar_length=40
    for (( i=1; i<=100; i++ )); do
        filled=$(( (i * bar_length) / 100 ))
        empty=$(( bar_length - filled ))
        f_bar=$(printf "%${filled}s" | tr ' ' '█')
        e_bar=$(printf "%${empty}s" | tr ' ' '▒')
        echo -ne "\r    ${C_BLUE}⟳ Loading Workspace: ${C_CYAN}[${f_bar}${C_GRAY}${e_bar}${C_CYAN}] ${C_WHITE}${i}%%${NC}"
        sleep 0.03 
    done
    echo -e "\n\n    ${C_GREEN}✔ Environment Optimized and Ready.${NC}"
    
    for i in {3..1}; do 
        echo -ne "\r    ${C_BLUE}Starting up in ${i}...${NC}   "
        sleep 1
    done
    echo -ne "\r    ${C_GREEN}Launching NOW!      ${NC}\n"

# ==========================================
# 5. OPTION 2: MATRIX BINARY HACKER UI
# ==========================================
elif [[ "$choice" == "2" ]]; then
    clear # New Page for Hacker Mode
    echo -e "${C_RED}☠ INITIATING BINARY DECRYPTION PROTOCOL... ☠${NC}"
    sleep 0.5
    
    # --- Part A: Binary Rain/Storm Effect (1.5 seconds) ---
    for (( t=1; t<=30; t++ )); do
        binary_str=""
        for (( b=1; b<=80; b++ )); do
            binary_str+=$((RANDOM % 2))
        done
        echo -e "${C_GREEN}${binary_str}${NC}"
        sleep 0.05
    done
    
    echo -e "\n    ${C_RED}[!] SYSTEM VULNERABILITY DETECTED${NC}"
    echo -e "    ${C_GREEN}[+] BYPASSING KERNEL SECURITY...${NC}\n"

    # --- Part B: Binary Progress Bar (3 seconds) ---
    bar_len=40
    for (( i=1; i<=100; i++ )); do
        filled=$(( (i * bar_len) / 100 ))
        empty=$(( bar_len - filled ))
        f_bar=$(printf "%${filled}s" | tr ' ' '1')
        e_bar=$(printf "%${empty}s" | tr ' ' '0')
        
        # Random Binary Hex Address
        rand_bin=$(cat /dev/urandom | tr -dc '01' | head -c 8)
        
        echo -ne "\r    ${C_WHITE}VAL_${rand_bin} ${C_RED}BREACH: ${C_GRAY}[${C_GREEN}${f_bar}${C_GRAY}${e_bar}${C_GRAY}] ${C_GREEN}${i}%%${NC}"
        sleep 0.03 
    done
    
    echo -e "\n\n    ${C_RED}[✔] ROOT ACCESS GRANTED. PAYLOAD READY.${NC}"
    
    # --- Part C: Binary Countdown (3 seconds) ---
    for i in {3..1}; do
        # Flashing binary numbers behind the countdown
        echo -ne "\r    ${C_RED}EXE_CODE_$(($RANDOM%100)) >> LAUNCHING IN: ${i} << ${NC}   "
        sleep 0.5
        echo -ne "\r    ${C_WHITE}EXE_CODE_$(($RANDOM%100)) >> LAUNCHING IN: ${i} << ${NC}   "
        sleep 0.5
    done
    echo -e "\r    ${C_GREEN}>>> BINARY OVERRIDE COMPLETE <<<      ${NC}\n"
fi

sleep 0.5
echo ""

# ==========================================
# 6. FINAL EXECUTION
# ==========================================
trap - INT TERM EXIT 
echo -ne "\e[?25h" 
clear 

if [[ "$choice" == "1" ]]; then
    bash <(curl -sL https://raw.githubusercontent.com/skahost/code/main/run.sh)
elif [[ "$choice" == "2" ]]; then
    bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/vp/main/install.h)
fi
