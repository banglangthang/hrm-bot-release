#!/bin/bash
set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo -e "${BOLD}============================================================${NC}"
echo -e "${BOLD}    🚀 lazy-bot — One-Click Installer${NC}"
echo -e "${BOLD}============================================================${NC}"
echo ""

# -------------------------------------------------------------------
# Step 1: Check Raycast is installed
# -------------------------------------------------------------------
if [ ! -d "/Applications/Raycast.app" ]; then
    echo -e "${RED}❌ Raycast is not installed.${NC}"
    echo -e "${YELLOW}   Please install Raycast first from: ${BOLD}https://raycast.com${NC}"
    echo -e "${YELLOW}   Or run: brew install --cask raycast${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Raycast is installed${NC}"

# -------------------------------------------------------------------
# Step 2: Mount DMG and install the app
# -------------------------------------------------------------------
echo -e "${BLUE}Installing lazy-bot.app...${NC}"

# Check if lazy-bot.app exists in Applications
if [ ! -d "/Applications/lazy-bot.app" ]; then
    echo -e "${YELLOW}⚠️  lazy-bot.app not found in /Applications${NC}"
    echo -e "${YELLOW}   Please download and install lazy-bot.app manually${NC}"
    echo -e "${YELLOW}   Then run this installer again${NC}"
    exit 1
fi

echo -e "${GREEN}✅ lazy-bot.app found in /Applications${NC}"

# -------------------------------------------------------------------
# Step 3: Bypass Gatekeeper (if needed)
# -------------------------------------------------------------------
echo -e "${BLUE}Bypassing Gatekeeper...${NC}"
xattr -cr "/Applications/lazy-bot.app" 2>/dev/null || true
echo -e "${GREEN}✅ Gatekeeper bypassed${NC}"

# -------------------------------------------------------------------
# Step 3: Launch the app (starts MCP server on port 1222)
# -------------------------------------------------------------------
echo -e "${BLUE}Launching lazy-bot...${NC}"
open -a "lazy-bot"
echo -e "${GREEN}✅ Server starting on http://localhost:1222/mcp${NC}"

# -------------------------------------------------------------------
# Step 4: Configure Raycast MCP
# -------------------------------------------------------------------
# Create a temporary config file for Raycast to import
MCP_CONFIG="$HOME/Desktop/lazy-bot.json"
cat > "$MCP_CONFIG" << 'EOF'
{
  "mcpServers": {
    "lazy-bot": {
      "url": "http://localhost:1222/mcp"
    }
  }
}
EOF

echo ""
echo -e "${BOLD}============================================================${NC}"
echo -e "${GREEN}${BOLD}🎉 Installation complete!${NC}"
echo -e "${BOLD}============================================================${NC}"
echo ""
echo -e "  1. Raycast is opening now..."
echo -e "  2. Type: ${BOLD}Import MCP Servers${NC} → hit Enter"
echo -e "  3. Select: ${BOLD}lazy-bot.json${NC} from your Desktop"
echo ""
echo -e "${BOLD}Then try in Raycast AI Chat:${NC}"
echo -e "  ${GREEN}\"What is my employee info?\"${NC}"
echo -e "  ${GREEN}\"Log 8 hours for TICKET-001 today\"${NC}"
echo ""
echo -e "${YELLOW}Note: First time will open a browser for login.${NC}"
echo -e "${BOLD}============================================================${NC}"

# Bring Raycast to the foreground
sleep 1
open -a "Raycast"
