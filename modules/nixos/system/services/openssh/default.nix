{ lib, config, ... }:
let
  cfg = config.mine.nixos.system.services.openssh;
in
{
  options.mine.nixos.system.services.openssh.enable = lib.mkEnableOption "OpenSSH service";

  config = lib.mkIf cfg.enable {
    services.openssh.enable = true;
  };
}
