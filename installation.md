# Installation

## Quick Install (Recommended)

Run this single command in Terminal:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/banglangthang/hrm-bot-release/main/scripts/install_raycast.sh)
```

This will:
1. Download and install `HRM MCP.app` to `/Applications`
2. Launch the server
3. Create a Raycast config file on your Desktop
4. Follow the on-screen instructions to complete setup

## Manual Install

1. Download the latest `HRM-MCP.dmg` from the [Releases](https://github.com/banglangthang/hrm-bot-release/releases) page
2. Open the DMG and drag `HRM MCP.app` to the **Applications** folder
3. If you see "App is damaged" error, run in Terminal:
   ```bash
   xattr -cr /Applications/HRM\ MCP.app
   ```
4. Double-click `HRM MCP.app` to launch
5. A menu bar icon will appear

## First-Time Setup

1. Click the HRM icon in your menu bar
2. Select **"Login to Service"**
3. Complete authentication in the browser window

## Troubleshooting

- **App won't open**: Run `xattr -cr /Applications/HRM\ MCP.app` in Terminal
- **Menu bar icon not showing**: Check Applications folder, try launching again

## Uninstall

1. Drag `HRM MCP.app` from Applications to Trash
2. Optionally remove data: `rm -rf ~/.hrm_mcp`
