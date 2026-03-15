{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.desktop.rofi;
  user = config.mine.user.name;
in
{
  options.mine.desktop.rofi.enable = lib.mkEnableOption "Enable rofi (Home Manager)";

  config = lib.mkIf cfg.enable {
    home-manager.users.${user} = {
      home.packages = [
        pkgs.rofi
      ];
    };
  };
}
