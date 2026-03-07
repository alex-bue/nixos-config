{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.nixos.desktop.niri;
in
{
  options.mine.nixos.desktop.niri.enable = lib.mkEnableOption "Enable Niri window manager";

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
      noctalia-shell
      wezterm
      fuzzel
      mako
      waybar
    ];
  };
}
