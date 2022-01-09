{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wget
    curl
    exa
    fd
    tree

    # alphine comes with busybox
    less

    # for polybar
    inotify-tools
  ];
}
