# Caelestia KDE Plasma Adaptation

This document explains how the Caelestia dotfiles have been adapted to work with KDE Plasma instead of Hyprland.

## Overview

The original Caelestia dotfiles are designed for Hyprland, a Wayland compositor. This adaptation maintains the aesthetic and functionality while being compatible with KDE Plasma, a more traditional desktop environment.

## Key Differences

### Architecture Changes

| Component | Hyprland Version | KDE Plasma Version |
|-----------|------------------|-------------------|
| **Window Manager** | Hyprland (Wayland) | KWin (X11/Wayland) |
| **Display Protocol** | Wayland | X11 (primary) / Wayland |
| **Tiling** | Native | Bismuth extension |
| **Keybindings** | Hyprland config | KDE Global Shortcuts |
| **Environment** | Wayland-specific | X11/KDE compatible |

### Removed Components

1. **Hyprland Configuration Files**
   - `hypr/hyprland.conf` - Main Hyprland config
   - `hypr/hyprland/` - All sub-configurations
   - `hypr/hypridle.conf` - Idle daemon config
   - `hypr/scripts/` - Hyprland-specific scripts

2. **Wayland-Specific Environment**
   - `uwsm/env-hyprland` - Wayland environment variables
   - Hyprland-specific XDG variables

3. **Hyprland Scripts**
   - Monitor configuration scripts
   - Workspace action scripts
   - Override generation scripts

### Added Components

1. **KDE Configuration Files**
   - `kde/kdeglobals` - Global KDE settings
   - `kde/kwinrc` - KWin window manager config
   - `kde/kglobalshortcutsrc` - Global shortcuts
   - `kde/kcminputrc` - Input device settings
   - `kde/colors/Caelestia.colors` - Color scheme

2. **KDE-Specific Scripts**
   - `install-kde.fish` - KDE installation script
   - `setup-kde.sh` - Bash setup script

## Installation Methods

### Method 1: Fish Script (Recommended)
```bash
# Clone the repository
git clone https://github.com/caelestia-dots/caelestia.git ~/.local/share/caelestia
cd ~/.local/share/caelestia

# Run the KDE installer
./install-kde.fish
```

### Method 2: Bash Script
```bash
# Clone the repository
git clone https://github.com/caelestia-dots/caelestia.git ~/.local/share/caelestia
cd ~/.local/share/caelestia

# Run the bash setup script
chmod +x setup-kde.sh
./setup-kde.sh --full
```

### Method 3: Manual Installation
1. Install dependencies manually
2. Copy configuration files to `~/.config/`
3. Set up environment variables
4. Configure KDE Plasma settings

## Configuration Details

### KDE Global Settings (`kdeglobals`)
- **Theme**: Breeze widget style
- **Icons**: Papirus-Dark
- **Cursors**: sweet-rainbow
- **Fonts**: JetBrains Mono NF
- **Color Scheme**: Caelestia

### KWin Window Manager (`kwinrc`)
- **Compositing**: OpenGL backend
- **Effects**: Various animations enabled
- **Window Behavior**: Click-to-focus, borderless maximized
- **Desktops**: 10 virtual desktops

### Global Shortcuts (`kglobalshortcutsrc`)
- **Meta + Space**: Application launcher
- **Meta + #**: Switch to desktop #
- **Meta + T**: Terminal
- **Meta + W**: Browser
- **Meta + C**: IDE
- **Meta + E**: File manager
- **Meta + Print**: Screenshot

### Input Settings (`kcminputrc`)
- **Keyboard**: 250ms repeat delay, 35 repeat rate
- **Mouse**: Left-handed, sweet-rainbow cursor
- **Touchpad**: Natural scrolling disabled

## Post-Installation Setup

### 1. Install Bismuth Tiling
```bash
# Install the tiling extension
yay -S kwin-bismuth

# Enable in KDE System Settings
# System Settings → Workspace → Window Management → KWin Scripts
# Search for "Bismuth" and install it
```

