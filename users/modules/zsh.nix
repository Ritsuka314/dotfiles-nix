{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true; # load and enable the zsh-autosuggestions package
    enableCompletion = true; # load and enable the nix-zsh-completions package
    # home manager uses the obsolete oh-my-zsh
    # ohMyZsh = {
    oh-my-zsh = {
      enable = true;
    # home manager has POOR support of managing plugins with oh-my-zsh... 
    # i.e., with home manager `zsh.oh-my-zsh.plugins` takes only a string list,
    # so don't use oh-my-zsh to manage plugins and use `zsh.plugins` instead
    # nonethess, load oh-my-zsh for its key-bindings,
    # which is more portable across terminals
    };
    shellAliases = {
      ls = "exa -a --icons";
      tree = "exa -a --tree --icons";
      cat = "bat";
    };
    # home manager uses `initExtra`
    #shellInit = ''
    initExtra = ''
      # https://nixos.wiki/wiki/Zsh#Zsh-autocomplete_not_working
      # not using oh-my-zsh anymore
      # bindkey "''${key[Up]}" up-line-or-search

      # https://unix.stackexchange.com/a/110846
      bindkey '\e[1~'   beginning-of-line  # Linux console
      bindkey '\e[H'    beginning-of-line  # xterm
      bindkey '\eOH'    beginning-of-line  # gnome-terminal
      bindkey '\e[2~'   overwrite-mode     # Linux console, xterm, gnome-terminal
      bindkey '\e[3~'   delete-char        # Linux console, xterm, gnome-terminal
      bindkey '\e[4~'   end-of-line        # Linux console
      bindkey '\e[F'    end-of-line        # xterm
      bindkey '\eOF'    end-of-line        # gnome-terminal
      
      # bind ctrl + space to accept autosuggestions
      bindkey '^ ' autosuggest-accept

      # Diverged, Behind, Ahead, New file(s), Deleted, Modified, Renamed, Untracked, Stashed
      # Pure Prompt style
      # AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' 'S')
      # Spaceship Prompt style
      AGKOZAK_CUSTOM_SYMBOLS=( '⇕' '⇣' '⇡' '+' '✘' '!' '»' '?' '$')

      AGKOZAK_PROMPT_CHAR=( 'λ ' 'λ ' 'λ ' )



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
