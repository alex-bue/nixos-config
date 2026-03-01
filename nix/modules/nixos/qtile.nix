{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    xkb.layout = "us";

    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+qtile";
    };

    windowManager.qtile.enable = true;
  };

  environment.systemPackages = with pkgs; [
    alacritty
    feh
    qtile
    rofi
  ];
}
