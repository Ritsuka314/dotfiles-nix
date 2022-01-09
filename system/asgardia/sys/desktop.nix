{ config, pkgs, ... } :

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  
  # Enabling Pantheon
  # turn off pantheon greeter since it always tries to find some `default` session. use gtk greeter instead
  # services.xserver.displayManager.lightdm.greeters = {
  #   pantheon.enable = false;
  #   gtk.enable = true;
  # };
  # services.xserver.desktopManager.pantheon.enable = true;
  # environment.pantheon.excludePackages = with pkgs; [
  #   pantheon.elementary-code
  #   pantheon.elementary-terminal # use gnome.gnome-terminal instead; see environment.systemPackages
  #   gnome.geary
  #   gnome.epiphany
  # ];

  #services.xserver.windowManager.berry.enable = true;
  
  #services.xserver.windowManager.awesome.enable = true;

  services.xserver.desktopManager.session = [
    {
      name = "home-manager";
      start = ''
        ${pkgs.runtimeShell} $HOME/.hm-xsession &
        waitPID=$!
      '';
    }
  ];
  
  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

}
