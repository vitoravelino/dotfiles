#!/usr/bin/env bash

# variables
MISSING_DEPENDENCIES=()
LEAP_VERSION='15.2'
OS_VERSION=$(sed -n '/^ID="/s/^.*=//p' /usr/lib/os-release | cut -d'"' -f2)
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# support functions
get_latest_tag() {
  curl --silent "https://api.github.com/repos/$1/tags" | grep -Po '"name": "\K.*?(?=")' | head -1
}

check_dependency() {
  package=$2

  if [ -z $package ]; then
    package=$1
  fi

  if ! [ -x "$(command -v $1)" ]; then
    MISSING_DEPENDENCIES+=($package)
  fi
}

check_dependencies() {
  check_dependency 'git'

  if ! [ ${#MISSING_DEPENDENCIES[@]} -eq 0 ]; then
    echo 'Installing missing dependencies...'
    sudo zypper -n in ${MISSING_DEPENDENCIES[@]}
  fi
}

check_os() {
  if [ "$OS_VERSION" = "opensuse-leap" ]; then
    REPO_OS_ID="openSUSE_Leap_$LEAP_VERSION"
    NVIDIA_REPO_OS_ID="leap/$LEAP_VERSION"
  elif [ $OS_VERSION = "opensuse-tumbleweed" ]; then
    REPO_OS_ID='openSUSE_Tumbleweed'
    NVIDIA_REPO_OS_ID='tumbleweed'
  else
    echo 'Error: OS not supported! You are not running openSUSE Leap or Tumbleweed.'
    exit 1
  fi
}

# main
check_dependencies
check_os

# cloning repo
git clone https://github.com/vitoravelino/dotfiles.git
cd dotfiles
git checkout bspwm

# repositories
#
sudo zypper ar -c https://download.opensuse.org/repositories/multimedia:/apps/$REPO_OS_ID/multimedia:apps.repo
# polybar
sudo zypper ar -c https://download.opensuse.org/repositories/X11:Utilities/$REPO_OS_ID/X11:Utilities.repo
# codecs
sudo zypper ar -c http://ftp.gwdg.de/pub/linux/misc/packman/suse/$REPO_OS_ID/ packman
# nvidia
sudo zypper ar -c https://download.nvidia.com/opensuse/$NVIDIA_REPO_OS_ID NVIDIA
# lightdm webkit greeter
sudo zypper ar -c https://download.opensuse.org/repositories/home:antergos/$REPO_OS_ID/home:antergos.repo
# vscode
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/zypp/repos.d/vscode.repo'
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper --gpg-auto-import-keys ref
sudo zypper -n dup --allow-vendor-change --from packman

# devel
sudo zypper -n in --type pattern devel_basis
sudo zypper -n in libopenssl-devel readline-devel libssh2-devel

# i3lock-color deps
sudo zypper -n in libev-devel xcb libxcb-devel xcb-util-image-devel xcb-util-devel xcb-util-xrm-devel xcb-util-wm-devel libxkbcommon-devel libxkbcommon-x11-devel cairo-devel openjpeg-devel libjpeg8-devel pam-devel xdpyinfo bc ImageMagick

# qogir theme deps
sudo zypper -n in gtk2-engines gtk2-engine-murrine

# bspwm and cia
sudo zypper -n in bspwm wmctrl scrot sxhkd rofi feh xdotool jq lightdm-webkit2-greeter picom dunst

# apps
APPS='vlc vlc-codecs keepassxc dropbox hexchat libreoffice screenfetch sensors pulseaudio-equalizer htop inkscape optipng xdotool sshfs obs-studio vlc vlc-codecs docker-compose alacritty code discord flatpak wine lutris zsh bat nautilus pavucontrol redshift guvcview fortune gimp flash-player flash-player-ppapi'

if [ $OS_VERSION = "opensuse-tumbleweed" ]; then
  APPS+=' spotify-easyrpm'
fi

sudo zypper -n in $APPS

# fonts
sudo zypper -n in google-tinos-fonts google-arimo-fonts google-cousine-fonts fetchmsttfonts noto-coloremoji-fonts

# flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak update
sudo flatpak install -y flathub com.bitwarden
sudo flatpak install -y flathub com.slack.Slack
sudo flatpak install -y flathub io.dbeaver.DBeaverCommunity
sudo flatpak install -y flathub org.onlyoffice
sudo flatpak install -y flathub com.jetbrains.IntelliJ-IDEA-Community
sudo flatpak install -y flathub com.teamspeak.TeamSpeak

# lightdm
sudo update-alternatives --set default-displaymanager /usr/lib/X11/displaymanagers/lightdm
sudo cp -R $PWD/webkit-greeter/build /usr/share/lightdm-webkit/themes/custom
sudo sed -i 's/webkit_theme        = antergos/webkit_theme        = custom/g' /etc/lightdm/lightdm-webkit2-greeter.conf
sudo cp 01-my-lightdm.conf /usr/share/lightdm/lightdm.conf.d/

# todo: copy mouse natural scrolling conf
# todo: how to set bspwm as window manager?

# i3lock-color
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
chmod +x build.sh
chmod +x install-i3lock-color.sh
./build.sh
./install-i3lock-color.sh
cd $HOME/dotfiles
rm -rf i3lock-color

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --key-bindings --completion --no-update-rc

# asdf
ln -s $PWD/tool-versions $HOME/.tool-versions
ASDF_BRANCH=$(get_latest_tag 'asdf-vm/asdf')
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch $ASDF_BRANCH
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
GO111MODULE=on go get github.com/rhysd/dotfiles
asdf reshim

# Qogir gtk theme
git clone https://github.com/vitoravelino/Qogir-theme.git
./Qogir-theme/install.sh -t standard -w square -c standard
rm -rf Qogir-theme

# zsh
chsh -s /usr/bin/zsh

# docker group
sudo usermod -aG docker $USER

# cursor size fix
sudo bash -c 'echo "Xcursor.size: 16" >> /etc/X11/Xresources'

# symlink all dotfiles
dotfiles link

# lockscreen
multilockscreen -u ~/pictures/wallpaper.png --fx blur

# antigen
curl -L git.io/antigen > $HOME/.antigen/antigen.zsh

# misc
mkdir ~/pictures/screenshots

echo -e "\n${GREEN}Installation complete.${NC}\n"

## NOTE: libjsoncpp22 was available at some point while testing this but disappeared from repo
echo -e "* Install polybar manually and link libjsoncpp with '${YELLOW}sudo ln -s /usr/lib64/libjsoncpp.so.24 /usr/lib64/libjsoncpp.so.22${NC}'"
echo -e "* StreamerFX OBS plugin is built for ubuntu and needs some links:"
echo -e "  sudo ln -s /usr/lib64/libavutil.so.56.51 /usr/lib64/libavutil.so.56\n  sudo ln -s /usr/lib64/libavcodec.so.58.91 /usr/lib64/libavcodec.so.58\n  sudo ln -s /usr/lib64/libswscale.so.5.7 /usr/lib64/libswscale.so.5"
echo -e "* Setup dropbox by running '${YELLOW}dropbox start -i${NC}'"
echo -e "* Setup your SSH and PGP keys"
echo -e "* Check if ${YELLOW}/etc/pam.d/i3lock${NC} is using ${YELLOW}login${NC} and not ${YELLOW}system-auth${NC}"
echo -e "* Set eq preset on pulseaudio equalizer"
echo -e "* Set your OpenWeatherMap API key to the polybar script"
echo -e "* Set Firefox config ${YELLOW}ui.context_menus.after_mouseup${NC} to ${YELLOW}true${NC}"

if [ $OS_VERSION = "opensuse-leap" ]; then
  # spotify
  echo -e "* Go to ${YELLOW}https://github.com/megamaced/spotify-easyrpm ${NC}and install it via 1-click yast install"
fi

# nvidia
echo -e "* Run ${YELLOW}sudo zypper -n in x11-video-nvidiaG05 ${NC}to install NVIDIA drivers"
