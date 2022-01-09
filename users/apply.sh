#!/usr/bin/env bash
#sudo nix-collect-garbage -d
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir -p $HOME/.config
cp -rf ./* $HOME/.config/
nix-shell -p nixUnstable --command "nix build --experimental-features 'nix-command flakes' '$HOME/.config/#richard'"
