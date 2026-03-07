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
      apps = {
        codex = enabled;
        firefox = enabled;
      };
      cli-tools = {
        git = enabled;
      };
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
      nixos = {
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
          sound.pipewire = enabled;
          networking.networkmanager = enabled;
          utils.base-packages = enabled;
          services = {
            openssh = enabled;
            polkit = enabled;
            dbus = enabled;
            keyring = enabled;
          };
        };
      };
      system = {
        fonts = enabled;
        utils = enabled;
      };
    };
  };
}
