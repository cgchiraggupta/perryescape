# Cursor IDE Config

## Quick Setup

```bash
ln -sf ~/perryescape/config/cursor/config.json ~/.cursor/config.json
ln -sf ~/perryescape/config/cursor/mcp.json ~/.cursor/mcp.json
```

## MCP Servers

| Server | What it does | Needs |
|--------|-------------|-------|
| **Figma MCP** | Pull Figma designs into code | `FIGMA_API_KEY` env var |
| **Supabase** | Query/manage Supabase DB | `SUPABASE_ACCESS_TOKEN` + project ref |
| **Magic Patterns** | UI component patterns | Nothing (public API) |

Set secrets in `~/.zshrc`:
```bash
export FIGMA_API_KEY="figd_xxx"
export SUPABASE_ACCESS_TOKEN="sbp_xxx"
export SUPABASE_PROJECT_REF="ntxqedcyxsqdpauphunc"
```

## AI Provider
Coder uses local Ollama (`qwen2.5-coder:7b`) via localhost:11434.
