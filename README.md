# pretty-bash
A simple bash script with pre-configured PS1 layouts. Supports switching on the fly, and backs up your original .bashrc

# Pretty Bash - V1.0

## 🎯 Features

1. **Preview Mode** (`--preview` or `-p`)
   - Shows all 11 available styles
   - Visual examples with realistic paths
   - Marked recommendations for nested directories

2. **Easy Installation**
   - Simple one-command install
   - Automatic backup of original .bashrc
   - Clear activation instructions

3. **Robust Error Handling**
   - Works with any .bashrc format
   - Won't break if PS1 doesn't exist
   - Won't double-apply changes

## 📋 Quick Commands

```bash
# Preview all styles
./install_prompt.sh --preview

# Install a style (e.g., Arrow Short Path)
./install_prompt.sh 2s

# Activate
source ~/.bashrc

# Restore original
cp ~/.bashrc.backup ~/.bashrc && source ~/.bashrc
```

## ⭐ Recommended Styles for Nested Directories

**2s** - Arrow Style (Short Path)
```
user@hostname components ➜ 
```

**9** - Arrow Minimalist
```
components ➜ 
```

**3s** - Two-Line (Short Path)
```
┌─[user@hostname]─[components]
└─$ 
```

## 🧪 Tested Scenarios

✅ Empty .bashrc  
✅ .bashrc with PS1 configuration  
✅ Default Ubuntu/Debian .bashrc  
✅ Multiple installations (backup safety)  
✅ Preview mode  
✅ All 11 style variants  

## 📁 Files Included

- `install_prompt.sh` - Main installation script
- `README.md` - Full documentation
- `test_installation.sh` - Test verification script

## 🎨 Available Styles

1. Minimalist Color
2. Arrow Style (Full Path)
2s. Arrow Style (Short Path) ⭐
3. Two-Line (Full Path)
3s. Two-Line (Short Path) ⭐
4. Compact Git-Aware
5. Powerline-like
6. Emoji Style
7. Time-Stamped (Full Path)
7s. Time-Stamped (Short Path)
8. Bracket Style
9. Arrow Minimalist ⭐
