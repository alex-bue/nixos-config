{ pkgs }:

let
  sharedPackages = import ../common/packages.nix { inherit pkgs; };
in
sharedPackages ++ (with pkgs; [
  home-manager
])
