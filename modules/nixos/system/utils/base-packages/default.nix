{ lib, config, pkgs, ... }:
let
  cfg = config.mine.nixos.system.utils.base-packages;
in
{
  options.mine.nixos.system.utils.base-packages.enable = lib.mkEnableOption "Base NixOS packages";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim
    ];
  };
}
