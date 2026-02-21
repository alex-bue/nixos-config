{ config, pkgs, lib, hostUser ? "ab", ... }:
let
  sharedPrograms = import ../../modules/shared/home-manager.nix { inherit config pkgs lib hostUser; };
  sharedFiles = import ../../modules/shared/files.nix { inherit config pkgs; };
  additionalFiles = import ../../modules/darwin/files.nix { user = hostUser; inherit config pkgs; };
in
{
  home = {
    enableNixpkgsReleaseCheck = false;
    username = hostUser;
    homeDirectory = "/Users/${hostUser}";
    packages = pkgs.callPackage ../../modules/darwin/packages.nix { };
    file = lib.mkMerge [
      sharedFiles
      additionalFiles
    ];
    stateVersion = "23.11";
  };

  programs = sharedPrograms // { };

  manual.manpages.enable = false;
}
