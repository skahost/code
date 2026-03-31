#!/bin/bash

# Color Codes
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
WHITE='\033[1;37m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Box Drawing Functions
print_top() {
    echo -e "${WHITE}┌──────────────────────────────────────────────────────────────────────────────┐${NC}"
}

print_bottom() {
    echo -e "${WHITE}└──────────────────────────────────────────────────────────────────────────────┘${NC}"
}

# Function for Typing Effect inside the Box
type_in_box() {
    local text="$1"
    local text_len=${#text}
    # Calculate spaces needed to keep the right border perfectly aligned (Total inner width 76)
    local padding=$(( 76 - text_len )) 

    echo -ne "${WHITE}│ ${NC}"
    local delay=0.001
    for (( i=0; i<${#text}; i++ )); do
        echo -n "${text:$i:1}"
        sleep $delay
    done

    # Add spaces for padding
    for (( i=0; i<padding; i++ )); do
        echo -n " "
    done
    echo -e "${WHITE} │${NC}"
}

clear

# 1. Main Banner (SDGAMER) - Normal Size
echo -e "${CYAN}"
echo "███████╗██████╗  ██████╗  █████╗ ███╗   ███╗███████╗██████╗ "
echo "██╔════╝██╔══██╗██╔════╝ ██╔══██╗████╗ ████║██╔════╝██╔══██╗"
echo "███████╗██║  ██║██║  ███╗███████║██╔████╔██║█████╗  ██████╔╝"
echo "╚════██║██║  ██║██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ██╔══██╗"
echo "███████║██████╔╝╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗██║  ██║"
echo "╚══════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"

# 2. Credits Banners (JISHNU, HOPINGBOYZ, CODING HUB - SIDE BY SIDE - SMALL SIZE)
echo -e "${YELLOW}--- CREDIT TO ---${NC}"

echo -e "${PURPLE}  _ ___ ___ _  _ _  _ _   _   ${BLUE} _  _ ___ ___ ___ _  _ ___ ___ _____   _  ___  ${GREEN}  __ ___ ___ ___ _  _ ___  _  _ _  _ ___   ${NC}"
echo -e "${PURPLE} | |_ _/ __| || | \| | | | |  ${BLUE}| || / _ \ _ \_ _| \| / __| _ ) _ \ \ / /|_  /  ${GREEN} / _/ _ \   \_ _| \| / __| | || | || | _ )  ${NC}"
echo -e "${PURPLE} | || |\__ \ __ | .\` | |_| |  ${BLUE}| __ | (_) |  _/ | | .\` \__ \ _ \ (_) \ V /  / / ${GREEN}| (_| (_) | |) | || .\` | (_ | | __ | || | _ \\ ${NC}"
echo -e "${PURPLE}|___|___|___/_||_|_|\_|\___/  ${BLUE}|_||_\___/|_| |___|_|\_|___/___/\___/ |_| /___| ${GREEN} \__\___/|___/___|_|\_|\___| |_||_|\___/|___/ ${NC}"
echo ""

# 3. Typing Description inside a Perfect Box
print_top
type_in_box "Credits & Acknowledgement"
type_in_box ""
type_in_box "Some parts of this project, including certain commands, methods, and"
type_in_box "ideas, are inspired by or adapted from the amazing work of Jishnu,"
type_in_box "HopingBoyz, and Coding Hub."
type_in_box ""
type_in_box "Their projects, tutorials, and shared resources helped me learn new"
type_in_box "techniques and understand better ways to implement different features"
type_in_box "in this project. I truly appreciate the effort they put into creating"
type_in_box "and sharing their work with the community."
type_in_box ""
type_in_box "This project is mainly built for learning and educational purposes,"
type_in_box "and I would like to give proper credit and respect to the original"
type_in_box "creators whose ideas and methods helped make this possible."
type_in_box ""
type_in_box "Special thanks to: Jishnu, HopingBoyz, and Coding Hub."
type_in_box ""
type_in_box "Thank you for supporting and inspiring the developer community. 🙏"
print_bottom
echo ""

# 4. Countdown
echo -e "${CYAN}Link is copying...${NC}"
sleep 1.5

for i in {3..1}; do
    echo -ne "${RED}Launching in $i...${NC}\r"
    sleep 1
done
echo -e "${GREEN}Launching Now!          ${NC}"
echo ""

# 5. Execution
bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/SDGAMER.HOST/main/ty.sh)
