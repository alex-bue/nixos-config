{ pkgs }:

with pkgs;
let shared-packages = import ../common/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  dockutil
  pngpaste # for nvim obsidian i think
]
