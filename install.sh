#!/bin/sh

# variables
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

ASDF_BRANCH=v0.7.8
BAT_FILE=bat-0.15.0-1.1.x86_64.rpm

# dotfiles to its proper places
mkdir -p $HOME/.antigen
mkdir -p $HOME/.ssh
mkdir -p $HOME/.config/fontconfig

cp {.aliases,.exports,.gemrc,.curlrc,.zshrc,.vimrc,.gitconfig,.tool-versions} $HOME
cp .ssh/config $HOME/.ssh
cp .antigen/config $HOME/.antigen

# repositories
sudo zypper ar -c https://download.opensuse.org/repositories/Virtualization:containers/openSUSE_Leap_15.1/Virtualization:containers.repo
sudo zypper ar -c https://download.opensuse.org/repositories/mozilla/openSUSE_Leap_15.1/mozilla.repo
sudo zypper ar -c http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_15.1/ packman
sudo zypper ar -c https://download.nvidia.com/opensuse/leap/15.1 NVIDIA
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/zypp/repos.d/vscode.repo'
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper --gpg-auto-import-keys ref
sudo zypper -n dup --allow-vendor-change --from packman
sudo zypper -n dup --allow-vendor-change --from mozilla

# devel
sudo zypper -n in --type pattern devel_basis
sudo zypper -n in libopenssl-devel readline-devel libssh2-devel

# apps
sudo zypper -n in vlc vlc-codecs keepassxc dropbox hexchat libreoffice screenfetch sensors pulseaudio-equalizer htop inkscape optipng xdotool sshfs obs-studio vlc vlc-codecs docker-compose tilix code discord flatpak wine lutris

# fonts
sudo zypper -n in google-tinos-fonts google-arimo-fonts google-cousine-fonts

# flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak update
sudo flatpak install -y flathub com.slack.Slack
sudo flatpak install -y flathub io.dbeaver.DBeaverCommunity
sudo flatpak install -y flathub com.wps.Office
sudo flatpak install -y flathub com.jetbrains.IntelliJ-IDEA-Community
# sudo flatpak install -y flathub com.teamspeak.TeamSpeak
# sudo flatpak install -y flathub com.dropbox.Client

# Tilix
dconf load /com/gexperts/Tilix/ < tilix.dconf

# bat
wget https://download.opensuse.org/repositories/openSUSE:/Factory/standard/x86_64/$BAT_FILE
sudo zypper -n in $BAT_FILE
rm -rf $BAT_FILE

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --key-bindings --completion --no-update-rc

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch $ASDF_BRANCH
. $HOME/.asdf/asdf.sh

asdf plugin-add golang
asdf plugin-add ruby
asdf plugin-add erlang
asdf plugin-add elixir
asdf plugin-add nodejs

bash $HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install

asdf reshim
npm -g install yarn diff-so-fancy
asdf reshim

# perfect eq preset
mkdir -p $HOME/.config/pulse/presets
wget -P $HOME/.config/pulse/presets https://raw.githubusercontent.com/rsommerard/pulse-presets/master/Perfect%20EQ.preset

# qogir theme and icons
sudo zypper -n in gtk2-engines gtk2-engine-murrine
git clone https://github.com/vinceliuice/Qogir-theme.git
./Qogir-theme/install.sh -t standard -l gnome -w square -c standard
rm -rf Qogir-theme
gsettings set org.gnome.desktop.interface gtk-theme "Qogir-win"

git clone https://github.com/vinceliuice/Qogir-icon-theme.git
./Qogir-icon-theme/install.sh
rm -rf Qogir-icon-theme
gsettings set org.gnome.desktop.interface icon-theme 'Qogir'

# antigen
curl -L git.io/antigen > $HOME/.antigen/antigen.zsh

# gsettings
gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:minimize,maximize,close
gsettings set org.gnome.desktop.interface clock-show-date true

# gnome extesnsions
curl -L https://raw.githubusercontent.com/martin-sucha/gnome-shell-extension-cli/master/gnome-shell-extension-cli > $HOME/bin/gnome-shell-extension-cli
chmod +x $HOME/bin/gnome-shell-extension-cli

gnome-shell-extension-cli install https://extensions.gnome.org/extension/307/dash-to-dock/
gnome-shell-extension-cli install https://extensions.gnome.org/extension/118/no-topleft-hot-corner/
gnome-shell-extension-cli install https://extensions.gnome.org/extension/750/openweather/
gnome-shell-extension-cli install https://extensions.gnome.org/extension/800/remove-dropdown-arrows/
gnome-shell-extension-cli install https://extensions.gnome.org/extension/1112/screenshot-tool/
gnome-shell-extension-cli install https://extensions.gnome.org/extension/355/status-area-horizontal-spacing/
gnome-shell-extension-cli install https://extensions.gnome.org/extension/1031/topicons/

gsettings --schemadir $HOME/.local/share/gnome-shell/extensions/openweather-extension@jenslody.de/schemas set org.gnome.shell.extensions.openweather unit 'celsius'
gsettings --schemadir $HOME/.local/share/gnome-shell/extensions/openweather-extension@jenslody.de/schemas set org.gnome.shell.extensions.openweather position-in-panel 'right'
gsettings --schemadir $HOME/.local/share/gnome-shell/extensions/openweather-extension@jenslody.de/schemas set org.gnome.shell.extensions.openweather city '-7.1215981,-34.882028>João Pessoa, PB, Brasil >-1'
gsettings --schemadir $HOME/.local/share/gnome-shell/extensions/openweather-extension@jenslody.de/schemas set org.gnome.shell.extensions.openweather wind-speed-unit 'kph'

gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 44
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock apply-custom-theme true

gsettings --schemadir ~/.local/share/gnome-shell/extensions/gnome-shell-screenshot@ttll.de/schemas/ set org.gnome.shell.extensions.screenshot shortcut-select-window ['<Primary>Print']
gsettings --schemadir ~/.local/share/gnome-shell/extensions/gnome-shell-screenshot@ttll.de/schemas/ set org.gnome.shell.extensions.screenshot shortcut-select-area ['<Primary><Shift>Print']

echo -e "\n${GREEN}Installation complete.${NC}\n"

# spotify
echo -e "* Go to ${YELLOW}https://github.com/megamaced/spotify-easyrpm ${NC}and install it via 1-click yast install"

# nvidia
echo -e "* Run ${YELLOW}sudo zypper -n in x11-video-nvidiaG05 ${NC}to install NVIDIA drivers"
