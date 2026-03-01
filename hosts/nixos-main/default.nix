{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../nixos/default.nix
  ];

  networking.hostName = "nixos-main";
}
