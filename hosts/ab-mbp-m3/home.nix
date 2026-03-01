{ config, pkgs, lib, hostUser ? "ab", ... }:
let
  sharedPrograms = import ../../common/home.nix { inherit config pkgs lib hostUser; };
in
{
  home = {
    enableNixpkgsReleaseCheck = false;
    username = hostUser;
    homeDirectory = "/Users/${hostUser}";
    packages = pkgs.callPackage ../../darwin/packages.nix { };
    stateVersion = "23.11";
  };

  programs = sharedPrograms // { };

  manual.manpages.enable = false;
}
