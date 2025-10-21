#!/bin/bash

# AGG Homes Play Games Terminal Launcher
# Author: GitHub Copilot
# Description: Launch web games directly from bash terminal

# Colors for better terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Game directory (current directory where script is located)
GAME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# Function to display the game menu
show_menu() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${WHITE}                    🎮 AGG HOMES GAMES 🎮                    ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "Available games:"
echo "  snake        - Classic Snake game"
echo "  mines        - Minesweeper game"  
echo "  pong         - Classic Pong game"
echo "  space        - Space Invaders game"
echo "  kong         - Donkey Kong game"
echo "  list         - Show this list"
    echo -e "${YELLOW}  1) 🐍 Snake   ${NC} - Classic snake game with mobile support"
    echo -e "${YELLOW}  2) 💣 Mines   ${NC} - Minesweeper with touch controls"
    echo -e "${YELLOW}  3) 🏓 Pong    ${NC} - Classic Pong with AI and 2-player modes"
    echo -e "${YELLOW}  4) 👾 Space   ${NC} - Space Invaders retro arcade action"
    echo -e "${YELLOW}  5) 🏠 Menu    ${NC} - Main game selection menu"
    echo ""
    echo -e "${BLUE}Commands:${NC}"
    echo -e "  ${WHITE}./play.sh [game]${NC}     - Launch specific game"
    echo -e "  ${WHITE}./play.sh menu${NC}       - Open main menu"
    echo -e "  ${WHITE}./play.sh list${NC}       - Show this menu"
    echo -e "  ${WHITE}./play.sh help${NC}       - Show help information"
    echo ""
    echo -e "${PURPLE}Examples:${NC}"
    echo -e "  ${WHITE}./play.sh snake${NC}      - Launch Snake game"
    echo -e "  ${WHITE}./play.sh mines${NC}      - Launch Mines game"
    echo -e "  ${WHITE}./play.sh pong${NC}       - Launch Pong game"
    echo -e "  ${WHITE}./play.sh space${NC}      - Launch Space Invaders game"
    echo ""
}

# Function to show help
show_help() {
    echo -e "${GREEN}AGG Homes Play Games - Terminal Launcher${NC}"
    echo ""
    echo -e "${YELLOW}DESCRIPTION:${NC}"
    echo "  This script launches mobile-optimized web games in your default browser."
    echo "  All games are designed to work perfectly on both desktop and mobile devices."
    echo ""
    echo -e "${YELLOW}USAGE:${NC}"
    echo "  ./play.sh [COMMAND|GAME]"
    echo ""
    echo -e "${YELLOW}COMMANDS:${NC}"
    echo "  help, -h, --help    Show this help message"
    echo "  list, menu, ls      Show available games menu"
    echo "  server, serve       Start local development server (if available)"
    echo ""
    echo -e "${YELLOW}GAMES:${NC}"
    echo "  snake               Launch Snake game"
    echo "  mines               Launch Minesweeper game"  
    echo "  pong                Launch Pong game"
    echo "  space               Launch Space Invaders game"
    echo "  kong                Launch Donkey Kong game"
    echo "  index, main         Launch main game menu"
    echo ""
    echo -e "${YELLOW}FEATURES:${NC}"
    echo "  • Mobile-optimized touch controls"
    echo "  • Responsive design for all screen sizes"
    echo "  • Sound effects and haptic feedback"
    echo "  • Multiple difficulty levels"
    echo "  • Local high scores and progress tracking"
    echo ""
    echo -e "${YELLOW}REQUIREMENTS:${NC}"
    echo "  • Any modern web browser"
    echo "  • Internet connection (for online hosting)"
    echo "  • OR local web server for offline play"
    echo ""
}

