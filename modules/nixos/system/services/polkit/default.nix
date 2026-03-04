{ lib, config, ... }:
let
  cfg = config.mine.nixos.system.services.polkit;
in
{
  options.mine.nixos.system.services.polkit.enable = lib.mkEnableOption "PolicyKit";

  config = lib.mkIf cfg.enable {
    security.polkit.enable = true;
  };
}
