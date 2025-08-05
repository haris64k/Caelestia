#!/bin/bash

# Caelestia KDE Plasma Simple Installer
# This script installs the KDE Plasma version of Caelestia dotfiles

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log() {
    echo -e "${BLUE}::${NC} $1"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

# Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$CONFIG_DIR.caelestia-backup-$(date +%Y%m%d-%H%M%S)"

# Check if running on Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    error "This script is designed for Linux systems only."
    exit 1
fi

# Check if KDE Plasma is running
if [[ "$XDG_CURRENT_DESKTOP" != "KDE" ]] && [[ "$XDG_SESSION_DESKTOP" != "plasma" ]]; then
    warning "KDE Plasma doesn't appear to be running. Some features may not work correctly."
fi

log "Caelestia KDE Plasma Simple Installer"
log "Script directory: $SCRIPT_DIR"
log "Config directory: $CONFIG_DIR"

# Create backup
if [[ -d "$CONFIG_DIR" ]]; then
    log "Creating backup of existing config..."
    cp -r "$CONFIG_DIR" "$BACKUP_DIR"
    success "Backup created at: $BACKUP_DIR"
fi

# Create necessary directories
log "Creating configuration directories..."
mkdir -p "$CONFIG_DIR/environment.d"
mkdir -p "$CONFIG_DIR/color-schemes"

# Install KDE configurations
log "Installing KDE Plasma configurations..."

# Copy KDE config files
if [[ -d "$SCRIPT_DIR/kde" ]]; then
    cp -r "$SCRIPT_DIR/kde"/* "$CONFIG_DIR/"
    success "KDE configurations installed"
else
    error "KDE configuration directory not found"
    exit 1
fi

# Copy color scheme
if [[ -f "$SCRIPT_DIR/kde/colors/Caelestia.colors" ]]; then
    cp "$SCRIPT_DIR/kde/colors/Caelestia.colors" "$CONFIG_DIR/color-schemes/"
    success "Color scheme installed"
fi

# Install desktop-agnostic configurations
log "Installing desktop-agnostic configurations..."

# Foot terminal
if [[ -d "$SCRIPT_DIR/foot" ]]; then
    ln -sf "$SCRIPT_DIR/foot" "$CONFIG_DIR/foot"
    success "Foot terminal configuration installed"
fi

# Fish shell
if [[ -d "$SCRIPT_DIR/fish" ]]; then
    ln -sf "$SCRIPT_DIR/fish" "$CONFIG_DIR/fish"
    success "Fish shell configuration installed"
fi

# Fastfetch
if [[ -d "$SCRIPT_DIR/fastfetch" ]]; then
    ln -sf "$SCRIPT_DIR/fastfetch" "$CONFIG_DIR/fastfetch"
    success "Fastfetch configuration installed"
fi

# Btop
if [[ -d "$SCRIPT_DIR/btop" ]]; then
    ln -sf "$SCRIPT_DIR/btop" "$CONFIG_DIR/btop"
    success "Btop configuration installed"
fi

# Starship
if [[ -f "$SCRIPT_DIR/starship.toml" ]]; then
    ln -sf "$SCRIPT_DIR/starship.toml" "$CONFIG_DIR/starship.toml"
    success "Starship configuration installed"
fi

# Create environment file
log "Setting up environment variables..."
cat > "$CONFIG_DIR/environment.d/kde-caelestia.conf" << 'EOF'
# Caelestia KDE Plasma Environment
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export XCURSOR_THEME=sweet-rainbow
export XCURSOR_SIZE=24
export XDG_CURRENT_DESKTOP=KDE
export XDG_SESSION_DESKTOP=plasma
EOF

success "Environment configuration created"

# Check for AUR helper
if command -v yay &> /dev/null; then
    AUR_HELPER="yay"
elif command -v paru &> /dev/null; then
    AUR_HELPER="paru"
else
    warning "No AUR helper found. You may need to install packages manually."
    AUR_HELPER=""
fi

# Final instructions
echo
success "Caelestia KDE Plasma setup complete!"
echo
log "Next steps:"
echo "1. Log out and log back in for all changes to take effect"
echo "2. Open System Settings → Appearance → Global Theme"
echo "   - Set theme to 'Breeze'"
echo "   - Set color scheme to 'Caelestia'"
echo "   - Set icons to 'Papirus-Dark'"
echo "   - Set cursors to 'sweet-rainbow'"
if [[ -n "$AUR_HELPER" ]]; then
    echo "3. Install additional packages: $AUR_HELPER -S kwin-bismuth adw-gtk-theme papirus-icon-theme sweet-cursors ttf-jetbrains-mono-nerd"
fi
echo "4. Set fish as default shell: chsh -s /usr/bin/fish"
echo
log "Backup location: $BACKUP_DIR"
echo
success "Enjoy your new Caelestia KDE Plasma setup!" 