# Caelestia KDE Plasma - Quick Reference

## Installation

```bash
# Quick install
git clone https://github.com/caelestia-dots/caelestia.git ~/.local/share/caelestia
cd ~/.local/share/caelestia
./install-kde.fish

# Or with bash script
./setup-kde.sh --full
```

## Keybindings

| Key | Action |
|-----|--------|
| `Meta + Space` | Application launcher |
| `Meta + #` | Switch to desktop # |
| `Meta + Alt + #` | Move window to desktop # |
| `Meta + T` | Terminal (Foot) |
| `Meta + W` | Browser (Zen) |
| `Meta + C` | IDE (VSCodium) |
| `Meta + E` | File manager (Dolphin) |
| `Meta + Print` | Screenshot |
| `Meta + Shift + Print` | Screenshot (Selection) |
| `Ctrl + Alt + Delete` | Session menu |
| `Ctrl + Meta + Space` | Media play/pause |
| `Ctrl + Meta + Alt + R` | Restart shell |

## Essential Commands

### System
```bash
# Set fish as default shell
chsh -s /usr/bin/fish

# Install Bismuth tiling
yay -S kwin-bismuth

# Install themes
yay -S adw-gtk-theme papirus-icon-theme sweet-cursors ttf-jetbrains-mono-nerd
```

### KDE Configuration
```bash
# Apply KDE settings
kwriteconfig5 --file ~/.config/kdeglobals --group General --key Name "Caelestia"
kwriteconfig5 --file ~/.config/kwinrc --group Compositing --key UnredirectFullScreen true

# Reload KDE settings
kquitapp5 plasmashell && kstart5 plasmashell
```

### Troubleshooting
```bash
# Check KDE logs
journalctl --user -f

# Check KWin logs
qdbus org.kde.KWin /KWin org.kde.KWin.debug

# Check fish configuration
fish --debug-config
```

## Configuration Files

| File | Purpose |
|------|---------|
| `~/.config/kdeglobals` | Global KDE settings |
| `~/.config/kwinrc` | Window manager config |
| `~/.config/kglobalshortcutsrc` | Global shortcuts |
| `~/.config/kcminputrc` | Input device settings |
| `~/.config/color-schemes/Caelestia.colors` | Color scheme |
| `~/.config/environment.d/kde-caelestia.conf` | Environment variables |

## Post-Installation Checklist

- [ ] Log out and log back in
- [ ] Set theme in System Settings → Appearance → Global Theme
- [ ] Install and enable Bismuth tiling extension
- [ ] Set fish as default shell
- [ ] Configure additional keybindings if needed
- [ ] Install optional applications (Spotify, VSCode, Discord, Zen)

## Common Issues & Solutions

### Fish shell not working
```bash
sudo pacman -S fish
chsh -s /usr/bin/fish
```

### Foot terminal not working
```bash
sudo pacman -S foot ttf-jetbrains-mono-nerd
```

### Themes not applying
```bash
yay -S adw-gtk-theme papirus-icon-theme sweet-cursors
# Apply through System Settings → Appearance
```

### Bismuth not working
```bash
yay -S kwin-bismuth
# Enable in System Settings → Workspace → Window Management → KWin Scripts
```

## Customization

### Add custom KDE settings
```bash
# Example: Borderless maximized windows
kwriteconfig5 --file ~/.config/kwinrc --group Windows --key BorderlessMaximizedWindows true

# Example: Disable single-click
kwriteconfig5 --file ~/.config/kdeglobals --group KDE --key SingleClick false
```

### Modify color scheme
Edit `~/.config/color-schemes/Caelestia.colors`

### Add custom keybindings
Edit `~/.config/kglobalshortcutsrc` or use System Settings → Workspace → Shortcuts

## Backup & Restore

### Create backup
```bash
cp -r ~/.config ~/.config.caelestia-backup-$(date +%Y%m%d-%H%M%S)
```

### Restore backup
```bash
rm -rf ~/.config
cp -r ~/.config.caelestia-backup-YYYYMMDD-HHMMSS ~/.config
```

## Useful KDE Commands

```bash
# Open System Settings
systemsettings5

# Open KDE Menu
krunner

# Restart Plasma
kquitapp5 plasmashell && kstart5 plasmashell

# Check KDE version
plasmashell --version

# List KWin effects
qdbus org.kde.KWin /KWin org.kde.KWin.availableEffects
```

## Environment Variables

The following environment variables are set in `~/.config/environment.d/kde-caelestia.conf`:

```bash
export QT_QPA_PLATFORMTHEME='qt5ct'
export QT_AUTO_SCREEN_SCALE_FACTOR='1'
export XCURSOR_THEME='sweet-rainbow'
export XCURSOR_SIZE='24'
export XDG_CURRENT_DESKTOP=KDE
export XDG_SESSION_DESKTOP=plasma
```

## Support

- **Original Caelestia**: https://github.com/caelestia-dots/caelestia
- **KDE Plasma**: https://kde.org/plasma-desktop/
- **Bismuth Tiling**: https://github.com/Bismuth-Forge/bismuth
- **Fish Shell**: https://fishshell.com/
- **Foot Terminal**: https://codeberg.org/dnkl/foot 