#!/usr/bin/env bash

# Bash script to install a new bash prompt style

# Function to show preview of all styles
show_preview() {
    # Determine which pager to use
    if command -v less &> /dev/null; then
        PAGER="less -SR"
    elif command -v more &> /dev/null; then
        PAGER="more"
    else
        PAGER="cat"
    fi

    # Use pager for better navigation
    {
        echo "========================================="
        echo "  Bash Prompt Style Preview"
        echo "========================================="
        echo ""

        # Simulate being in a nested directory
        echo "Preview assumes you're in: /home/user/projects/repo/src/components"
        echo "Current folder: components"
        echo ""

        if [ "$PAGER" != "cat" ]; then
            echo "Use arrow keys or j/k to scroll, q to quit"
            echo ""
        fi

        echo "========================================="
        echo ""

        echo "1. Minimalist Color"
        echo "   user:components$ "
        echo ""
        echo "   Shows: username in green, folder in blue"
        echo "   Best for: Simple, clean look"
        echo ""
        echo "---"
        echo ""

        echo "2. Arrow Style (Full Path)"
        echo "   user@hostname /home/user/projects/repo/src/components ➜ "
        echo ""
        echo "   Shows: Full directory path with arrow"
        echo "   Best for: Knowing exact location, but can get long"
        echo ""
        echo "---"
        echo ""

        echo "2s. Arrow Style (Short Path) ⭐ RECOMMENDED"
        echo "   user@hostname components ➜ "
        echo ""
        echo "   Shows: Just current folder name with arrow"
        echo "   Best for: Nested directories, modern look"
        echo ""
        echo "---"
        echo ""

        echo "3. Two-Line (Full Path)"
        echo "   ┌─[user@hostname]─[/home/user/projects/repo/src/components]"
        echo "   └─$ "
        echo ""
        echo "   Shows: Info on first line, prompt on second"
        echo "   Best for: Long paths, keeps command line clean"
        echo ""
        echo "---"
        echo ""

        echo "3s. Two-Line (Short Path)"
        echo "   ┌─[user@hostname]─[components]"
        echo "   └─$ "
        echo ""
        echo "   Shows: Two-line with just folder name"
        echo "   Best for: Clean two-line format without clutter"
        echo ""
        echo "---"
        echo ""

        echo "4. Compact Git-Aware (shows branch if in git repo)"
        echo "   user components (main) $ "
        echo ""
        echo "   Shows: Git branch in yellow when in repository"
        echo "   Best for: Developers working with git"
        echo "   Note: Requires git-prompt to be installed"
        echo ""
        echo "---"
        echo ""

        echo "5. Powerline-like"
        echo "   ▶ user ▶ components ▶ "
        echo ""
        echo "   Shows: Blocks with arrows (powerline style)"
        echo "   Best for: Modern, stylish terminal"
        echo ""
        echo "---"
        echo ""

        echo "6. Emoji Style"
        echo "   🚀 user components $ "
        echo ""
        echo "   Shows: Rocket emoji with colored info"
        echo "   Best for: Fun, modern terminals"
        echo ""
        echo "---"
        echo ""

        echo "7. Time-Stamped (Full Path)"
        echo "   [14:23:45] user@hostname:/home/user/projects/repo/src/components$ "
        echo ""
        echo "   Shows: Current time with full path"
        echo "   Best for: Tracking when commands run"
        echo ""
        echo "---"
        echo ""

        echo "7s. Time-Stamped (Short Path)"
        echo "   [14:23:45] user@hostname:components$ "
        echo ""
        echo "   Shows: Current time with just folder name"
        echo "   Best for: Time tracking without long paths"
        echo ""
        echo "---"
        echo ""

        echo "8. Bracket Style"
        echo "   [user@hostname]─[components]$ "
        echo ""
        echo "   Shows: Bracketed sections with separator"
        echo "   Best for: Clear visual separation"
        echo ""
        echo "---"
        echo ""

        echo "9. Arrow Minimalist (Short Path Only) ⭐ CLEANEST"
        echo "   components ➜ "
        echo ""
        echo "   Shows: Just folder and arrow, nothing else"
        echo "   Best for: Maximum minimalism, deep nesting"
        echo ""
        echo "========================================="
        echo ""
        echo "To install a style, run:"
        echo "  $0 <style_number>"
        echo ""
        echo "Examples:"
        echo "  $0 2s    (Arrow with short path)"
        echo "  $0 9     (Minimalist arrow)"
        echo "  $0 3s    (Two-line with short path)"
        echo ""
        echo "========================================="
    } | $PAGER
    exit 0
}

# Check for --preview flag
if [ "$1" = "--preview" ] || [ "$1" = "-p" ]; then
    show_preview
fi

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <style_number>"
    echo "       $0 --preview    (show all available styles)"
    echo ""
    echo "Choose a style number from 1-9, or 2s/3s/7s for short path variants"
    exit 1
fi

STYLE=$1

