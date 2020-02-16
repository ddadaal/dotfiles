# Must run with sudo
if [[ $EUID -ne 0 ]]; then
	echo This script must be run as root.
	exit 1
fi

name=ddadaal
email=ddadaal@outlook.com

echo Setting pacman mirror...
if which pacman-mirrors 1>/dev/null 2>&1; then
    echo pacman-mirrors exists. using it to generate mirrors
	pacman-mirrors -i -c China -m rank
else
	echo pacman-mirrors does not exist. it is likely to be WSL, modifying the mirrorlist directly...
	sed -i 's@#Server = https:\/\/mirrors.tuna@Server = https://mirrors.tuna@g' /etc/pacman.d/mirrorlist
fi	

echo Setting up archlinuxcn...
if grep -Fxq "[archlinuxcn]" /etc/pacman.conf; then
	echo "archlinuxcn already set up"
else
	echo "[archlinuxcn]" >> /etc/pacman.conf
	echo "" >> /etc/pacman.conf
	echo "Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch" >> /etc/pacman.conf
fi

echo Setting color output for pacman...
sed -i 's:#Color:Color:g' /etc/pacman.conf

echo Update pacman sources...
pacman -Syy

echo Install keys...
pacman-key --init
pacman-key --populate archlinux
pacman -S archlinuxcn-keyring --needed

echo Install packages...
pacman -Syuu

echo Set git...
git config --global user.name "$name"
git config --global user.email "$email"
git config --global core.autocrlf false
git config --global credential.helper store

echo Add user? Type n to cancel, or type username or use default username: "$name"
read input

if [ "$input" != "n" ]; then
	input=${input:-$name}
	echo Press to any key to edit sudoers file.
	echo Uncomment the line starting with %wheel...
	read
	visudo 
	echo Add user $input to group wheel...
	useradd -m $input -G wheel
	echo "Set password for $input"
	passwd $input
fi


echo Arch initialization complete.
