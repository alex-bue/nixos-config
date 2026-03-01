{ inputs, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.self.nixosModules.base
    inputs.self.nixosModules.qtile
  ];

  networking.hostName = "nixos-vm";
  nixpkgs.hostPlatform = "aarch64-linux";

  users.users.ab = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  time.timeZone = "America/New_York";
  system.stateVersion = "24.11";
}
