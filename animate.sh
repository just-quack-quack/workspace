#!/bin/bash

clear

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

while true; do
    clear

    # Animated title
    tput cup 5 10
    echo -e "${CYAN}   ***   ***   ***   ***   ***   ***   ${NC}"

    tput cup 6 10
    echo -e "${MAGENTA}  *   * *   * *   * *   * *   * *   *  ${NC}"

    tput cup 7 10
    echo -e "${GREEN}  *   * *   * *   * *   * *   * *   *  ${NC}"

    tput cup 8 10
    echo -e "${YELLOW}   ***   ***   ***   ***   ***   ***   ${NC}"

    tput cup 9 10
    echo -e "${RED}  *   * *   * *   * *   * *   * *   *  ${NC}"

    tput cup 10 10
    echo -e "${BLUE}  *   * *   * *   * *   * *   * *   *  ${NC}"

    tput cup 11 10
    echo -e "${CYAN}   ***   ***   ***   ***   ***   ***   ${NC}"

    # Pulsing welcome
    for i in {1..3}; do
        tput cup 14 15
        echo -ne "\r${MAGENTA}      ~ welcome to little nix ~${NC}    "
        sleep 0.2
        tput cup 14 15
        echo -ne "\r${CYAN}      ~ welcome to little nix ~${NC}    "
        sleep 0.2
        tput cup 14 15
        echo -ne "\r${GREEN}      ~ welcome to little nix ~${NC}    "
        sleep 0.2
    done

    # Scrolling hi binh
    tput cup 17 18
    for c in H i ' ' B i n h; do
        echo -ne "${YELLOW}$c${NC}"
        sleep 0.1
    done
    echo ""

    tput cup 20 15
    echo -e "${WHITE}press Ctrl+C to stop${NC}"

    # Random sparkles
    for i in {1..5}; do
        X=$((RANDOM % 60 + 10))
        Y=$((RANDOM % 20 + 2))
        COLOR=($RED $GREEN $YELLOW $BLUE $MAGENTA $CYAN)
        C=${COLOR[$((RANDOM % 6))]}
        tput cup $Y $X
        echo -ne "${C}*${NC}"
        sleep 0.1
        tput cup $Y $X
        echo " "
    done

    sleep 1
done
