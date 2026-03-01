{ inputs, pkgs, ... }:
{
  imports = [
    inputs.self.darwinModules.base
    inputs.self.darwinModules.casks-base
    inputs.self.darwinModules.casks-personal
  ];

  networking.hostName = "ab-mbp-m3";
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.ab = {
    name = "ab";
    home = "/Users/ab";
    shell = pkgs.zsh;
  };

  nix-homebrew.user = "ab";

  system.primaryUser = "ab";
  system.stateVersion = 5;
}
