{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.apps.steam;
in
{
  options.mine.apps.steam.enable = lib.mkEnableOption "Install Steam";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.steam
    ];
  };
}
