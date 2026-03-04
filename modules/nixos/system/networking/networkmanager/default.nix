{ lib, config, ... }:
let
  cfg = config.mine.nixos.system.networking.networkmanager;
in
{
  options.mine.nixos.system.networking.networkmanager.enable = lib.mkEnableOption "NetworkManager";

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;
  };
}
