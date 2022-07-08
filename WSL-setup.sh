### in windows CMD

# make sure running WSL2
wsl --set-default-version 2

# install Alpine from
# https://github.com/yuk7/AlpineWSL/releases/
# cf. https://github.com/agowa338/WSL-DistroLauncher-Alpine
# hopefully one day there is an official build

# set default distro to Alpine
wsl --set-default Alpine

### WSL terminal
# now logged in as root

# create non-root user profile
adduser -u 1000 -G users -G wheel -h /home/richard richard
# set password

# change repo site if necessary
# 阿里:
sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
# TUNA:
sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
# 科大:
sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

# update, upgrade, install necessary tools
apk update
apk upgrade
# ncurses for the tput command that hm installer needs
apk add curl xz sudo ncurses 

# open /etc/sudoers
visudo
# uncomment the line:
# %wheel ALL=(ALL) ALL

### windows CMD
Alpine.exe config --default-user richard

### WSL

## install nix in single-user mode
# https://nixos.wiki/wiki/Nix_Installation_Guide#Single-user_install
sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon

echo ". $HOME/.nix-profile/etc/profile.d/nix.sh" >> $HOME/.profile
# adding to .profile seems OK. check if should add to .bashrc instead

# enter a new shell

# check if nix is installed
nix --version

## install flakes
# https://nixos.wiki/wiki/Flakes#Non-NixOS
nix-env -iA nixpkgs.nixFlakes

# create path recursively and give no executable permission
install -m 644 -D /dev/null ~/.config/nix/nix.conf
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

## install Home Manager in standalone mode
# https://nix-community.github.io/home-manager/index.html#sec-install-standalone

# Add the Home Manager channel that you wish to follow.
nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
nix-channel --update

echo "export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH" >> $HOME/.profile

# Run the Home Manager installation command and create the first Home Manager generation
nix-shell '<home-manager>' -A install

echo "exec zsh" >> $HOME/.profile