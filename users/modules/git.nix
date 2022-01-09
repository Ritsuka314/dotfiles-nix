{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "richardyan314";
    userEmail = "richardyan314@foxmail.com";
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