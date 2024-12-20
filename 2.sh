#!/bin/bash

# https://github.com/Piercing666

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo su then try again" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

echo "Starting Script 2.sh"
sleep 2

# Checks for active network connection
if [[ -n "$(command -v nmcli)" && "$(nmcli -t -f STATE g)" != connected ]]; then
  awk '{print}' <<<"Network connectivity is required to continue."
  exit
fi

echo "Updating Repositiories"
sleep 2
sudo apt update && upgrade -y
wait


# Making .config and.fonts Directories
cd "$builddir" || exit
mkdir -p /home/"$username"/.config
chown -R "$username":"$username" /home/"$username"/.config
mkdir -p /home/"$username"/.fonts
chown -R "$username":"$username" /home/"$username"/.fonts
mkdir -p /home/"$username"/.local/share/gnome-shell/extensions/
chown -R "$username":"$username" /home/"$username"/.local/share/gnome-shell/extensions/
mkdir -p /root/.icons
chown -R root:root /root/.icons
mkdir -p /home/"$username"/Pictures/backgrounds
chown -R "$username":"$username" /home/"$username"/Pictures/backgrounds
cp -R dotconf/kitty /home/"$username"/.config/
chown -R "$username":"$username" /home/"$username"/.config/kitty



# Installing important things && stuff && some dependancies
echo "Installing Programs and Drivers"
sleep 2
apt install dbus-x11 -y
apt install cups -y
apt install util-linux -y
apt install xdg-utils -y
apt install libnvidia-egl-wayland -y
apt install build-essential -y
apt install gnome-tweaks -y
apt install nautilus -y
apt install gnome-shell-extension-manager -y
apt install gdebi -y
apt install fuse -y
apt install libfuse2 -y
apt install x11-xserver-utils -y
apt install dh-dkms -y
apt install devscripts -y
apt install papirus-icon-theme -y
apt install fonts-noto-color-emoji -y
apt install zip unzip gzip tar -y
apt install make -y
apt install linux-headers-generic -y
apt install seahorse -y
apt install gnome-calculator -y
apt install rename -y
apt install neofetch -y
apt install mpv -y
apt install gparted -y
apt install curl -y
apt install gh -y
apt install gnome-disk-utility -y

flatpak install flathub one.ablaze.floorp -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub md.obsidian.Obsidian -y
flatpak install flathub com.dropbox.Client -y
flatpak install flathub org.libreoffice.LibreOffice -y
flatpak install flathub org.gnome.SimpleScan -y
flatpak install flathub com.usebottles.bottles -y
flatpak install flathub com.github.tchx84.Flatseal -y
flatpak install flathub org.qbittorrent.qBittorrent -y
flatpak install flathub io.missioncenter.MissionCenter -y
flatpak install flathub com.tomjwatson.Emote -y

# Install Gnome-extensions-cli
pipx install gnome-extensions-cli --system-site-packages

# VSCode
wget "https://vscode.download.prss.microsoft.com/dbazure/download/stable/e170252f762678dec6ca2cc69aba1570769a5d39/code_1.88.1-1712771838_amd64.deb"
wait
dpkg -i code_1.88.1-1712771838_amd64.deb
wait
rm code_1.88.1-1712771838_amd64.deb

# Synology Drive
wget "https://global.download.synology.com/download/Utility/SynologyDriveClient/3.4.0-15724/Ubuntu/Installer/synology-drive-client-15724.x86_64.deb"
wait
sudo dpkg -i synology-drive-client-15724.x86_64.deb
wait

# Synology Chat
apt install gir1.2-ayatanaappindicator3-0.1 -y
wget "https://global.synologydownload.com/download/Utility/ChatClient/1.2.2-0222/Ubuntu/x86_64/Synology%20Chat%20Client-1.2.2-0222.deb"
wait
dpkg -i Synology%20Chat%20Client-1.2.2-0222.deb
wait


sudo apt update
wait
sudo apt upgrade -y
wait


echo "Installing Cursors & Icons"
sleep 2
# Cursor
wget -cO- https://github.com/phisch/phinger-cursors/releases/latest/download/phinger-cursors-variants.tar.bz2 | tar xfj - -C ~/.icons

