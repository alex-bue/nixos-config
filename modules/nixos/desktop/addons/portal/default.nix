{ lib, config, pkgs, ... }:
let
  cfg = config.mine.nixos.desktop.addons.portal;
in
{
  options.mine.nixos.desktop.addons.portal.enable = lib.mkEnableOption "Enable XDG portals for Wayland desktop apps";

  config = lib.mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
      xdg-utils
    ];
  };
}
