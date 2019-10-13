# Must run with sudo

# Use tuna source
echo Setting pacman mirror to tuna...
sed -i 's@#Server = https:\/\/mirrors.tuna@Server = https://mirrors.tuna@g' /etc/pacman.d/mirrorlist

# Populate with keys
echo Update pacman keys...
pacman-key --init
pacman-key --populate archlinux

# Update
echo Update pacman packages...
pacman -Syyu

# Install necessary packages
echo Install necessary packages...
pacman -S git gcc neofetch

# Install zsh and oh-my-zsh
echo Install zsh...
pacman -S zsh

# add normal user
echo Add user viccrubs...
useradd -s /bin/zsh -m viccrubs

# set password
echo set password of user viccrubs...
passwd viccrubs

# Install oh-my-zsh as viccrubs
su -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" viccrubs