# Install Nordzy cursor
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors || exit
./install.sh
cd "$builddir" || exit
rm -rf Nordzy-cursors


echo "Installing Fonts"
sleep 2
# Installing fonts
cd "$builddir" || exit
apt install fonts-font-awesome fonts-noto-color-emoji -y
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
chmod -R 777 FiraCode.zip
unzip FiraCode.zip -d /home/"$username"/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
chmod -R 777 Meslo.zip
unzip Meslo.zip -d /home/"$username"/.fonts
mv dotfonts/fontawesome/otfs/*.otf /home/"$username"/.fonts/
chown -R "$username":"$username" /home/"$username"/.fonts
apt install ttf-mscorefonts-installer -y
apt install fonts-terminus -y

# Reloading Font
fc-cache -vf
wait


# Extensions
echo "Gnome Extensions"
sleep 2
apt install gnome-shell-extension-appindicator -y
apt install gnome-shell-extension-gsconnect -y



#Nautilus Customization
apt install gnome-sushi -y
apt install imagemagick nautilus-image-converter -y
apt install nautilus-admin -y
apt install gir1.2-gtk-4.0 -y
git clone https://github.com/Stunkymonkey/nautilus-open-any-terminal.git
cd nautilus-open-any-terminal || exit
make
sudo make install schema
glib-compile-schemas /usr/share/glib-2.0/schemas
cd "$builddir" || exit
rm -rf nautilus-open-any-terminal


# Removing zip files and stuff
rm -r dotconf
rm -r scripts
rm -rf FiraCode.zip
rm -rf Meslo.zip



sudo apt update && upgrade -y
wait
apt full-upgrade -y
wait
apt install -f
wait
dpkg --configure -a
apt install --fix-broken
wait
apt autoremove -y
sudo apt update && upgrade -y
wait
flatpak update -y


#Customization

sudo -u "$username" gsettings set org.gnome.desktop.interface clock-format 24h && echo "Clock Format: 24h"
sudo -u "$username" gsettings set org.gnome.desktop.interface clock-show-weekday true && echo "Clock Show Weekday: True"
sudo -u "$username" gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true && echo "Numlock State: True"
sudo -u "$username" gsettings set org.gnome.desktop.input-sources xkb-options "['caps:backspace']" && echo "Caps Lock: Backspace"
sudo -u "$username" gsettings set org.gnome.desktop.peripherals.mouse.speed "0.11790393013100431"
sudo -u "$username" gsettings set org.gnome.desktop.peripherals.mouse.accel-profile "'flat'"
wait
sudo -u "$username" gsettings set org.gnome.desktop.interface color-scheme prefer-dark && echo "Color Scheme: Dark"
sudo -u "$username" gsettings set org.gnome.desktop.session idle-delay 0 && echo "Lock Screen Idle: 20"
sudo -u "$username" gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing' && echo "Sleep Inactive AC: Nothing"
sudo -u "$username" gsettings set org.gnome.desktop.interface show-battery-percentage true && echo "Show Battery Percentage: True"
wait
sudo -u "$username" gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false && echo "Ambient Enabled: False"
sudo -u "$username" gsettings set org.gnome.settings-daemon.plugins.power idle-delay "unit32 900" && echo "Idle Delay: 15 minutes"
sudo -u "$username" gsettings set org.gnome.desktop.interface enable-hot-corners false && echo "Enable Hot Corners: False"
sudo -u "$username" gsettings set org.gnome.desktop.background picture-options 'spanned' && echo "Background Options: Spanned"
wait
sudo -u "$username" gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true && echo "Night Light Enabled: True"
sudo -u "$username" gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false && echo "Night Light Schedule Automatic: False"
sudo -u "$username" gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 20 && echo "Night Light Schedule From: 20"
sudo -u "$username" gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 04 && echo "Night Light Schedule To: 04"
sudo -u "$username" gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 2500 && echo "Night Light Temperature: 2500"
wait
sudo -u "$username" gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']" && echo "Custom Keybindings: None"
sudo -u "$username" gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "kitty" && echo "Kitty: Name"
sudo -u "$username" gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "kitty" && echo "Kitty: Command"
sudo -u "$username" gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "<Super>W" && echo "Kitty: Binding"
sudo -u "$username" gsettings set org.gnome.desktop.wm.keybindings close "['<Super>Q']" && echo "Super Q to Close"
sudo -u "$username" gsettings set org.gnome.mutter.wayland.keybindings.restore-shortcuts "['']" 
wait
sudo -u "$username" gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true && echo "Tap to Click: True"
sudo -u "$username" gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true && echo "Natural Scroll: True"
sudo -u "$username" gsettings set org.gnome.desktop.peripherals.touchpad click-method 'areas' && echo "Click Method: Areas"
wait
sudo -u "$username" gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive' && echo "Power Button Action: Interactive"
sudo -u "$username" gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark && echo "GTK Theme: Adwaita-dark"
sudo -u "$username" gsettings set org.gnome.desktop.interface cursor-theme 'Nordzy-cursors' && echo "Cursor Theme: Nordzy"
sudo -u "$username" gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' && echo "Icon Theme: Papirus-Dark"
sudo -u "$username" gsettings set org.gnome.shell favorite-apps "['com.google.Chrome.desktop', 'org.gnome.Nautilus.desktop', 'org.libreoffice.LibreOffice.writer.desktop', 'org.gnome.Calculator.desktop', 'md.obsidian.Obsidian.desktop', 'com.visualstudio.code.desktop', 'code.desktop', 'synochat.desktop', 'org.gimp.GIMP.desktop', 'org.blender.Blender.desktop']" && echo "Favorite Apps: Chrome, Nautilus, LibreOffice, Calculator, Obsidian, VSCode, Discord, Gimp"
wait
wait
sudo -u "$username" gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty
sudo -u "$username" gsettings set com.github.stunkymonkey.nautilus-open-any-terminal new-tab true
sudo -u "$username" gsettings set com.github.stunkymonkey.nautilus-open-any-terminal flatpak system
wait
# Enable Gnome Extensions
sudo -u "$username" gnome-extensions enable ubuntu-appindicators@ubuntu.com && echo "App Indicator: Enabled"
wait
sudo -u "$username" gnome-extensions enable gsconnect@andyholmes.github.io && echo "GSConnect: Enabled"
wait
sudo -u "$username" gnome-extensions enable awesome-tiles@velitasali.com && echo "Awesome Tiles: Enabled"
wait
sudo -u "$username" gnome-extensions enable aztaskbar@aztaskbar.gitlab.com && echo "AzTaskbar: Enabled"
wait
sudo -u "$username" gnome-extensions enable blur-my-shell@aunetx && echo "Blur My Shell: Enabled"
wait
sudo -u "$username" gnome-extensions enable caffeine@patapon.info && echo "Caffeine: Enabled"
wait
sudo -u "$username" gnome-extensions enable openbar@openbar.github.io && echo "OpenBar: Enabled"
wait
# Modify Gnome Extensions
sudo -u "$username" gnome-extensions enable just-perfection-desktop@just-perfection && echo "Just Perfection: Enabled"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/just-perfection/dash-icon-size "48" && echo "Just Perfection Dash Icon Size: 48"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/just-perfection/animation "3" && echo "Just Perfection Animation: 3"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/just-perfection/startup-status "0" && echo "Just Perfection Startup Status: 0"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/just-perfection/app-menu-icon "false" && echo "Just Perfection App Menu Icon: False"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/just-perfection/activities-button "false" && echo "Just Perfection Activities Button: False"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/just-perfection/app-menu "false" && echo "Just Perfection App Menu: False"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/just-perfection/app-menu-label "false" && echo "Just Perfection App Menu Label: False"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/just-perfection/search "false" && echo "Just Perfection Search: False"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/just-perfection/theme "true" && echo "Just Perfection Theme: True"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/caffeine/duration-timer "4" && echo "Caffeine Duration Timer: 4"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/awesome-tiles/gap-size-increments "1" && echo "Awesome Tiles Gap Size Increments: 1"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/aztaskbar/favorites "false" && echo "AzTaskbar Favorites: False"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/aztaskbar/main-panel-height "33" && echo "AzTaskbar Main Panel Height: 33"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/aztaskbar/show-panel-activities-button "false" && echo "AzTaskbar Show Panel Activities Button: False"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/aztaskbar/icon-size "23" && echo "AzTaskbar Icon Size: 23"
wait
sudo -u "$username" dconf write /org/gnome/shell/extensions/blur-my-shell/brightness "1.0" && echo "Blur My Shell Brightness: 1.0"
wait

# OpenBar Aura theme
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/bg-opacity '0.8'
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/prominent1 "['49', '60', '43']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/prominent2 "['196', '216', '182']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/prominent3 "['105', '138', '96']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/prominent4 "['142', '181', '127']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/prominent5 "['113', '108', '101']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/prominent6 "['137', '155', '163']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/palette1 "['105', '138', '96']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/bg-change "true"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/palette10 "['50', '75', '40']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/palette11 "['61', '68', '72']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/palette12 "['164', '140', '123']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/palette2 "['196', '216', '182']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/palette3 "['33', '36', '29']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/palette4 "['142', '181', '127']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/palette5 "['71', '102', '61']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/palette6 "['113', '108', '101']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/palette7 "['137', '155', '163']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/palette8 "['89', '102', '105']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/palette9 "['81', '76', '71']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/default-font "'Sans 12'"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/height "33.0"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/margin "5.0"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/margin-wmax "2.3"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/dark-bgcolor "'0.2392157018184662', '0.21568627655506134', '0.3686274588108063']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/fgcolor "['0.6352940797805786', '0.46666669845581055', '1']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/font "'FiraCode Nerd Font Mono 11'"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/isalpha "0.0"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/bgcolor2 "['0.9647058844566345', '0.5803921818733215', '1']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/candyalpha "0.3"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/shalpha "0.0"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/hcolor "['0.6352940797805786', '0.46666669845581055', '1']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/halpha "0.0"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/heffect "true"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/reloadstyle "true"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/hpad "0.0"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/vpad "0.0"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/bcolor "['0.3803921937942505', '1', '0.7921568751335144']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/autofg-menu "true"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/mfgcolor "['0.9647058844566345', '0.5803921818733215', '1']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/mbgcolor "['0.2392157018184662', '0.21568627655506134', '0.3686274588108063']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/smbgcolor "['0.6352940797805786', '0.46666669845581055', '1']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/mbcolor "['0.3803921937942505', '1', '0.7921568751335144']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/mhcolor "['0.9647058844566345', '0.5803921818733215', '1']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/mscolor "['0.3803921937942505', '1', '0.7921568751335144']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/mshcolor "['0.2392157018184662', '0.21568627655506134', '0.3686274588108063']"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/reloadstyle "false"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/extend-menu-shell "true"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/trigger-reload "false"
sudo -u "$username" dconf write /org/gnome/shell/extensions/openbar/reloadstyle "true"
sudo -u "$username" dconf write /gnome/shell/extensions/openbar/dashdock-style "'Bar'"
sudo -u "$username" dconf write /org/gnome/shell/extensions/aztaskbar/indicator-color-focused "'rgb(246,148,255)'"
sudo -u "$username" dconf write /org/gnome/shell/extensions/aztaskbar/indicator-color-running "'rgb(130,226,255)'"
wait
sudo -u "$username" dconf write /org/gnome/desktop/interface/font-name 'MesloLGSDZ Nerd Font 11'
wait
sudo -u "$username" dconf write /org/gnome/desktop/interface/document-font-name 'FiraCode Nerd Font 11'
wait
sudo -u "$username" dconf write /org/gnome/desktop/interface/monospace-font-name 'Terminus (TTF) Medium 12'
wait
sudo -u "$username" dconf write /org/gnome/desktop/wm/preferences/button-layout 'appmenu:minimize,close'
wait
sudo -u "$username" dconf write /org/gnome/desktop/wm/preferences/button-layout 'appmenu:close'
sleep 2


read -r -p "2.sh complete. Reboot and install Steam. Then run Script 3.sh for Nvidia drivers, skip 3.sh if you are not using Nvidia hardware. Press enter to reboot"
sudo reboot
