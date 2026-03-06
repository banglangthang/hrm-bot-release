# lazy-bot

A macOS menu bar app that provides AI-powered timesheet management through a simple menu bar interface.

## Features

- **Menu Bar App** - Runs quietly in your macOS menu bar
- **AI Integration** - Works with Claude Desktop, Cursor, Raycast, OpenCode, and any MCP-compatible AI tool
- **Browser Automation** - Handles authentication and timesheet operations via Playwright
- **Timesheet Management** - Submit hours, view timesheets, find projects - all through natural conversation

## Installation
- **[Installation Link](installation.md)**: Install lazy-bot app, and Raycast
- **[Config Link](cgpt-config/README.md)**: Configs file for setting CGPT with Local IDE

## Connect Your AI Tool
After installing, configure your AI tool to connect to (Any AI tools that support MCP):
- **MCP Server**: `http://localhost:1222/mcp`

## Usage Examples

| What you want | What to say |
|---|---|
| Find project | "Find project id of Project X" |
| View timesheet | "Show my timesheet for this month" |
| Log time | "Log 8 hours for TICKET-123 today" |
| Update entry | "Change TICKET-123 today to 6 hours" |
