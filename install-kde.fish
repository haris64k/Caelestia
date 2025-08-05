#!/usr/bin/env fish

argparse -n 'install-kde.fish' -X 0 \
    'h/help' \
    'noconfirm' \
    'spotify' \
    'vscode=?!contains -- "$_flag_value" codium code' \
    'discord' \
    'zen' \
    'paru' \
    -- $argv
or exit

# Print help
if set -q _flag_h
    echo 'usage: ./install-kde.fish [-h] [--noconfirm] [--spotify] [--vscode] [--discord] [--paru]'
    echo
    echo 'options:'
    echo '  -h, --help                  show this help message and exit'
    echo '  --noconfirm                 do not confirm package installation'
    echo '  --spotify                   install Spotify (Spicetify)'
    echo '  --vscode=[codium|code]      install VSCodium (or VSCode)'
    echo '  --discord                   install Discord (OpenAsar + Equicord)'
    echo '  --zen                       install Zen browser'
    echo '  --paru                      use paru instead of yay as AUR helper'

    exit
end


# Helper funcs
function _out -a colour text
    set_color $colour
    # Pass arguments other than text to echo
    echo $argv[3..] -- ":: $text"
    set_color normal
end

function log -a text
    _out cyan $text $argv[2..]
end

function success -a text
    _out green $text $argv[2..]
end

function input -a text
    _out blue $text $argv[2..]
end

function confirm-overwrite -a path
    if test -e $path -o -L $path
        # No prompt if noconfirm
        if set -q noconfirm
            input "$path already exists. Overwrite? [Y/n]"
            log 'Removing...'
            rm -rf $path
        else
            # Prompt user
            read -l -p "input '$path already exists. Overwrite? [Y/n] ' -n" confirm || exit 1

            if test "$confirm" = 'n' -o "$confirm" = 'N'
                log 'Skipping...'
                return 1
            else
                log 'Removing...'
                rm -rf $path
            end
        end
    end

    return 0
end


# Variables
set -q _flag_noconfirm && set noconfirm '--noconfirm'
set -q _flag_paru && set -l aur_helper paru || set -l aur_helper yay

# Set config and state directories
set -l config $HOME/.config
set -l state $HOME/.local/state

# Startup prompt
set_color magenta
echo '╭─────────────────────────────────────────────────╮'
echo '│      ______           __          __  _         │'
echo '│     / ____/___ ____  / /__  _____/ /_(_)___ _   │'
echo '│    / /   / __ `/ _ \/ / _ \/ ___/ __/ / __ `/   │'
echo '│   / /___/ /_/ /  __/ /  __(__  ) /_/ / /_/ /    │'
echo '│   \____/\__,_/\___/_/\___/____/\__/_/\__,_/     │'
echo '│                                                 │'
echo '╰─────────────────────────────────────────────────╯'
set_color normal
log 'Welcome to the Caelestia dotfiles installer for KDE Plasma!'
log 'Before continuing, please ensure you have made a backup of your config directory.'

# Prompt for backup
if ! set -q _flag_noconfirm
    log '[1] Two steps ahead of you!  [2] Make one for me please!'
    read -l -p "input '=> ' -n" choice || exit 1

    if contains -- "$choice" 1 2
        if test $choice = 2
            log "Backing up $config..."

            if test -e $config.bak -o -L $config.bak
                read -l -p "input 'Backup already exists. Overwrite? [Y/n] ' -n" overwrite || exit 1

                if test "$overwrite" = 'n' -o "$overwrite" = 'N'
                    log 'Skipping...'
                else
                    rm -rf $config.bak
                    cp -r $config $config.bak
                end
            else
                cp -r $config $config.bak
            end
        end
    else
        log 'No choice selected. Exiting...'
        exit 1
    end
end


# Install AUR helper if not already installed
if ! pacman -Q $aur_helper &> /dev/null
    log "$aur_helper not installed. Installing..."

    # Install
    sudo pacman -S --needed git base-devel $noconfirm
    cd /tmp
    git clone https://aur.archlinux.org/$aur_helper.git
    cd $aur_helper
    makepkg -si
    cd ..
    rm -rf $aur_helper

    # Setup
    $aur_helper -Y --gendb
    $aur_helper -Y --devel --save
