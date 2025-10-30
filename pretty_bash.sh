#!/bin/bash

# Script to install a new bash prompt style

# Function to show preview of all styles
show_preview() {
    echo "========================================="
    echo "  Bash Prompt Style Preview"
    echo "========================================="
    echo ""

    # Simulate being in a nested directory
    echo "Preview assumes you're in: /home/user/projects/repo/src/components"
    echo "Current folder: components"
    echo ""

    echo "1. Minimalist Color"
    echo "   user:components$ "
    echo ""

    echo "2. Arrow Style (Full Path)"
    echo "   user@hostname /home/user/projects/repo/src/components ➜ "
    echo ""

    echo "2s. Arrow Style (Short Path)"
    echo "   user@hostname components ➜ "
    echo ""

    echo "3. Two-Line (Full Path)"
    echo "   ┌─[user@hostname]─[/home/user/projects/repo/src/components]"
    echo "   └─$ "
    echo ""

    echo "3s. Two-Line (Short Path)"
    echo "   ┌─[user@hostname]─[components]"
    echo "   └─$ "
    echo ""

    echo "4. Compact Git-Aware (shows branch if in git repo)"
    echo "   user components (main) $ "
    echo ""

    echo "5. Powerline-like"
    echo "   ▶ user ▶ components ▶ "
    echo ""

    echo "6. Emoji Style"
    echo "   🚀 user components $ "
    echo ""

    echo "7. Time-Stamped (Full Path)"
    echo "   [14:23:45] user@hostname:/home/user/projects/repo/src/components$ "
    echo ""

    echo "7s. Time-Stamped (Short Path)"
    echo "   [14:23:45] user@hostname:components$ "
    echo ""

    echo "8. Bracket Style"
    echo "   [user@hostname]─[components]$ "
    echo ""

    echo "9. Arrow Minimalist (Short Path Only)"
    echo "   components ➜ "
    echo ""

    echo "========================================="
    echo "To install a style, run:"
    echo "  $0 <style_number>"
    echo ""
    echo "Examples:"
    echo "  $0 2s    (Arrow with short path)"
    echo "  $0 9     (Minimalist arrow)"
    echo "========================================="
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

# More robust approach: Check if PS1 configuration exists
if grep -q "PS1=" "$BASHRC"; then
    # PS1 exists, replace it
    awk -v new_ps1="$PS1_VALUE" '
        BEGIN {
            in_ps1_section = 0
            ps1_replaced = 0
            in_color_check = 0
            skip_until_fi = 0
        }

        # Skip the force_color_prompt check block
        /^if \[ -n "\$force_color_prompt" \]; then/ {
            in_color_check = 1
            next
        }

        in_color_check == 1 {
            if (/^fi$/) {
                in_color_check = 0
            }
            next
        }

        # Skip the xterm-color case block
        /^case "\$TERM" in/,/^esac$/ {
            if (/xterm-color.*color_prompt=yes/) next
            if (/^case "\$TERM" in/ || /^esac$/) next
        }

        # Detect start of PS1 configuration block
        /^if \[ "\$color_prompt" = yes \]; then/ {
            in_ps1_section = 1
            print "# Custom prompt configuration"
            print "PS1=\"" new_ps1 "\""
            ps1_replaced = 1
            skip_until_fi = 1
            next
        }

        # Skip everything until we find the matching unset
        skip_until_fi == 1 {
            if (/^unset color_prompt force_color_prompt/) {
                skip_until_fi = 0
                next
            }
            next
        }

        # Skip standalone PS1 assignments
        /^PS1=/ && ps1_replaced == 0 {
            if (!ps1_replaced) {
                print "# Custom prompt configuration"
                print "PS1=\"" new_ps1 "\""
                ps1_replaced = 1
            }
            next
        }

        # Skip commented force_color_prompt
        /^#force_color_prompt=yes/ { next }

        # Print all other lines
        { print }
    ' "$BASHRC" > "$TEMP_FILE"
else
    # No PS1 configuration exists, append to end of file
    cp "$BASHRC" "$TEMP_FILE"
    cat >> "$TEMP_FILE" << EOF

# Custom prompt configuration
PS1="$PS1_VALUE"
EOF
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
