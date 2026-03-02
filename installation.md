# Installation

## Quick Install (Recommended)

Run this single command in Terminal:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/banglangthang/lazy-bot/main/scripts/install_raycast.sh)
```

This will:
1. Download and install `lazy-bot.app` to `/Applications`
2. Launch the server
3. Create a Raycast config file on your Desktop
4. Follow the on-screen instructions to complete setup

## Manual Install

1. Download the latest `lazy-bot.dmg` from [Releases](https://github.com/banglangthang/lazy-bot/releases/latest)
2. Open the DMG and drag `lazy-bot.app` to the **Applications** folder
3. If you see "App is damaged" error, run in Terminal:
   ```bash
   xattr -cr /Applications/lazy-bot.app
   ```
4. Double-click `lazy-bot.app` to launch
5. A menu bar icon will appear

## First-Time Setup

1. Click the lazy-bot icon in your menu bar
2. Select **"Login to Service"**
3. Complete authentication in the browser window

## Troubleshooting

- **App won't open**: Run `xattr -cr /Applications/lazy-bot.app` in Terminal
- **Menu bar icon not showing**: Check Applications folder, try launching again

## Uninstall

1. Drag `lazy-bot.app` from Applications to Trash
2. Optionally remove data: `rm -rf ~/.hrm_mcp`
