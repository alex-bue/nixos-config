{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.desktop.vicinae;
  user = config.mine.user.name;
in
{
  options.mine.desktop.vicinae.enable = lib.mkEnableOption "Enable vicinae (Home Manager)";

  config = lib.mkIf cfg.enable {
    home-manager.users.${user} = {
      home.packages = [
        pkgs.vicinae
      ];
    };
  };
}
