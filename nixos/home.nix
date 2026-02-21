{ config, pkgs, lib, hostUser ? "ab", ... }:
let
  sharedPrograms = import ../common/home.nix { inherit config pkgs lib hostUser; };
in
{
  home = {
    enableNixpkgsReleaseCheck = false;
    username = hostUser;
    homeDirectory = "/home/${hostUser}";
    packages = pkgs.callPackage ./packages.nix { };
    stateVersion = "24.11";
  };

  programs = sharedPrograms // { };
}
