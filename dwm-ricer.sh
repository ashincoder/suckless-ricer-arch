#!/bin/sh

echo "Requires Internet"

sudo pacman -S --needed git

echo "Adding My custom Repo"

echo "[ashin-repo]" | tee -a /etc/pacman.conf
echo "SigLevel = Optional DatabaseOptional" | tee -a /etc/pacman.conf
echo "Server = https://ashincoder.github.io/ashin-repo/x86_64" | tee -a /etc/pacman.conf

echo "Refreshing Database"
sudo pacman -Sy

echo "Installing aur helper Paru"
echo "It is a pre built binary so couple of minutes no worries :)"
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin || exit
makepkg -si

echo "Installing Dwm of Ashin"
sudo pacman -S dwm-ashin-git slstatus-ashin-git st-ashin-git dmenu-ashin-git sxiv-ashin-git tabbed-ashin-git slock-ashin-git
echo "Installing dependencies"
sudo pacman -S --needed lightdm lightdm-gtk-greeter libx11 alacritty xwallpaper sysstat lm_sensors noto-fonts-emoji && paru -S otf-font-awesome-5-free nerd-fonts-jetbrains-mono

echo "Create a .dwm directory in your home and make a scritp of the things you would like to startup"
