# Run this script without root.

sudo pacman -S git --needed
cd ~
git clone https://aur.archlinux.org/yay.git .yay
cd .yay
makepkg -si
