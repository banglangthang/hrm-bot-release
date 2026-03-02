# HRM MCP

A macOS menu bar app that provides AI-powered HRM timesheet management through a simple menu bar interface.

## Features

- **Menu Bar App** - Runs quietly in your macOS menu bar
- **AI Integration** - Works with Claude Desktop, Cursor, Raycast, OpenCode, and any MCP-compatible AI tool
- **Browser Automation** - Handles authentication and timesheet operations via Playwright
- **OpenAI-Compatible API** - Exposes an OpenAI-compatible endpoint for custom LLM integration
- **Timesheet Management** - Submit hours, view timesheets, find projects - all through natural conversation

## Quick Start

1. Install using Raycast (recommended) or download `HRM-MCP.dmg` from [Releases](https://github.com/banglangthang/hrm-bot-release/releases)
2. Launch the app - a menu bar icon will appear
3. Click "Login to Service" to authenticate

## Connect Your AI Tool

After installing, configure your AI tool to connect to:

- **MCP Server**: `http://localhost:1222/mcp`
- **OpenAI API**: `http://localhost:1222/v1`

## Usage Examples

| What you want | What to say |
|---|---|
| Find project | "Find project id of Project X" |
| View timesheet | "Show my timesheet for this month" |
| Log time | "Log 8 hours for TICKET-123 today" |
| Update entry | "Change TICKET-123 today to 6 hours" |

## Requirements

- macOS
- An HRM account

## Support

For issues and questions, please open an issue on GitHub.
