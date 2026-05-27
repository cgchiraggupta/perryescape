# Claude Code Setup

Claude Code connected to Antigravity proxy for **free Claude + Gemini models**.

## Quick Setup

```bash
# 1. Symlink configs
ln -sf ~/perryescape/config/claude-code/settings.json ~/.claude/settings.json
ln -sf ~/perryescape/config/claude-code/settings.local.json ~/.claude/settings.local.json

# 2. Install plugins
npm install -g @anthropic-ai/claude-code  # Claude Code CLI

# 3. Plugins used
claude plugin install vercel-vercel-plugin  # Vercel deployment
claude plugin install claude-plugins-official # Official plugins
npm install -g clawmem  # Memory management hooks
# Caveman mode: https://github.com/JuliusBrussee/caveman
```

## What's Configured

**Proxy routing** → All Claude API calls go through `localhost:8080` (Antigravity)

**Model defaults:**
- Main: `claude-opus-4-6-thinking`
- Subagent: `claude-sonnet-4-6`
- Cheap fallback: `claude-sonnet-4-6`

**Hooks activated:**
- Caveman mode (ultra-compressed tokens)
- Clawmem (persistent memory across sessions)
  - Context surfacing on each prompt
  - Auto-decision extraction on stop
  - Handoff generation between sessions

**Plugins:**
- vercel-plugin — Vercel deployment
- caveman — Token compression
- claude-mem — Memory persistence
- skill-codex — Codex skills

## Everything Claude Code (ECC)

There's also a full plugin ecosystem: [github.com/affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code)

28 agents, 116 skills, 59 commands. Install:
```bash
claude plugin install affaan-m/everything-claude-code
```
