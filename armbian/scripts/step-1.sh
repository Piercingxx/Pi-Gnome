#!/bin/bash
# https://github.com/PiercingXX

username=$(id -u -n 1000)
builddir=$(pwd)


# Create Directories if needed
    # font directory
        if [ ! -d "$HOME/.fonts" ]; then
            mkdir -p "$HOME/.fonts"
        fi
        chown -R "$username":"$username" "$HOME"/.fonts
    # config directory
        if [ ! -d "$HOME/.config" ]; then
            mkdir -p /home/"$username"/.config
        fi
        chown -R "$username":"$username" /home/"$username"/.config
    # icons directory
        if [ ! -d "$HOME/.icons" ]; then
            mkdir -p /home/"$username"/.icons
        fi
        chown -R "$username":"$username" /home/"$username"/.icons
    # Background and Profile Image Directories
        if [ ! -d "$HOME/$username/Pictures/backgrounds" ]; then
            mkdir -p /home/"$username"/Pictures/backgrounds
        fi
        chown -R "$username":"$username" /home/"$username"/Pictures/backgrounds
        if [ ! -d "$HOME/$username/Pictures/profile-image" ]; then
            mkdir -p /home/"$username"/Pictures/profile-image
        fi
        chown -R "$username":"$username" /home/"$username"/Pictures/profile-image

# Update System
    echo -e "${YELLOW}Updating System...${NC}"  
        sudo apt update && sudo apt upgrade -y || true
        wait
        sudo apt full-upgrade -y
        wait
        sudo apt install -f
        wait
        sudo dpkg --configure -a
        sudo apt --fix-broken install -y
        wait
        sudo apt autoremove -y
        sudo apt update && sudo apt upgrade -y || true
    # Check if nala is installed
        if ! command_exists nala; then
            echo "nala is not installed. Installing now..."
            sudo apt install nala -y
        fi
        wait
    # Install flatpak
        sudo apt install flatpak -y
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        wait
        # Add Flatpak directories to XDG_DATA_DIRS
        export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:/home/$USER/.local/share/flatpak/exports/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
        source ~/.profile
        flatpak update -y
    wait

# Install dependencies
    sudo apt install fwupd -y
    sudo apt install ssh -y
    sudo apt install wget gpg zip unzip gzip tar make curl gcc gettext -y
    sudo apt install build-essential gcc libc6-dev -y
    sudo apt install gcc-aarch64-linux-gnu libc6-dev-arm64-cross -y
    sudo apt install kitty -y
    sudo apt install dconf* -y
    sudo apt install network-manager -y

# Ensure Rust is installed
    if ! command_exists cargo; then
        echo -e "${YELLOW}Installing Rust toolchain…${NC}"
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        rustup update
        # Load the new cargo environment for this shell
        source "$HOME/.cargo/env"
    fi

# Extras for yazi
    sudo apt install ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick -y
# Install yazi and ya
    rm -rf ~/.config/yazi/plugins/*
    cargo install --locked yazi-cli
# Install plugins
    ya pkg add dedukun/bookmarks
    ya pkg add yazi-rs/plugins:mount
    ya pkg add dedukun/relative-motions
    ya pkg add yazi-rs/plugins:chmod
    ya pkg add yazi-rs/plugins:smart-enter
    ya pkg add AnirudhG07/rich-preview
    ya pkg add grappas/wl-clipboard
    ya pkg add Rolv-Apneseth/starship
    ya pkg add yazi-rs/plugins:full-border
    ya pkg add uhs-robert/recycle-bin
    ya pkg add yazi-rs/plugins:diff


# Firewall
    sudo apt install ufw -y
    sudo ufw allow SSH


# Nvim & Depends
    sudo apt install neovim -y
    sudo apt install lua5.4 -y
    sudo apt install npm -y
    sudo apt install ripgrep -y
    sudo apt install python3-pip -y
    sudo apt install pipx python3-venv -y
    pipx install pynvim

# Tailscale
    curl -fsSL https://tailscale.com/install.sh | sh
    wait

# Overkill is underrated 
    sudo apt update && sudo apt upgrade -y || true
    wait
    sudo apt full-upgrade -y
    wait
    sudo apt install -f
    wait
    sudo dpkg --configure -a
    sudo apt --fix-broken install -y
    wait
    sudo apt autoremove -y
    sudo apt update && sudo apt upgrade -y || true
    wait
    flatpak update -y
