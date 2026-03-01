{ ... }:
let
  casks = import ../../darwin/casks.nix;
in
{
  imports = [
    ../../darwin/default.nix
  ];

  networking.hostName = "mbp-work";

  homebrew.casks = casks.base ++ casks.work;
}
