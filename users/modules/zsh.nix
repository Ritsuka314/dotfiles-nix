{ pkgs, ... }:

let 
  zsh-config = pkgs.stdenv.mkDerivation {
    name = "zsh-config";
    src  = ./zsh;
    installPhase = ''
      mkdir -p $out
      cp -r $src/* $out
      '';
    preferLocalBuild = true;
  };
in
{
  home.packages = [
    zsh-config
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true; # load and enable the zsh-autosuggestions package
    enableCompletion = true; # load and enable the nix-zsh-completions package
    shellAliases = {
      ll   = "exa -al --icons";
      ls   = "exa -a --icons";
      tree = "exa -a --tree --icons";
      cat = "bat";
    };
    initExtra = ''
      source ${zsh-config}/key-bindings.zsh
      source ${zsh-config}/zshrc.zsh
    '';
    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma";
          repo = "fast-syntax-highlighting";
          rev = "817916dfa907d179f0d46d8de355e883cf67bd97";
          sha256 = "0m102makrfz1ibxq8rx77nngjyhdqrm8hsrr9342zzhq1nf4wxxc";
        };
      }
      {
        # notusknot's version uses exa, make sure it is installed
        name = "auto-ls";
        src = pkgs.fetchFromGitHub {
          owner = "notusknot";
          repo = "auto-ls";
          rev = "62a176120b9deb81a8efec992d8d6ed99c2bd1a1";
          sha256 = "08wgs3sj7hy30x03m8j6lxns8r2kpjahb9wr0s0zyzrmr4xwccj0";
        };
      }
    ];
  };

  # spaceship-prompt lags in WSL,
  # setting SPACESHIP_XXXX_SHOW=false did not help
  # use starship instead
  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[λ ](bold green)";
        error_symbol = "[λ ](bold red)";
      };
    };
  };
}
