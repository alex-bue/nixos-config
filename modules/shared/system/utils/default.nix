{ lib, config, pkgs, ... }:
let
  cfg = config.mine.system.utils;
in
{
  options.mine.system.utils.enable = lib.mkEnableOption "shared system utilities";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      coreutils
      curl
      fd
      git
      gnupg
      jq
      ripgrep
      wget
      yq-go
    ];
  };
}
