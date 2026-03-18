{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.desktop.niri;
in
{
  options.mine.desktop.niri.enable = lib.mkEnableOption "Enable Niri window manager";

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;

    xdg.portal = {
      enable = true;
      config.niri = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Access" = "gtk";
        "org.freedesktop.impl.portal.Notification" = "gtk";
        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };

    environment.systemPackages = with pkgs; [
      # fuzzel
      swaylock
    ];
  };
}