end

# Install KDE-specific dependencies
log 'Installing KDE Plasma dependencies...'
$aur_helper -S --needed \
    plasma-desktop \
    plasma-workspace \
    kwin \
    dolphin \
    konsole \
    spectacle \
    kate \
    kde-gtk-config \
    qt5ct \
    qt6ct \
    adw-gtk-theme \
    papirus-icon-theme \
    sweet-cursors \
    ttf-jetbrains-mono-nerd \
    $noconfirm

# Install desktop-agnostic dependencies
log 'Installing desktop-agnostic dependencies...'
$aur_helper -S --needed \
    fish \
    foot \
    fastfetch \
    btop \
    starship \
    jq \
    socat \
    imagemagick \
    curl \
    trash-cli \
    sweet-cursors \
    papirus-icon-theme \
    adw-gtk-theme \
    ttf-jetbrains-mono-nerd \
    $noconfirm

# Cd into dir
cd (dirname (status filename)) || exit 1

# Install KDE Plasma configs
if confirm-overwrite $config/kdeglobals
    log 'Installing KDE Plasma global config...'
    ln -s (realpath kde/kdeglobals) $config/kdeglobals
end

if confirm-overwrite $config/kwinrc
    log 'Installing KWin config...'
    ln -s (realpath kde/kwinrc) $config/kwinrc
end

if confirm-overwrite $config/kglobalshortcutsrc
    log 'Installing KDE shortcuts config...'
    ln -s (realpath kde/kglobalshortcutsrc) $config/kglobalshortcutsrc
end

if confirm-overwrite $config/kcminputrc
    log 'Installing KDE input config...'
    ln -s (realpath kde/kcminputrc) $config/kcminputrc
end

# Starship
if confirm-overwrite $config/starship.toml
    log 'Installing starship config...'
    ln -s (realpath starship.toml) $config/starship.toml
end

# Foot
if confirm-overwrite $config/foot
    log 'Installing foot config...'
    ln -s (realpath foot) $config/foot
end

# Fish
if confirm-overwrite $config/fish
    log 'Installing fish config...'
    ln -s (realpath fish) $config/fish
end

# Fastfetch
if confirm-overwrite $config/fastfetch
    log 'Installing fastfetch config...'
    ln -s (realpath fastfetch) $config/fastfetch
end

# Btop
if confirm-overwrite $config/btop
    log 'Installing btop config...'
    ln -s (realpath btop) $config/btop
end

# Install spicetify
if set -q _flag_spotify
    log 'Installing spotify (spicetify)...'

    set -l has_spicetify (pacman -Q spicetify-cli 2> /dev/null)
    $aur_helper -S --needed spotify spicetify-cli spicetify-marketplace-bin $noconfirm

    # Set permissions and init if new install
    if test -z "$has_spicetify"
        sudo chmod a+wr /opt/spotify
        sudo chmod a+wr /opt/spotify/Apps -R
        spicetify backup apply
    end

    # Install configs
    if confirm-overwrite $config/spicetify
        log 'Installing spicetify config...'
        ln -s (realpath spicetify) $config/spicetify

        # Set spicetify configs
        spicetify config current_theme caelestia color_scheme caelestia custom_apps marketplace 2> /dev/null
        spicetify apply
    end
end

# Install vscode
if set -q _flag_vscode
    test "$_flag_vscode" = 'code' && set -l prog 'code' || set -l prog 'codium'
    test "$_flag_vscode" = 'code' && set -l packages 'code' || set -l packages 'vscodium-bin' 'vscodium-bin-marketplace'
    test "$_flag_vscode" = 'code' && set -l folder 'Code' || set -l folder 'VSCodium'
    set -l folder $config/$folder/User

    log "Installing vs$prog..."
    $aur_helper -S --needed $packages $noconfirm

    # Install configs
    if confirm-overwrite $folder/settings.json && confirm-overwrite $folder/keybindings.json && confirm-overwrite $config/$prog-flags.conf
        log "Installing vs$prog config..."
        ln -s (realpath vscode/settings.json) $folder/settings.json
        ln -s (realpath vscode/keybindings.json) $folder/keybindings.json
        ln -s (realpath vscode/flags.conf) $config/$prog-flags.conf

        # Install extension
        $prog --install-extension vscode/caelestia-vscode-integration/caelestia-vscode-integration-*.vsix
    end
