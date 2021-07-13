#!/bin/sh

echo "Requires Internet"

sudo pacman -S --needed xdg-user-dirs git
xdg-user-dirs-update

echo "Refreshing Database"
sudo pacman -Sy

echo "Installing aur helper Paru"
echo "It is a pre built binary so couple of minutes no worries :)"
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin || exit
makepkg -si

echo "Installing dependencies"
sudo pacman -S --needed zsh neovim yarn nodejs npm python3 xclip xf86-video-intel intel-ucode ripgrep fd slop scrot pulseaudio libx11 kitty xwallpaper noto-fonts-emoji
sleep 5

paru -S nerd-fonts-jetbrains-mono libxft-bgra-git
echo "Font cache"
sudo fc-cache -f -v

echo "Setting up directories"

mkdir -p $HOME/.local/bin
scripts=~/.local/bin/

mkdir -p $HOME/.local/share/dwm
autostart=~/.local/share/dwm

echo "downloading autostart script"

cd $autostart || exit
wget https://raw.githubusercontent.com/ashincoder/dotfiles-void/master/.local/share/dwm/autostart.sh
chmod +x autostart.sh
cd || exit

echo "Cloning Builds and Scripts"
cd $scripts || exit
git clone https://github.com/ashincoder/scripts.git .
rm -rf .git

config=~/.config/suckless
mkdir -p $config
cd $config || exit

echo "Compiling Dwm"
git clone https://github.com/ashincoder/dwm-ashin.git
sleep 5
cd dwm-ashin || exit
sudo make clean install
cd ..

echo "Compiling St"
git clone https://github.com/ashincoder/st-ashin.git
sleep 5
cd st-ashin || exit
sudo make clean install
cd ..

echo "Compiling Dmenu"
git clone https://github.com/ashincoder/dmenu-ashin.git
sleep 5
cd dmenu-ashin || exit
sudo make clean install
cd .. || exit

echo "Compiling Slstatus"
git clone https://github.com/ashincoder/slstatus-ashin.git
sleep 5
cd slstatus-ashin || exit
sudo make clean install
cd .. || exit

echo "Compiling Sxiv"
git clone https://github.com/ashincoder/sxiv-ashin.git
sleep 5
cd sxiv-ashin || exit
sudo make clean install
cd || exit

echo "Compiling Slock"
git clone https://github.com/ashincoder/slock-ashin.git
sleep 5
cd slock-ashin || exit
sudo make clean install
cd ..

echo "Downloading Wallpapers"

sudo mkdir /usr/share/backgrounds
cd /usr/share/backgrounds/ || exit
sudo wget https://raw.githubusercontent.com/ashincoder/wallpapers/main/neon.png
sudo wget https://raw.githubusercontent.com/ashincoder/wallpapers/main/0023.jpg
sudo mv 0023.jpg nature.jpg
sleep 5

echo "Setting zsh shell"

cd || exit
zdot=~/.config/zsh/
wget https://raw.githubusercontent.com/ashincoder/dotfiles-void/master/.zshenv
mkdir -p $zdot
cd $zdot || exit
chsh $USER
