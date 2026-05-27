# OpenCode + Antigravity Proxy Setup

[OpenCode](https://opencode.ai/) is a terminal AI coding assistant (similar to Claude Code) that supports custom model providers. This config unlocks **Claude + Gemini models** in a single interactive session via the Antigravity proxy.

## Quick Setup

### 1. Prerequisites
```bash
npm install -g opencode-ai@latest
# Make sure Antigravity Claude Proxy is running on port 8080
```

### 2. Config
```bash
mkdir -p ~/.config/opencode
# Symlink the config
ln -sf ~/perryescape/config/opencode/opencode.json ~/.config/opencode/opencode.json
```

### 3. Shell env
```bash
grep -q 'ANTHROPIC_API_KEY=' ~/.zshrc || echo 'export ANTHROPIC_API_KEY="dummy"' >> ~/.zshrc
grep -q 'ANTHROPIC_BASE_URL=' ~/.zshrc || echo 'export ANTHROPIC_BASE_URL="http://localhost:8080/v1"' >> ~/.zshrc
source ~/.zshrc
```

### 4. Run
```bash
# Terminal 1: Start proxy
antigravity-claude-proxy start

# Terminal 2: Open OpenCode from any project
opencode
```

## Switching Models

Inside OpenCode, use the model picker. All registered models appear as `antigravity/<model-id>`:

- `claude-sonnet-4-6` — Coding, refactoring
- `claude-opus-4-6-thinking` — Architecture, deep reasoning
- `gemini-3.1-pro-low` — Strong reasoning
- `gemini-3-flash` — Fast, lightweight
- `gemini-2.5-flash-thinking` — Reasoning tasks

The `model` field is the default for main tasks. `small_model` is used for background operations.

## Verify

```bash
curl "http://localhost:8080/v1/messages" \
  -H "content-type: application/json" \
  -H "anthropic-version: 2023-06-01" \
  -H "x-api-key: dummy" \
  -d '{"model": "claude-sonnet-4-6", "max_tokens": 100, "messages": [{"role":"user","content":"say hi"}]}'
```
