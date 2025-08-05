# Caelestia for KDE Plasma

This is a KDE Plasma adaptation of the Caelestia dotfiles, originally designed for Hyprland. This version maintains the aesthetic and functionality while being compatible with KDE Plasma.

## What's Different from Hyprland Version

### Removed Components
- **Hyprland-specific configurations**: Window manager configs, keybinds, rules, animations
- **Wayland-specific environment variables**: Replaced with X11/KDE equivalents
- **Hyprland scripts**: Monitor configuration, workspace actions, etc.

### Adapted Components
- **Window Management**: Uses KWin with Bismuth tiling extension
- **Keybindings**: Adapted to KDE Plasma's global shortcuts system
- **Environment**: Configured for X11/KDE instead of Wayland
- **Theme Integration**: Uses KDE's native theming system

### Preserved Components
- **Terminal**: Foot terminal emulator
- **Shell**: Fish shell with Starship prompt
- **System Monitoring**: Btop, Fastfetch
- **Applications**: VSCode, Spotify, Discord, Zen browser configurations
- **Themes**: Color schemes, cursor themes, GTK/Qt themes

## Installation

### Prerequisites
- KDE Plasma desktop environment
- Fish shell installed
- An AUR helper (yay or paru)

### Quick Installation

```bash
# Clone the repository
git clone https://github.com/caelestia-dots/caelestia.git ~/.local/share/caelestia
cd ~/.local/share/caelestia

# Run the KDE installer
./install-kde.fish
```

### Installation Options

```bash
# Install with all optional applications
./install-kde.fish --spotify --vscode=codium --discord --zen

# Install without confirmation prompts
./install-kde.fish --noconfirm

# Use paru instead of yay
./install-kde.fish --paru
```

## Manual Installation

If you prefer to install components manually:

### Dependencies

**KDE Plasma Components:**
- plasma-desktop
- plasma-workspace
- kwin
- dolphin
- konsole
- spectacle
- kate
- kde-gtk-config
- qt5ct
- qt6ct

**Desktop-Agnostic Components:**
- fish
- foot
- fastfetch
- btop
- starship
- jq
- socat
- imagemagick
- curl
- trash-cli

**Themes:**
- adw-gtk-theme
- papirus-icon-theme
- sweet-cursors
- ttf-jetbrains-mono-nerd

### Configuration Files

Copy or symlink the following directories to `~/.config/`:
- `kde/` → KDE Plasma configurations
- `foot/` → Terminal configuration
- `fish/` → Shell configuration
- `fastfetch/` → System fetch configuration
- `btop/` → System monitoring configuration
- `starship.toml` → Shell prompt configuration

## Post-Installation Setup

### 1. Install Bismuth Tiling Extension
For a tiling window manager experience similar to Hyprland:

```bash
# Install Bismuth
yay -S kwin-bismuth

# Enable the extension in KDE System Settings
# System Settings → Workspace → Window Management → KWin Scripts → Get New Scripts
# Search for "Bismuth" and install it
```

### 2. Configure KDE Plasma Settings

1. **System Settings → Appearance → Global Theme**
   - Set theme to "Breeze"
   - Set color scheme to "Caelestia" (if available)
   - Set icons to "Papirus-Dark"
   - Set cursors to "sweet-rainbow"

2. **System Settings → Workspace → Window Management → KWin Scripts**
   - Enable Bismuth for tiling
   - Enable other desired effects

3. **System Settings → Workspace → Shortcuts → Global Shortcuts**
   - Customize keybindings as needed

### 3. Set Fish as Default Shell

```bash
# Set fish as default shell
chsh -s /usr/bin/fish

# Or add to ~/.bashrc if you want to keep bash as login shell
echo 'exec fish' >> ~/.bashrc
```

## Keybindings

The KDE version uses similar keybindings to the Hyprland version:

- `Meta + Space` - Application launcher
- `Meta + #` - Switch to desktop #
- `Meta + T` - Terminal (Foot)
- `Meta + W` - Browser (Zen)
- `Meta + C` - IDE (VSCodium)
- `Meta + E` - File manager (Dolphin)
- `Meta + Print` - Screenshot
- `Ctrl + Alt + Delete` - Session menu
- `Ctrl + Meta + Space` - Media play/pause

## Troubleshooting

### Common Issues

1. **Fish shell not working properly**
   - Ensure fish is installed: `sudo pacman -S fish`
   - Set as default shell: `chsh -s /usr/bin/fish`

2. **Foot terminal not working**
   - Install foot: `sudo pacman -S foot`
   - Ensure font is installed: `sudo pacman -S ttf-jetbrains-mono-nerd`

3. **Themes not applying**
   - Install required themes: `yay -S adw-gtk-theme papirus-icon-theme sweet-cursors`
   - Apply through System Settings → Appearance

4. **Bismuth not working**
   - Install kwin-bismuth: `yay -S kwin-bismuth`
   - Enable in System Settings → Workspace → Window Management → KWin Scripts

### Logs and Debugging

- Check KDE logs: `journalctl --user -f`
- Check KWin logs: `qdbus org.kde.KWin /KWin org.kde.KWin.debug`
- Check fish configuration: `fish --debug-config`

## Customization

### Adding Custom KDE Settings

Create `~/.config/caelestia/kde-custom.conf` for additional KDE settings:

```bash
# Example custom KDE settings
kwriteconfig5 --file ~/.config/kwinrc --group Windows --key BorderlessMaximizedWindows true
kwriteconfig5 --file ~/.config/kdeglobals --group KDE --key SingleClick false
```

### Modifying Themes

The color scheme and themes can be customized by editing the respective configuration files in the `kde/` directory.

## Contributing

This KDE adaptation maintains compatibility with the original Caelestia design while adapting to KDE Plasma's architecture. When contributing:

1. Test changes on a fresh KDE Plasma installation
2. Ensure compatibility with both X11 and Wayland sessions
3. Document any KDE-specific configurations
4. Maintain the aesthetic consistency with the original design

## License

Same as the original Caelestia project. 