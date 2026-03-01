{ pkgs, ... }:
{
  # Niri Wayland session
  programs.niri.enable = true;

  # Lightweight login manager for launching niri-session
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
        user = "greeter";
      };
    };
  };

  # Desktop integration basics
  security.polkit.enable = true;
  services.dbus.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.dconf.enable = true;

  # Audio stack
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Wayland desktop portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Minimal user-facing tools for the desktop session
  environment.systemPackages = with pkgs; [
    wezterm
    fuzzel
    mako
    waybar
    wl-clipboard
    xdg-utils
    pavucontrol
    networkmanagerapplet
  ];
}
