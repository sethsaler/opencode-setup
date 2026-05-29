#!/bin/bash

# Launch OpenCode in Ghostty with DeepSeek V4-Flash model
# This launcher assumes Ghostty and OpenCode are already installed

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
