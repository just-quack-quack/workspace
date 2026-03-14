#!/bin/bash
# Animated full screen visualization

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

while true; do
    clear

    # Get terminal dimensions
    COLS=$(tput cols)
    ROWS=$(tput lines)

    # Draw top border with pulsing color
    for ((i=1; i<=COLS; i++)); do
        printf "${CYAN}="
    done
    printf "${NC}\n"

    # Calculate positions
    duck_y=$(( ROWS / 2 - 5 ))
    title_y=$(( ROWS / 4 ))
    duck_x=$(( (COLS - 30) / 2 ))

    # Title with pulsing
    if [ $(( $(date +%s) % 2 )) -eq 0 ]; then
        TITLE_COLOR="$MAGENTA"
    else
        TITLE_COLOR="$CYAN"
    fi

    tput cup $((title_y)) $(( (COLS - 30) / 2 ))
    printf "${TITLE_COLOR}    🦆 WELCOME, BINH! 🦆    ${NC}"

    # Animated wave under title
    wave=$(( ($(date +%s) * 2) % 20 ))
    tput cup $((title_y + 2)) 0
    for ((i=0; i<COLS; i++)); do
        pos=$(( (i + wave) % 20 ))
        case $pos in
            0|1|2) printf "${BLUE}~${NC}" ;;
            3|4|5) printf "${CYAN}~${NC}" ;;
            6|7|8) printf "${GREEN}~${NC}" ;;
            9|10) printf "${YELLOW}~${NC}" ;;
            *) printf " " ;;
        esac
    done
    printf "\n"

    # Duck art (centered)
    tput cup $duck_y $duck_x
    printf "${MAGENTA}"
    cat << 'DUCK'
         __
      __/  \__
     /  \__/  \
    /          \
   /   /  \    \
  /___/    \____\
DUCK

    # Status indicators with animation
    status_y=$(( duck_y + 10 ))
    tput cup $status_y $(( (COLS - 50) / 2 ))
    printf "${GREEN}✓${NC} Audio Transcription: "

    if [ $(( $(date +%s) % 3 )) -eq 0 ]; then
        printf "${GREEN}● ACTIVE${NC}\n"
    else
        printf "${GREEN}  ACTIVE${NC}\n"
    fi

    tput cup $((status_y + 1)) $(( (COLS - 50) / 2 ))
    printf "${GREEN}✓${NC} GitHub: ${BLUE}just-quack-quack${NC}\n"

    tput cup $((status_y + 2)) $(( (COLS - 50) / 2 ))
    printf "${GREEN}✓${NC} Time: ${YELLOW}$(date '+%H:%M:%S')${NC}\n"

    # Animated sparkles
    for ((i=0; i<10; i++)); do
        x=$(( (RANDOM % COLS) ))
        y=$(( (RANDOM % (ROWS - 5)) + 2 ))
        color=(${RED} ${GREEN} ${YELLOW} ${BLUE} ${MAGENTA} ${CYAN})
        c=${color[$((RANDOM % 6))]}
        tput cup $y $x
        printf "${c}*${NC}"
    done

    # Bottom border
    tput cup $((ROWS - 3)) 0
    for ((i=1; i<=COLS; i++)); do
        printf "${CYAN}="
    done
    printf "${NC}\n"

    tput cup $((ROWS - 2)) $(( (COLS - 40) / 2 ))
    printf "${YELLOW}Press Ctrl+C to stop | quack! 🦆${NC}"

    sleep 0.3
done
