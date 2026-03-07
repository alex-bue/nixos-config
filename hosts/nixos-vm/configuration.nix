{ pkgs, config, ... }:
let
  enabled = {
    enable = true;
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/import.nix
    ../../modules/shared/import.nix
  ];

  config = {
    system.stateVersion = "24.11";
    time.timeZone = "Europe/Copenhagen";

    # VMware guest integration (host-specific)
    virtualisation.vmware.guest.enable = true;

    environment.systemPackages = [
      pkgs.neovim
    ];

    networking.hostName = "nixos-vm";
    nixpkgs.hostPlatform = "aarch64-linux";

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    mine = {
      user = {
        enable = true;
        name = "alex";
        homeDir = "/home/alex";
        home-manager.enable = true;
        shell.package = pkgs.zsh;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };
      apps = {
        codex = enabled;
        firefox = enabled;
      };
      cli-tools = {
        git = enabled;
      };
      desktop = {
        niri = enabled;
        addons = {
          greetd = enabled;
          portal = enabled;
          session = enabled;
        };
      };
      system = {
        nix = enabled;
        fonts = enabled;
        utils = enabled;
        sound.pipewire = enabled;
        networking.networkmanager = enabled;
        services = {
          openssh = enabled;
          polkit = enabled;
          dbus = enabled;
          keyring = enabled;
        };
      };
    };
  };
}
