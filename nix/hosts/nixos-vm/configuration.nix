{ inputs, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.self.nixosModules.base
    inputs.self.nixosModules.niri
  ];

  networking.hostName = "nixos-vm";
  nixpkgs.hostPlatform = "aarch64-linux";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.alex = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  # VMware guest integration (host-specific)
  virtualisation.vmware.guest.enable = true;

  time.timeZone = "America/New_York";
  system.stateVersion = "24.11";
}
