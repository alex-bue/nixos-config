{ lib, config, ... }:
let
  cfg = config.mine.nixos.system.services.dbus;
in
{
  options.mine.nixos.system.services.dbus.enable = lib.mkEnableOption "D-Bus";

  config = lib.mkIf cfg.enable {
    services.dbus.enable = true;
  };
}
