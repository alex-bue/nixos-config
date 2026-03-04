{ lib, config, ... }:
let
  cfg = config.mine.nixos.system.shell.zsh;
in
{
  options.mine.nixos.system.shell.zsh.enable = lib.mkEnableOption "Zsh shell";

  config = lib.mkIf cfg.enable {
    programs.zsh.enable = true;
  };
}
