# Antigravity Proxy Setup
# Local proxy that routes Claude API calls through Google accounts for free access

## Setup
Antigravity is installed at `~/.antigravity/`. The proxy runs on port 8080.

```bash
# Start proxy
antigravity-claude-proxy start

# Check status
acc status

# Health check
curl http://localhost:8080/health
```

## Shell env (in ~/.zshrc)
```bash
export ANTHROPIC_API_KEY="dummy"
export ANTHROPIC_BASE_URL="http://localhost:8080"
export ANTIGRAVITY_LOCAL_API_KEY="test"
export PATH="/Users/apple/.antigravity/antigravity/bin:$PATH"
```

## Works with
- **Claude Code** — set env vars and it auto-routes through the proxy
- **OpenCode** — see `../opencode/` for full config
- **Hermes** — set `ANTHROPIC_BASE_URL` in env
