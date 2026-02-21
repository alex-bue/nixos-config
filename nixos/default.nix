{
  lib,
  pkgs,
  hostName ? "nixos-main",
  hostUser ? "ab",
  ...
}:
{
  imports = [
    ../common/default.nix
  ];

  networking.hostName = lib.mkDefault hostName;
  time.timeZone = "America/New_York";

  programs.zsh.enable = true;
  services.openssh.enable = true;

  users.users.${hostUser} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = import ./packages.nix { inherit pkgs; };

  # Keep this pinned to the first NixOS release you install with this config.
  system.stateVersion = "24.11";
}
