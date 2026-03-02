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
echo -e "${BOLD}    🚀 Lazy Timesheet — One-Click Installer${NC}"
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
# Step 2: Download the latest DMG from GitHub releases
# -------------------------------------------------------------------
REPO="banglangthang/timesheet-bot"
DMG_NAME="HRM.MCP-2026.02.25.dmg"
TMP_DMG="/tmp/${DMG_NAME}"

echo -e "${BLUE}Downloading latest release...${NC}"

# Get the latest release tag
LATEST_TAG=$(curl -s https://api.github.com/repos/${REPO}/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${LATEST_TAG}/${DMG_NAME}"
HTTP_CODE=$(curl -L -o "$TMP_DMG" -w "%{http_code}" "$DOWNLOAD_URL" 2>/dev/null)

if [ "$HTTP_CODE" != "200" ] || [ ! -s "$TMP_DMG" ]; then
    echo -e "${RED}❌ Could not download DMG from GitHub releases.${NC}"
    echo -e "${YELLOW}   Download manually from: https://github.com/${REPO}/releases${NC}"
    rm -f "$TMP_DMG"
    exit 1
fi
echo -e "${GREEN}✅ Downloaded${NC}"

# -------------------------------------------------------------------
# Step 3: Mount DMG and install the app
# -------------------------------------------------------------------
echo -e "${BLUE}Installing HRM MCP.app...${NC}"

hdiutil detach "/Volumes/HRM MCP" 2>/dev/null || true
hdiutil attach "$TMP_DMG" -nobrowse -quiet
cp -R "/Volumes/HRM MCP/HRM MCP.app" "/Applications/" 2>/dev/null || true
hdiutil detach "/Volumes/HRM MCP" -quiet 2>/dev/null || true
rm -f "$TMP_DMG"
xattr -cr "/Applications/HRM MCP.app" 2>/dev/null || true

echo -e "${GREEN}✅ HRM MCP.app installed to /Applications${NC}"

# -------------------------------------------------------------------
# Step 4: Launch the app (starts MCP server on port 1222)
# -------------------------------------------------------------------
echo -e "${BLUE}Launching HRM MCP...${NC}"
open -a "HRM MCP"
echo -e "${GREEN}✅ Server starting on http://localhost:1222/mcp${NC}"

# -------------------------------------------------------------------
# Step 5: Configure Raycast MCP
# -------------------------------------------------------------------
# Create a temporary config file for Raycast to import
MCP_CONFIG="$HOME/Desktop/lazy-timesheet-mcp.json"
cat > "$MCP_CONFIG" << 'EOF'
{
  "mcpServers": {
    "HRM Timesheet": {
      "url": "http://localhost:1222/mcp"
    }
  }
}
EOF

echo ""
echo -e "${BOLD}============================================================${NC}"
echo -e "${GREEN}${BOLD}🎉 Almost done! One last step:${NC}"
echo -e "${BOLD}============================================================${NC}"
echo ""
echo -e "  1. Raycast is opening now..."
echo -e "  2. Type: ${BOLD}Import MCP Servers${NC} → hit Enter"
echo -e "  3. Select: ${BOLD}lazy-timesheet-mcp.json${NC} from your Desktop"
echo ""
echo -e "${BOLD}Then try in Raycast AI Chat:${NC}"
echo -e "  ${GREEN}\"What is my employee info?\"${NC}"
echo -e "  ${GREEN}\"Log 8 hours for KT-001 today\"${NC}"
echo ""
echo -e "${YELLOW}Note: First time will open a browser for HRM login.${NC}"
echo -e "${BOLD}============================================================${NC}"

# Bring Raycast to the foreground
sleep 1
open -a "Raycast"
