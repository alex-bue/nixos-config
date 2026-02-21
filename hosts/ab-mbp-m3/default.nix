{ ... }:
let
  casks = import ../../darwin/casks.nix;
in
{
  imports = [
    ../../darwin/default.nix
  ];

  networking.hostName = "ab-mbp-m3";

  homebrew.casks = casks.base ++ casks.personal;
}
