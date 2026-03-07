{ lib, config, ... }:
let
  cfg = config.mine.nixos.system.nix;
in
{
  options.mine.nixos.system.nix.enable = lib.mkEnableOption "Nix settings";

  config = lib.mkIf cfg.enable {
    nix = {
      enable = true;
      settings = {
        experimental-features = "nix-command flakes";
        warn-dirty = false;
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}
