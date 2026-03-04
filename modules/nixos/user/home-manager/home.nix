{ user, pkgs, ... }:
{
  imports = [
    ../../../home/import.nix
  ];

  mine.home.shared.enable = true;

  programs.home-manager.enable = true;

  home = {
    username = user.name;
    homeDirectory = user.homeDir;
    stateVersion = "24.11";
  };

  home.packages = with pkgs; [
    codex
  ];
}
