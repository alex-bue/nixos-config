{ lib, config, pkgs, ... }:
let
  cfg = config.mine.nixos.system.sound.pipewire;
in
{
  options.mine.nixos.system.sound.pipewire.enable = lib.mkEnableOption "Enable PipeWire audio stack";

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];
  };
}
