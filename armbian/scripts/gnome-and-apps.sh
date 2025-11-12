#!/bin/bash
# https://github.com/PiercingXX

username=$(id -u -n 1000)
builddir=$(pwd)


# Checks for active network connection
if [[ -n "$(command -v nmcli)" && "$(nmcli -t -f STATE g)" != connected ]]; then
    awk '{print}' <<<"Network connectivity is required to continue."
    exit
fi

echo "Updating Repositories"
sudo apt update && sudo apt upgrade -y || true
sudo apt full-upgrade -y
sudo apt install -f
wait
flatpak update

# Install dependencies
    sudo apt install build-essential -y
    sudo apt install linux-firmware -y
    sudo apt install firmware-misc-nonfree -y
    sudo apt install pipx -y
    sudo apt install jq -y
    pipx install gnome-extensions-cli --system-site-packages
    pipx ensurepath
    sudo apt install gnome-shell -y
    sudo apt install gnome-tweaks -y
    sudo apt install dbus-x11 -y
    sudo apt install cups -y
    sudo apt install util-linux -y
    sudo apt install xdg-utils -y
    sudo apt install nautilus -y
    sudo apt install gnome-disk-utility -y
    sudo apt install gnome-calculator -y
    sudo apt install gdebi -y
    sudo apt install fuse -y
    sudo apt install libfuse2 -y
    sudo apt install libinput-tools -y
    sudo apt install x11-xserver-utils -y
    sudo apt install dh-dkms -y
    sudo apt install devscripts -y
    sudo apt install linux-headers-generic -y
    sudo apt install seahorse -y
    sudo apt install rename -y
    sudo apt install mpv -y
    sudo apt install gparted -y
    sudo apt install gh -y
    sudo apt install papirus-icon-theme -y

# Installing fonts
    echo "Installing Fonts"
    cd "$builddir" || exit
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip
    unzip FiraCode.zip -d /home/"$username"/.fonts
    unzip Meslo.zip -d /home/"$username"/.fonts
    unzip NerdFontsSymbolsOnly.zip -d /home/"$username"/.fonts
    sudo rm FiraCode.zip Meslo.zip NerdFontsSymbolsOnly.zip
    sudo apt install fonts-font-awesome fonts-noto-color-emoji -y
    sudo apt install fonts-terminus -y
# Reload Font
    fc-cache -vf
    wait

# Add GDM Banner Message
sudo tee -a /etc/gdm3/greeter.dconf-defaults > /dev/null <<EOF
# - Show a login welcome message
banner-message-enable=true
banner-message-text='Hello Handsome'
EOF
# Finalizing graphical login
    sudo systemctl enable gdm3 --now

# Installing apps
    echo "Installing Apps & Dependencies"
    sudo apt install gnome-software-plugin-flatpak -y
    flatpak install flathub net.waterfox.waterfox -y
    flatpak install flathub com.mattjakeman.ExtensionManager -y
    flatpak install flathub io.missioncenter.MissionCenter -y
    flatpak install flathub io.github.shiftey.Desktop -y
    flatpak install --noninteractive flathub io.github.realmazharhussain.GdmSettings -y

# Remove unwanted apps
    sudo apt remove gnome-terminal --purge -y
    sudo apt remove firefox --purge -y
    sudo apt remove firefox-esr --purge -y
    sudo apt remove evolution --purge -y
    sudo apt remove shotwell --purge -y

# Install Gnome-extensions-cli
    pipx install gnome-extensions-cli --system-site-packages

# VSCode
    wget "https://vscode.download.prss.microsoft.com/dbazure/download/stable/e170252f762678dec6ca2cc69aba1570769a5d39/code_1.88.1-1712771838_amd64.deb"
    wait
    sudo dpkg -i code_1.88.1-1712771838_amd64.deb
    wait
    rm code_1.88.1-1712771838_amd64.deb

# Synology Drive - Do not use the flatpak, it sucks
    wget "https://global.download.synology.com/download/Utility/SynologyDriveClient/3.4.0-15724/Ubuntu/Installer/synology-drive-client-15724.x86_64.deb"
    wait
    sudo dpkg -i synology-drive-client-15724.x86_64.deb
    wait
    rm synology-drive-client-15724.x86_64.deb
    sudo apt --fix-broken install -y

# Proton VPN
    wget https://repo.protonvpn.com/debian/dists/unstable/main/binary-all/protonvpn-beta-release_1.0.8_all.deb
    wait
    sudo dpkg -i ./protonvpn-beta-release_1.0.8_all.deb && sudo apt update
    sudo apt install proton-vpn-gnome-desktop -y
    rm protonvpn-beta-release_1.0.8_all.deb

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
