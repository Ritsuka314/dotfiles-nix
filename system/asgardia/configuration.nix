# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      # Include the results of the hardware scan.
      ./sys/hardware-configuration.nix
      ./sys/boot.nix
      ./sys/desktop.nix
      ./sys/locale.nix
      ./sys/network.nix
    ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Select internationalisation properties.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.richard = {
    isNormalUser = true;
    hashedPassword = "$5$5Frpb1kPt8oMgGBD$hNGdfiKuUJClOYDpHOkBkrIDbu7m0Jf4QV8KkNxckL5"; # run `mkpasswd -m sha-512` and enter on prompt
    extraGroups = [ 
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAoVD2Cosa1pv/6WWmSUpWtQ29drtG3EaZgKOhzFcu7Ntg+Y9CKrEEOh3vLoWMUJCPbMF9SOg14rUrRcAQ1T1HHOgi0HDzFZ7NU23VZtbNfzJcKPY8PB8Ff7w8nwpjzEAMRK6H5QYLVAe3L7i5BbhV2Hy5xWPQyIfQtBX4MdsUsdNWrDEDjMlynCPx3befVrVhZrSCl5kiiiDQ0GGBis48AS+LX/in35tPxTzM8P14VXtkZZCJo1ZhVo2bEOFoWoOiMEhIpTUBtOGDBwSAhiOACVefRLhOZhx5LM/nSaIc/j8VIhSHzuRAPgSxhThuclttgMztkbrs0sj7UM7Ft5ncqw=="
    ];
  };

  environment.systemPackages = [] ++
    (with pkgs; [
      coreutils
      home-manager
      gnome.gnome-terminal
      kitty
      arc-theme
      polybar
      redshift
      chromium
    ]);

  services.redshift = {
    enable = true;
    temperature.night = 1900;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.dconf.enable = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}
