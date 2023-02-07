{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Ritsuka314";
    userEmail = "Ritsuka314@outlook.com";
    extraConfig = {
      init = { defaultBranch = "master"; };
    };
    delta = {
      enable = true;
      options = {
        features = "side-by-side line-numbers decorations";
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-style = "bold yellow ul";
          file-decoration-style = "none";
        };
      };
    };
  };
}