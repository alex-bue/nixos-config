{ lib, config, ... }:
let
  cfg = config.mine.nixos.system.services.keyring;
in
{
  options.mine.nixos.system.services.keyring.enable = lib.mkEnableOption "GNOME Keyring";

  config = lib.mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
  };
}
