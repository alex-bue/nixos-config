{ ... }:
{
  imports = [
    ../../modules/shared
    ../../modules/darwin/defaults.nix
    ../../modules/darwin/casks.nix
  ];

  networking.hostName = "mbp-work";

  homebrew.casks = [
  ];
}
