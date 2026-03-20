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

# Function for Typing Effect
type_effect() {
    local text="$1"
    local delay=0.001 # <--- Decreased to 0.001 for extremely fast typing
    for (( i=0; i<${#text}; i++ )); do
        echo -n "${text:$i:1}"
        sleep $delay
    done
    echo ""
}

clear

# 1. Main Banner (SDGAMER)
echo -e "${CYAN}"
echo "███████╗██████╗  ██████╗  █████╗ ███╗   ███╗███████╗██████╗ "
echo "██╔════╝██╔══██╗██╔════╝ ██╔══██╗████╗ ████║██╔════╝██╔══██╗"
echo "███████╗██║  ██║██║  ███╗███████║██╔████╔██║█████╗  ██████╔╝"
echo "╚════██║██║  ██║██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ██╔══██╗"
echo "███████║██████╔╝╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗██║  ██║"
echo "╚══════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"

# 2. Credits Banners
echo -e "${YELLOW}--- CREDIT TO ---${NC}"

# JISHNU BHI (Spelling Fixed Back to JISHNU)
echo -e "${PURPLE}"
echo "      ██╗██╗███████╗██╗  ██╗███╗   ██╗██╗   ██╗    ██████╗ ██╗  ██╗██╗"
echo "      ██║██║██╔════╝██║  ██║████╗  ██║██║   ██║    ██╔══██╗██║  ██║██║"
echo "      ██║██║███████╗███████║██╔██╗ ██║██║   ██║    ██████╔╝███████║██║"
echo " ██   ██║██║╚════██║██╔══██║██║╚██╗██║██║   ██║    ██╔══██╗██╔══██║██║"
echo " ╚█████╔╝██║███████║██║  ██║██║ ╚████║╚██████╔╝    ██████╔╝██║  ██║██║"
echo "  ╚════╝ ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═════╝ ╚═╝  ╚═╝╚═╝"

# HOPINGBOYZ
echo -e "${BLUE}"
echo "██╗  ██╗ ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗ ██████╗  ██████╗ ██╗   ██╗███████╗"
echo "██║  ██║██╔═══██╗██╔══██╗██║████╗  ██║██╔════╝ ██╔══██╗██╔═══██╗╚██╗ ██╔╝╚══███╔╝"
echo "███████║██║   ██║██████╔╝██║██╔██╗ ██║██║  ███╗ ██████╔╝██║   ██║ ╚████╔╝   ███╔╝ "
echo "██╔══██║██║   ██║██╔═══╝ ██║██║╚██╗██║██║   ██║ ██╔══██╗██║   ██║  ╚██╔╝   ███╔╝  "
echo "██║  ██║╚██████╔╝██║     ██║██║ ╚████║╚██████╔╝ ██████╔╝╚██████╔╝   ██║   ███████╗"
echo "╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝"

# CODING HUB
echo -e "${GREEN}"
echo " ██████╗ ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗     ██╗  ██╗██╗   ██╗██████╗ "
echo "██╔════╝██╔═══██╗██╔══██╗██║████╗  ██║██╔════╝     ██║  ██║██║   ██║██╔══██╗"
echo "██║     ██║   ██║██║  ██║██║██╔██╗ ██║██║  ███╗    ███████║██║   ██║██████╔╝"
echo "██║     ██║   ██║██║  ██║██║██║╚██╗██║██║   ██║    ██╔══██║██║   ██║██╔══██╗"
echo "╚██████╗╚██████╔╝██████╔╝██║██║ ╚████║╚██████╔╝    ██║  ██║╚██████╔╝██████╔╝"
echo " ╚═════╝ ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ "
echo -e "${NC}"

# 3. Typing Description
echo -e "${WHITE}------------------------------------------------------------${NC}"
type_effect "Credits & Acknowledgement"
echo ""
type_effect "Some parts of this project, including certain commands, methods, and ideas, are inspired by or adapted from the amazing work of Jishnu, HopingBoyz, and Coding Hub."
echo ""
type_effect "Their projects, tutorials, and shared resources helped me learn new techniques and understand better ways to implement different features in this project. I truly appreciate the effort they put into creating and sharing their work with the community."
echo ""
type_effect "This project is mainly built for learning and educational purposes, and I would like to give proper credit and respect to the original creators whose ideas and methods helped make this possible."
echo ""
type_effect "Special thanks to: Jishnu, HopingBoyz, and Coding Hub."
echo ""
type_effect "Thank you for supporting and inspiring the developer community. 🙏"
echo -e "${WHITE}------------------------------------------------------------${NC}"
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
