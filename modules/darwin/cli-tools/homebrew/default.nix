{ lib, config, inputs, ... }:
let
  cfg = config.mine.darwin.cli-tools.homebrew;
in
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  options.mine.darwin.cli-tools.homebrew.enable = lib.mkEnableOption "darwin homebrew integration";

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        upgrade = true;
        cleanup = "zap";
      };
    };

    nix-homebrew = {
      enable = true;
      autoMigrate = true;
      mutableTaps = true;
      user = config.system.primaryUser;
    };
  };
}
