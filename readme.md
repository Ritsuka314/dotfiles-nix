#

https://github.com/Yumasi/nixos-home

https://github.com/notusknot/dotfiles-nix

https://github.com/sherubthakur/dotfiles

https://github.com/mjlbach/nix-dotfiles

# build nixos

TODO

# set up wsl

see `WSL-setup.sh`

# build wsl home

```sh
home-manager switch -f home-penglai-wsl.nix
```

```sh
home-manager switch --flake "./#wsl"
```

# font

install some [nerd fonts]
(https://www.nerdfonts.com/)
for `powerline` and `exa` symbols.

Configure Ubuntu Terminal, VS Code (e.g., `"terminal.integrated.fontFamily": "DejaVuSansMono Nerd Font"`), xshell, etc.