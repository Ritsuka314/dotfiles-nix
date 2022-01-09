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
apk add curl xz sudo

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
curl -L https://nixos.org/nix/install | sh

echo ". $HOME/.nix-profile/etc/profile.d/nix.sh" >> $HOME/.profile
# adding to .profile seems OK. check if should add to .bashrc instead

# enter a new shell

# check if nix is installed
nix --version

# follow unstable channel for flakes
nix-env -iA nixpkgs.nixUnstable

## install Home Manager in standalone mode
# https://nix-community.github.io/home-manager/index.html#sec-install-standalone

# Add the Home Manager channel that you wish to follow. If you are following Nixpkgs master or an unstable channel then this is done by running
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

echo "export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH" >> $HOME/.profile

# Run the Home Manager installation command and create the first Home Manager generation
nix-shell '<home-manager>' -A install

echo "exec zsh" >> $HOME/.profile

## install flakes
# https://nixos.wiki/wiki/Flakes#Non-NixOS

# create path recursively and give no executable permission
install -m 644 -D /dev/null ~/.config/nix/nix.conf

echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

curl -L https://github.com/numtide/nix-flakes-installer/releases/download/nix-3.0pre20200804_ed52cf6/install | sh