end

# Install discord
if set -q _flag_discord
    log 'Installing discord...'
    $aur_helper -S --needed discord equicord-installer-bin $noconfirm

    # Install OpenAsar and Equicord
    sudo Equilotl -install -location /opt/discord
    sudo Equilotl -install-openasar -location /opt/discord

    # Remove installer
    $aur_helper -Rns equicord-installer-bin $noconfirm
end

# Install zen
if set -q _flag_zen
    log 'Installing zen...'
    $aur_helper -S --needed zen-browser-bin $noconfirm

    # Install userChrome css
    set -l chrome $HOME/.zen/*/chrome
    if confirm-overwrite $chrome/userChrome.css
        log 'Installing zen userChrome...'
        ln -s (realpath zen/userChrome.css) $chrome/userChrome.css
    end

    # Install native app
    set -l hosts $HOME/.mozilla/native-messaging-hosts
    set -l lib $HOME/.local/lib/caelestia

    if confirm-overwrite $hosts/caelestiafox.json
        log 'Installing zen native app manifest...'
        mkdir -p $hosts
        cp zen/native_app/manifest.json $hosts/caelestiafox.json
        sed -i "s|{{ \$lib }}|$lib|g" $hosts/caelestiafox.json
    end

    if confirm-overwrite $lib/caelestiafox
        log 'Installing zen native app...'
        mkdir -p $lib
        ln -s (realpath zen/native_app/app.fish) $lib/caelestiafox
    end

    # Prompt user to install extension
    log 'Please install the CaelestiaFox extension from https://addons.mozilla.org/en-US/firefox/addon/caelestiafox if you have not already done so.'
end

# Set up KDE Plasma environment
log 'Setting up KDE Plasma environment...'

# Create KDE environment file
if confirm-overwrite $config/environment.d/kde-caelestia.conf
    log 'Installing KDE environment config...'
    mkdir -p $config/environment.d
    echo '# Caelestia KDE Plasma Environment' > $config/environment.d/kde-caelestia.conf
    echo 'export QT_QPA_PLATFORMTHEME=qt5ct' >> $config/environment.d/kde-caelestia.conf
    echo 'export QT_AUTO_SCREEN_SCALE_FACTOR=1' >> $config/environment.d/kde-caelestia.conf
    echo 'export XCURSOR_THEME=sweet-rainbow' >> $config/environment.d/kde-caelestia.conf
    echo 'export XCURSOR_SIZE=24' >> $config/environment.d/kde-caelestia.conf
    echo 'export XDG_CURRENT_DESKTOP=KDE' >> $config/environment.d/kde-caelestia.conf
    echo 'export XDG_SESSION_DESKTOP=plasma' >> $config/environment.d/kde-caelestia.conf
end

# Install color scheme
log 'Installing color scheme...'
mkdir -p $HOME/.local/share/color-schemes
if test -f (pwd)/kde/colors/Caelestia.colors
    cp (pwd)/kde/colors/Caelestia.colors $HOME/.local/share/color-schemes/
    success 'Color scheme installed'
end

# Apply KDE settings
log 'Applying KDE Plasma settings...'
kwriteconfig5 --file $config/kdeglobals --group General --key Name "Caelestia"
kwriteconfig5 --file $config/kwinrc --group Compositing --key UnredirectFullScreen true
kwriteconfig5 --file $config/kwinrc --group Compositing --key Backend "OpenGL"

# Set color scheme and cursor theme
kwriteconfig5 --file $config/kdeglobals --group General --key ColorScheme "Caelestia"
kwriteconfig5 --file $config/kcminputrc --group Mouse --key CursorTheme "sweet-rainbow"
kwriteconfig5 --file $config/kdeglobals --group Icons --key Theme "Papirus-Dark"
kwriteconfig5 --file $config/kdeglobals --group KDE --key widgetStyle "Breeze"

log 'Done! Please log out and log back in for all changes to take effect.'
log 'You may need to manually configure some KDE Plasma settings through System Settings.' 