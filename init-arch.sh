# Must run with sudo

echo Setting pacman mirror to tuna...
sed -i 's@#Server = https:\/\/mirrors.tuna@Server = https://mirrors.tuna@g' /etc/pacman.d/mirrorlist

echo Update pacman keys...
pacman-key --init
pacman-key --populate archlinux

echo Update pacman packages...
pacman -Syyu

echo Install necessary packages...
pacman -S git gcc neofetch

echo Install zsh...
pacman -S zsh

echo Add user viccrubs...
useradd -s /bin/zsh -m viccrubs

passwd viccrubs
