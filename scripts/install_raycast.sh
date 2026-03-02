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
# Step 2: Download the latest DMG from GitHub releases
# -------------------------------------------------------------------
REPO="banglangthang/lazy-bot"
LATEST_TAG=$(curl -s https://api.github.com/repos/${REPO}/releases/latest | grep '"tag_name"' | cut -d'"' -f4)

# Find DMG file from release assets
DMG_URL=$(curl -s https://api.github.com/repos/${REPO}/releases/latest | grep -o '"browser_download_url": *"[^"]*\.dmg"' | head -1 | cut -d'"' -f4)

if [ -z "$DMG_URL" ]; then
    echo -e "${RED}❌ Could not find DMG in latest release.${NC}"
    echo -e "${YELLOW}   Download manually from: https://github.com/${REPO}/releases${NC}"
    exit 1
fi

# Download DMG to temp location
TMP_DMG="/tmp/lazy-bot.dmg"
echo -e "${BLUE}Downloading latest release...${NC}"
if ! curl -L -o "$TMP_DMG" "$DMG_URL" 2>/dev/null; then
    echo -e "${RED}❌ Failed to download DMG${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Downloaded${NC}"

# -------------------------------------------------------------------
# Step 3: Mount DMG and install the app
# -------------------------------------------------------------------
echo -e "${BLUE}Installing lazy-bot.app...${NC}"

# Detach any existing lazy-bot volumes
for vol in /Volumes/lazy-bot*; do
    if [[ -d "$vol" ]]; then
        hdiutil detach "$vol" -quiet 2>/dev/null || true
    fi
done

# Mount DMG and detect mount point
MOUNT_POINT=$(hdiutil attach "$TMP_DMG" -nobrowse | grep -o '/Volumes/.*' | tail -1)
if [[ -z "$MOUNT_POINT" ]]; then
    echo -e "${RED}❌ Failed to mount DMG${NC}"
    rm -f "$TMP_DMG"
    exit 1
fi

# Install the app
if cp -R "${MOUNT_POINT}/lazy-bot.app" "/Applications/"; then
    echo -e "${GREEN}✅ lazy-bot.app installed to /Applications${NC}"
else
    echo -e "${RED}❌ Failed to install app${NC}"
    hdiutil detach "$MOUNT_POINT" -quiet 2>/dev/null || true
    rm -f "$TMP_DMG"
    exit 1
fi

# Cleanup
hdiutil detach "$MOUNT_POINT" -quiet 2>/dev/null || true
rm -f "$TMP_DMG"
xattr -cr "/Applications/lazy-bot.app" 2>/dev/null || true

# -------------------------------------------------------------------
# Step 4: Launch the app (starts MCP server on port 1222)
# -------------------------------------------------------------------
echo -e "${BLUE}Launching lazy-bot...${NC}"
open -a "lazy-bot"
echo -e "${GREEN}✅ Server starting on http://localhost:1222/mcp${NC}"

# -------------------------------------------------------------------
# Step 5: Configure Raycast MCP
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
echo -e "${GREEN}${BOLD}🎉 Almost done! One last step:${NC}"
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
