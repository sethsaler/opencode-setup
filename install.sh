#!/bin/bash

set -e

echo "🚀 Starting installation of Ghostty and OpenCode..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "📦 Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for current session
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew is already installed"
fi

# Install Ghostty
if ! command -v ghostty &> /dev/null; then
    echo "📦 Installing Ghostty..."
    brew install --cask ghostty
else
    echo "✅ Ghostty is already installed"
fi

# Install OpenCode
if ! command -v opencode &> /dev/null; then
    echo "📦 Installing OpenCode..."
    brew install opencode
else
    echo "✅ OpenCode is already installed"
fi

# Create OpenCode config directory
CONFIG_DIR="$HOME/.config/opencode"
mkdir -p "$CONFIG_DIR"

# Create config file with DeepSeek V4-Flash model
CONFIG_FILE="$CONFIG_DIR/config.json"
echo "⚙️  Configuring OpenCode with DeepSeek V4-Flash model..."
cat > "$CONFIG_FILE" << EOF
{
  "$schema": "https://opencode.ai/config.json",
  "model": "deepseek/deepseek-v4-flash",
  "autoupdate": true
}
EOF

# Create launcher script
LAUNCHER_DIR="$HOME/Applications"
mkdir -p "$LAUNCHER_DIR"

LAUNCHER_FILE="$LAUNCHER_DIR/Launch-OpenCode.command"
echo "📝 Creating launcher script..."
cat > "$LAUNCHER_FILE" << 'LAUNCHER_EOF'
#!/bin/bash

# Check if this is the first run
FIRST_RUN_FLAG="$HOME/.config/opencode/.first_run_completed"
SUBSCRIPTION_URL="https://opencode.ai/auth"

if [ ! -f "$FIRST_RUN_FLAG" ]; then
    # First run - open the subscription page in browser
    echo "🌐 Opening Opencode subscription page..."
    open "$SUBSCRIPTION_URL"
    
    # Create the flag file
    mkdir -p "$(dirname "$FIRST_RUN_FLAG")"
    touch "$FIRST_RUN_FLAG"
    
    # Wait a moment for the browser to open
    sleep 2
fi

# Open Ghostty with OpenCode and DeepSeek V4-Flash model
open -a Ghostty --args -e opencode --model deepseek/deepseek-v4-flash
LAUNCHER_EOF

# Make launcher executable
chmod +x "$LAUNCHER_FILE"

echo ""
echo "✨ Installation complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Open OpenCode by running: $LAUNCHER_FILE"
echo "   2. In the OpenCode TUI, type: /connect"
echo "   3. Select 'opencode' as the provider"
echo "   4. Follow the prompts to set up your Opencode Go subscription"
echo "   5. The DeepSeek V4-Flash model will be pre-selected"
echo ""
echo "🎉 You're all set!"