# Function to launch a game
launch_game() {
    local game=$1
    local file=""
    local game_name=""
    
    case $game in
        "snake")
            file="snake.html"
            game_name="Snake Game"
            ;;
        "mines"|"minesweeper")
            file="mines.html" 
            game_name="Mines Game"
            ;;
        "pong")
            file="pong.html"
            game_name="Pong Game"
            ;;
        "space"|"space-invaders"|"invaders")
            file="space-invaders.html"
            game_name="Space Invaders Game"
            ;;
        "kong"|"donkey"|"donkey-kong")
            file="donkey-kong.html"
            game_name="Donkey Kong Game"
            ;;
        "menu"|"index"|"main"|"home")
            file="index.html"
            game_name="Games Menu"
            ;;
        *)
            echo -e "${RED}❌ Error: Unknown game '${game}'${NC}"
            echo -e "${YELLOW}💡 Use './play.sh list' to see available games${NC}"
            return 1
            ;;
    esac
    
    # Check if file exists
    if [[ ! -f "${GAME_DIR}/${file}" ]]; then
        echo -e "${RED}❌ Error: Game file '${file}' not found in ${GAME_DIR}${NC}"
        echo -e "${YELLOW}💡 Make sure all game files are in the same directory as this script${NC}"
        return 1
    fi
    
    echo -e "${GREEN}🚀 Launching ${game_name}...${NC}"
    
    # Determine the best way to open the browser based on the system
    local url="file://${GAME_DIR}/${file}"
    
    # Check if we're running on a system with a custom browser command
    if [[ -n "$BROWSER" ]]; then
        echo -e "${BLUE}🌐 Using custom browser: $BROWSER${NC}"
        "$BROWSER" "$url" &
    # Check for common browser environments
    elif command -v xdg-open > /dev/null 2>&1; then
        echo -e "${BLUE}🌐 Opening with xdg-open (Linux)${NC}"
        xdg-open "$url" &
    elif command -v open > /dev/null 2>&1; then
        echo -e "${BLUE}🌐 Opening with open (macOS)${NC}"
        open "$url" &
    elif command -v start > /dev/null 2>&1; then
        echo -e "${BLUE}🌐 Opening with start (Windows)${NC}"
        start "$url" &
    # Fallback: try common browsers directly
    elif command -v google-chrome > /dev/null 2>&1; then
        echo -e "${BLUE}🌐 Opening with Google Chrome${NC}"
        google-chrome "$url" &
    elif command -v firefox > /dev/null 2>&1; then
        echo -e "${BLUE}🌐 Opening with Firefox${NC}"
        firefox "$url" &
    elif command -v chromium > /dev/null 2>&1; then
        echo -e "${BLUE}🌐 Opening with Chromium${NC}"
        chromium "$url" &
    elif command -v safari > /dev/null 2>&1; then
        echo -e "${BLUE}🌐 Opening with Safari${NC}"
        safari "$url" &
    else
        echo -e "${RED}❌ Error: No suitable browser found${NC}"
        echo -e "${YELLOW}💡 Please set the BROWSER environment variable or install a supported browser${NC}"
        echo -e "${WHITE}Supported: chrome, firefox, chromium, safari${NC}"
        echo -e "${WHITE}Example: export BROWSER=/usr/bin/google-chrome${NC}"
        return 1
    fi
    
    echo -e "${GREEN}✅ ${game_name} should now be open in your browser!${NC}"
    echo -e "${CYAN}📱 The game is optimized for both desktop and mobile devices${NC}"
    
    # Show game-specific tips
    case $game in
        "snake")
            echo -e "${YELLOW}🎮 Controls: Arrow keys or WASD (desktop), Touch circle (mobile)${NC}"
            ;;
        "mines")
            echo -e "${YELLOW}🎮 Controls: Left click to reveal, Right click to flag (desktop), Tap/Long press (mobile)${NC}"
            ;;
        "pong")
            echo -e "${YELLOW}🎮 Controls: W/S keys (desktop), Touch control at bottom (mobile)${NC}"
            ;;
    esac
}

# Function to start a local server (if python is available)
start_server() {
    echo -e "${GREEN}🔧 Attempting to start local development server...${NC}"
    
    # Check for Python 3
    if command -v python3 > /dev/null 2>&1; then
        echo -e "${BLUE}🐍 Starting Python 3 HTTP server on port 8000${NC}"
        echo -e "${YELLOW}📍 Access games at: http://localhost:8000${NC}"
        echo -e "${WHITE}Press Ctrl+C to stop the server${NC}"
        echo ""
        cd "$GAME_DIR"
        python3 -m http.server 8000
    # Check for Python 2
    elif command -v python2 > /dev/null 2>&1; then
        echo -e "${BLUE}🐍 Starting Python 2 HTTP server on port 8000${NC}"
        echo -e "${YELLOW}📍 Access games at: http://localhost:8000${NC}"
        echo -e "${WHITE}Press Ctrl+C to stop the server${NC}"
        echo ""
        cd "$GAME_DIR"
        python2 -m SimpleHTTPServer 8000
    # Check for Node.js
    elif command -v node > /dev/null 2>&1 && command -v npx > /dev/null 2>&1; then
        echo -e "${BLUE}📦 Starting Node.js HTTP server on port 8000${NC}"
        echo -e "${YELLOW}📍 Access games at: http://localhost:8000${NC}"
        echo -e "${WHITE}Press Ctrl+C to stop the server${NC}"
        echo ""
        cd "$GAME_DIR"
        npx http-server -p 8000
    # Check for PHP
    elif command -v php > /dev/null 2>&1; then
        echo -e "${BLUE}🐘 Starting PHP development server on port 8000${NC}"
        echo -e "${YELLOW}📍 Access games at: http://localhost:8000${NC}"
        echo -e "${WHITE}Press Ctrl+C to stop the server${NC}"
        echo ""
        cd "$GAME_DIR"
        php -S localhost:8000
    else
        echo -e "${RED}❌ No suitable server runtime found${NC}"
        echo -e "${YELLOW}💡 Install one of the following to run a local server:${NC}"
        echo -e "${WHITE}  • Python 3: python3 -m http.server 8000${NC}"
        echo -e "${WHITE}  • Node.js: npx http-server -p 8000${NC}"
        echo -e "${WHITE}  • PHP: php -S localhost:8000${NC}"
        return 1
    fi
}

# Main script logic
main() {
    case $1 in
        "help"|"-h"|"--help")
            show_help
            ;;
        "list"|"ls"|"menu"|"")
            show_menu
            echo -e "${WHITE}Enter game name (snake/mines/pong/space/kong/menu): ${NC}"
            read -r choice
            if [[ -n "$choice" ]]; then
                launch_game "$choice"
            fi
            ;;
        "server"|"serve")
            start_server
            ;;
        *)
            launch_game "$1"
            ;;
    esac
}

# Make sure we're in the right directory
if [[ ! -f "${GAME_DIR}/index.html" ]]; then
    echo -e "${RED}❌ Error: Game files not found in ${GAME_DIR}${NC}"
    echo -e "${YELLOW}💡 Make sure you're running this script from the games directory${NC}"
    exit 1
fi

# Execute main function with all arguments
main "$@"