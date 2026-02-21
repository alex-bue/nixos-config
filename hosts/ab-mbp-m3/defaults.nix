{ ... }:
{
  imports = [
    ../../modules/shared
    ../../modules/darwin/defaults.nix
    ../../modules/darwin/casks.nix
  ];

  networking.hostName = "ab-mbp-m3";

  homebrew.casks = [
    "discord"
    "obsidian"
    "spotify"
    "scroll-reverser"
    "dbeaver-community"
  ];
}
