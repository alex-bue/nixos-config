{ ... }:
{
  imports = [
    ../../darwin/default.nix
    ../../darwin/casks.nix
  ];

  networking.hostName = "mbp-work";

  homebrew.casks = [
  ];
}
