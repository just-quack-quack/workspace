#!/bin/bash
# Full screen visualization for binh's screen

# Clear screen
clear

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Get terminal dimensions
COLS=$(tput cols)
ROWS=$(tput lines)

# Function to draw centered text
center_text() {
    local text="$1"
    local color="$2"
    local len=${#text}
    local padding=$(( (COLS - len) / 2 ))
    printf "${color}%*s%s%*s${NC}\n" $padding '' "$text" $padding ''
}

# Function to draw border
draw_border() {
    local color="$1"
    printf "${color}"
    for ((i=1; i<=COLS; i++)); do
        printf "="
    done
    printf "${NC}\n"
}

# Initial screen
draw_border "$CYAN"

# Title section
for ((i=1; i<=3; i++)); do
    echo ""
done

center_text "┌─────────────────────────────────────────┐" "$CYAN"
center_text "│                                     │" "$CYAN"
center_text "│   🦆 WELCOME, BINH! 🦆              │" "$MAGENTA"
center_text "│                                     │" "$CYAN"
center_text "│   YOUR PERSONAL AI ASSISTANT         │" "$GREEN"
center_text "│   ready to help                    │" "$GREEN"
center_text "│                                     │" "$CYAN"
center_text "└─────────────────────────────────────────┘" "$CYAN"

echo ""
echo ""

# Status section
center_text "SYSTEM STATUS" "$YELLOW"
echo ""

for ((i=1; i<=((COLS-40)/2); i++)); do
    printf " "
done
printf "${GREEN}✓${NC} Audio Transcription: ${GREEN}ACTIVE${NC}\n"
for ((i=1; i<=((COLS-40)/2); i++)); do
    printf " "
done
printf "${GREEN}✓${NC} GitHub Access: ${GREEN}CONNECTED${NC}\n"
for ((i=1; i<=((COLS-40)/2); i++)); do
    printf " "
done
printf "${GREEN}✓${NC} Research Ingest: ${GREEN}RUNNING${NC}\n"

echo ""

# Connection info
center_text "CONNECTIONS" "$YELLOW"
echo ""
center_text "GitHub: just-quack-quack" "$BLUE"
center_text "Workspace: ~/.openclaw/workspace" "$BLUE"

echo ""
echo ""

# Duck art (larger)
tput cup 20 $(( (COLS - 30) / 2 ))
printf "${MAGENTA}"
cat << 'DUCK'
         __
      __/  \__
     /  \__/  \
    /          \
   /   /  \    \
  /___/    \____\
DUCK

# Footer
tput cup $((ROWS - 5)) 0
draw_border "$CYAN"
echo ""

center_text "Press Ctrl+C to return to normal terminal" "$YELLOW"
center_text "quack! 🦆" "$YELLOW"
echo ""
