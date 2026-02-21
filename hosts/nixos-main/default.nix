{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core.nix
  ];

  networking.hostName = "nixos-main";
}
