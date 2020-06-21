# Install tinyproxy
sudo pacman -S tinyproxy

# Set the config
CONFIG_PATH="/etc/tinyproxy/tinyproxy.conf"

# Change the listening port to 1080
sudo sed -i 's/Port 8888/Port 1080/' $CONFIG_PATH

# Change the Listen to 127.0.0.1(localhost)
sudo sed -i 's/#Listen 192.168.0.1/Listen 127.0.0.1/' $CONFIG_PATH

# Set the upstream to Windows proxy
# Windows's hostname is good
sudo sed -i 's/#Upstream http some.remote.proxy:port/Upstream host.docker.internal/' $CONFIG_PATH

# Run the tinyproxy
tinyproxy

# Since WSL 2 does not support systemd, just add tinyproxy to .bashrc/.zshrc to make it autostart
echo tinyproxy >> .zshrc