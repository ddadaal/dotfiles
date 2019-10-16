# Must run with sudo
if [[ $EUID -ne 0 ]]; then
	echo This script must be run as root
	exit 1
fi

echo Setting pacman mirror...
if which pacman-mirrors > /dev/null; then
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
	echo "[archlinuxcn]" >> /etc/pacmac.conf
	echo "https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch" >> /etc/pacman.conf
fi

echo Update pacman sources...
pacman -Syy

echo Install keys...
pacman-key --init
pacman-key --populate archlinux
pacman -S archlinuxcn-keyring --needed

echo Install packages...
pacman -Syuu

echo Add user? Type n to cancel, or type username or use default username: daacheen
read input

if [ "$input" != "n" ]; then
	if [ -z "$input" ]; then
		input=daacheen
	fi
	echo Add user $input...
	useradd -m $input
	passwd $input
fi

echo Arch initialization complete.
