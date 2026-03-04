{ lib, config, pkgs, ... }:
let
  cfg = config.mine.nixos.desktop.addons.session;
in
{
  options.mine.nixos.desktop.addons.session.enable = lib.mkEnableOption "Enable desktop session addons";

  config = lib.mkIf cfg.enable {
    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      networkmanagerapplet
    ];
  };
}
