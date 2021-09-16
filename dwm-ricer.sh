#!/bin/sh

echo "Requires Internet"
cd "$HOME" || exit

if command -v aura; then
	echo "Aura is installed"
else
	echo "Aura could not be found"
	echo "Installing aura"
	cd || exit
	git clone https://aur.archlinux.org/aura-bin.git
	cd aura-bin || exit
	makepkg -si
	rm -rf aura-bin
fi

echo "Installing package manager"

echo "Refreshing Database"
sudo aura -Sy

echo "Installing dependencies"
sudo aura -Sy --needed zsh stow neovim yarn nodejs npm python3 xclip ripgrep fd slop scrot pulseaudio libx11 xwallpaper noto-fonts-emoji
sleep 5

aura -Ay nerd-fonts-jetbrains-mono libxft-bgra-git shellcheck-bin pandoc-bin otf-font-awesome-5-free
echo "Font cache"
sudo fc-cache -f -v

echo "Setting up directories"

mkdir -p "$HOME"/.local/bin
scripts=~/.local/bin/

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

echo "Cloning dotfiles and Wallpapers"

cd "$HOME" || exit
git clone https://github.com/ashincoder/dots.git
cd dots || exit
echo "Symlinking configs"
stow /*
chsh "$USER"