# Define the prompt styles
case $STYLE in
    1)
        PROMPT_NAME="Minimalist Color"
        PS1_VALUE='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
        ;;
    2)
        PROMPT_NAME="Arrow Style (Full Path)"
        PS1_VALUE='\[\033[01;36m\]\u@\h\[\033[00m\] \[\033[01;33m\]\w\[\033[00m\] \[\033[01;32m\]➜\[\033[00m\] '
        ;;
    2s)
        PROMPT_NAME="Arrow Style (Short Path)"
        PS1_VALUE='\[\033[01;36m\]\u@\h\[\033[00m\] \[\033[01;33m\]\W\[\033[00m\] \[\033[01;32m\]➜\[\033[00m\] '
        ;;
    3)
        PROMPT_NAME="Two-Line (Full Path)"
        PS1_VALUE='┌─[\[\033[01;32m\]\u@\h\[\033[00m\]]─[\[\033[01;34m\]\w\[\033[00m\]]\n└─\$ '
        ;;
    3s)
        PROMPT_NAME="Two-Line (Short Path)"
        PS1_VALUE='┌─[\[\033[01;32m\]\u@\h\[\033[00m\]]─[\[\033[01;34m\]\W\[\033[00m\]]\n└─\$ '
        ;;
    4)
        PROMPT_NAME="Compact Git-Aware"
        PS1_VALUE='\[\033[01;35m\]\u\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\]$(__git_ps1 " \[\033[01;33m\](%s)\[\033[00m\]") \$ '
        ;;
    5)
        PROMPT_NAME="Powerline-like"
        PS1_VALUE='\[\033[48;5;240m\]\[\033[38;5;255m\] \u \[\033[48;5;236m\]\[\033[38;5;240m\]▶\[\033[38;5;255m\] \W \[\033[00m\]\[\033[38;5;236m\]▶\[\033[00m\] '
        ;;
    6)
        PROMPT_NAME="Emoji Style"
        PS1_VALUE='🚀 \[\033[01;36m\]\u\[\033[00m\] \[\033[01;33m\]\W\[\033[00m\] $ '
        ;;
    7)
        PROMPT_NAME="Time-Stamped (Full Path)"
        PS1_VALUE='[\[\033[01;32m\]\t\[\033[00m\]] \[\033[01;34m\]\u@\h\[\033[00m\]:\[\033[01;35m\]\w\[\033[00m\]\$ '
        ;;
    7s)
        PROMPT_NAME="Time-Stamped (Short Path)"
        PS1_VALUE='[\[\033[01;32m\]\t\[\033[00m\]] \[\033[01;34m\]\u@\h\[\033[00m\]:\[\033[01;35m\]\W\[\033[00m\]\$ '
        ;;
    8)
        PROMPT_NAME="Bracket Style"
        PS1_VALUE='[\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;36m\]\h\[\033[00m\]]─[\[\033[01;33m\]\W\[\033[00m\]]$ '
        ;;
    9)
        PROMPT_NAME="Arrow Minimalist (Short Path Only)"
        PS1_VALUE='\[\033[01;33m\]\W\[\033[00m\] \[\033[01;32m\]➜\[\033[00m\] '
        ;;
    *)
        echo "Invalid style number. Please choose 1-9 or 2s, 3s, 7s for short variants."
        exit 1
        ;;
esac

echo "Installing prompt style: $PROMPT_NAME"
echo ""

# Backup the original .bashrc
BASHRC="$HOME/.bashrc"
if [ ! -f "${BASHRC}.backup" ]; then
    cp "$BASHRC" "${BASHRC}.backup"
    echo "✓ Backed up original .bashrc to ${BASHRC}.backup"
fi

# Create a temporary file with the new content
TEMP_FILE=$(mktemp)

# Check if PS1 configuration exists
if grep -q "^PS1=" "$BASHRC" || grep -q "^# Custom prompt configuration" "$BASHRC"; then
    # PS1 exists or was previously customized, replace it

    # Remove any existing custom prompt section (our own additions)
    sed '/^# Custom prompt configuration$/,/^PS1=/{/^PS1=/d; /^# Custom prompt configuration$/d;}' "$BASHRC" > "$TEMP_FILE.tmp"

    # Remove the standard PS1 configuration blocks but keep case statements
    sed -i '/^if \[ -n "\$force_color_prompt" \]; then/,/^fi$/d' "$TEMP_FILE.tmp"
    sed -i '/^if \[ "\$color_prompt" = yes \]; then/,/^unset color_prompt force_color_prompt/d' "$TEMP_FILE.tmp"
    sed -i '/^#force_color_prompt=yes/d' "$TEMP_FILE.tmp"

    # Add the new custom prompt configuration at the end
    cp "$TEMP_FILE.tmp" "$TEMP_FILE"
    echo "" >> "$TEMP_FILE"
    echo "# Custom prompt configuration" >> "$TEMP_FILE"
    echo "PS1='$PS1_VALUE'" >> "$TEMP_FILE"

    rm -f "$TEMP_FILE.tmp"
else
    # No PS1 configuration exists, append to end of file
    cp "$BASHRC" "$TEMP_FILE"
    echo "" >> "$TEMP_FILE"
    echo "# Custom prompt configuration" >> "$TEMP_FILE"
    echo "PS1='$PS1_VALUE'" >> "$TEMP_FILE"
fi

# Replace the original .bashrc
mv "$TEMP_FILE" "$BASHRC"

echo "✓ Installed $PROMPT_NAME prompt"
echo ""
echo "To activate the new prompt, run:"
echo "  source ~/.bashrc"
echo ""
echo "Or simply start a new terminal session."
echo ""
echo "To restore the original prompt, run:"
echo "  cp ~/.bashrc.backup ~/.bashrc && source ~/.bashrc"