### 2. Configure KDE Plasma
1. **System Settings → Appearance → Global Theme**
   - Theme: Breeze
   - Color Scheme: Caelestia
   - Icons: Papirus-Dark
   - Cursors: sweet-rainbow

2. **System Settings → Workspace → Window Management → KWin Scripts**
   - Enable Bismuth
   - Enable desired effects

3. **System Settings → Workspace → Shortcuts → Global Shortcuts**
   - Customize keybindings as needed

### 3. Set Fish as Default Shell
```bash
# Set fish as default shell
chsh -s /usr/bin/fish

# Or add to ~/.bashrc
echo 'exec fish' >> ~/.bashrc
```

## Troubleshooting

### Common Issues

1. **Fish shell not working**
   ```bash
   # Install fish
   sudo pacman -S fish
   
   # Set as default
   chsh -s /usr/bin/fish
   ```

2. **Foot terminal not working**
   ```bash
   # Install foot
   sudo pacman -S foot
   
   # Install font
   sudo pacman -S ttf-jetbrains-mono-nerd
   ```

3. **Themes not applying**
   ```bash
   # Install themes
   yay -S adw-gtk-theme papirus-icon-theme sweet-cursors
   
   # Apply through System Settings
   ```

4. **Bismuth not working**
   ```bash
   # Install kwin-bismuth
   yay -S kwin-bismuth
   
   # Enable in System Settings
   ```

### Debugging

- **KDE logs**: `journalctl --user -f`
- **KWin logs**: `qdbus org.kde.KWin /KWin org.kde.KWin.debug`
- **Fish config**: `fish --debug-config`

## Customization

### Adding Custom KDE Settings
```bash
# Example: Set borderless maximized windows
kwriteconfig5 --file ~/.config/kwinrc --group Windows --key BorderlessMaximizedWindows true

# Example: Disable single-click
kwriteconfig5 --file ~/.config/kdeglobals --group KDE --key SingleClick false
```

### Modifying Themes
Edit the configuration files in the `kde/` directory:
- `kdeglobals` - Global appearance
- `kwinrc` - Window manager behavior
- `colors/Caelestia.colors` - Color scheme

## Comparison with Original

### What's Preserved
- **Aesthetic**: Color scheme, fonts, icons, cursors
- **Applications**: VSCode, Spotify, Discord, Zen browser configs
- **Shell**: Fish shell with Starship prompt
- **Terminal**: Foot terminal emulator
- **System Tools**: Btop, Fastfetch

### What's Adapted
- **Window Management**: Hyprland → KWin + Bismuth
- **Keybindings**: Hyprland config → KDE Global Shortcuts
- **Environment**: Wayland → X11/KDE
- **Theming**: Hyprland-specific → KDE native

### What's Removed
- **Hyprland-specific features**: Native tiling, Wayland-specific optimizations
- **Hyprland scripts**: Monitor config, workspace actions
- **Wayland environment**: XDG variables, display protocol specifics

## Benefits of KDE Adaptation

1. **Compatibility**: Works on more systems and hardware
2. **Stability**: KDE Plasma is more mature and stable
3. **Familiarity**: Traditional desktop environment
4. **Flexibility**: Easy to customize through GUI
5. **Ecosystem**: Rich application ecosystem

## Limitations

1. **Performance**: May not be as performant as Hyprland
2. **Tiling**: Requires extension (Bismuth) for tiling
3. **Wayland**: Primary support is X11, Wayland support is secondary
4. **Customization**: Less low-level customization than Hyprland

## Conclusion

This KDE Plasma adaptation successfully brings the Caelestia aesthetic and functionality to a more traditional desktop environment. While it may not offer the same level of performance or customization as the original Hyprland version, it provides excellent compatibility and stability for users who prefer or require KDE Plasma.

The adaptation maintains the core philosophy of Caelestia while adapting to KDE Plasma's architecture and conventions. 