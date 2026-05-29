# Ghostty + OpenCode One-Click Setup

This setup provides a one-click installation for Ghostty terminal emulator and OpenCode AI coding agent, with a pre-configured launcher that opens OpenCode in Ghostty using the DeepSeek V4-Flash model.

## Installation

Run this command in your terminal:

```bash
curl -fsSL https://tinyurl.com/2ddnp2cr | bash
```

This URL shortener hides the GitHub username and provides a clean, memorable installation command.

## What Gets Installed

1. **Homebrew** (if not already installed)
2. **Ghostty** - Modern terminal emulator
3. **OpenCode** - AI coding agent for the terminal
4. **Launcher Script** - Located at `~/Applications/Launch-OpenCode.command`

## After Installation

1. Double-click `~/Applications/Launch-OpenCode.command` to launch OpenCode in Ghostty
2. **On first run only**: The browser will automatically open to https://opencode.ai/auth for subscription setup
3. In the OpenCode TUI, type `/connect` to set up your provider
4. Select `opencode` as the provider
5. Follow the prompts to authenticate with your Opencode Go subscription
6. The DeepSeek V4-Flash model will be pre-selected

## Manual Setup (Alternative)

If you prefer to install manually:

```bash
# Install Ghostty
brew install --cask ghostty

# Install OpenCode
brew install opencode

# Create config
mkdir -p ~/.config/opencode
cat > ~/.config/opencode/config.json << EOF
{
  "$schema": "https://opencode.ai/config.json",
  "model": "deepseek/deepseek-v4-flash",
  "autoupdate": true
}
EOF

# Launch
open -a Ghostty --args -e opencode --model deepseek/deepseek-v4-flash
```

## Troubleshooting

- If the launcher doesn't work, make sure it's executable: `chmod +x ~/Applications/Launch-OpenCode.command`
- If OpenCode can't find the model, run `/models` in the TUI to see available models
- For Opencode Go subscription issues, visit https://opencode.ai/auth
