{
  description = "Starter Configuration for MacOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      darwin,
      nix-homebrew,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      home-manager,
      nixpkgs,
      disko,
    }@inputs:
    let
      lib = nixpkgs.lib;
      linuxSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      darwinSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      hosts = import ./hosts/hosts.nix;
      homes = import ./hosts/homes.nix { inherit lib hosts; };
      darwinHosts = lib.filterAttrs (_: host: host.type == "darwin") hosts;
      nixosHosts = lib.filterAttrs (_: host: host.type == "nixos") hosts;

      forAllSystems = f: lib.genAttrs (linuxSystems ++ darwinSystems) f;

      devShell =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default =
            with pkgs;
            mkShell {
              nativeBuildInputs = with pkgs; [
                bashInteractive
                git
              ];
              shellHook = with pkgs; ''
                export EDITOR=vim
              '';
            };
        };

      mkApp = scriptName: system: {
        type = "app";
        program = "${
          (nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
            #!/usr/bin/env bash
            PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
            echo "Running ${scriptName} for ${system}"
            exec ${self}/apps/${system}/${scriptName}
          '')
        }/bin/${scriptName}";
      };

      mkLinuxApps = system: {
        "apply" = mkApp "apply" system;
        "build-switch" = mkApp "build-switch" system;
        "clean" = mkApp "clean" system;
        "copy-keys" = mkApp "copy-keys" system;
        "create-keys" = mkApp "create-keys" system;
        "check-keys" = mkApp "check-keys" system;
        "install" = mkApp "install" system;
      };

      mkDarwinApps = system: {
        "apply" = mkApp "apply" system;
        "build" = mkApp "build" system;
        "build-switch" = mkApp "build-switch" system;
        "clean" = mkApp "clean" system;
        "copy-keys" = mkApp "copy-keys" system;
        "create-keys" = mkApp "create-keys" system;
        "check-keys" = mkApp "check-keys" system;
        "rollback" = mkApp "rollback" system;
      };
    in
    {
      devShells = forAllSystems devShell;
      apps = lib.genAttrs linuxSystems mkLinuxApps // lib.genAttrs darwinSystems mkDarwinApps;

      darwinConfigurations = lib.mapAttrs (
        hostName: host:
        darwin.lib.darwinSystem {
          system = host.system;
          specialArgs = inputs // {
            inherit hostName;
            hostUser = host.user;
          };
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                user = host.user;
                enable = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit hostName;
                  hostUser = host.user;
                };
                users.${host.user} = import host.homeModule;
              };
            }
          ] ++ host.modules;
        }
      ) darwinHosts;

      nixosConfigurations = lib.mapAttrs (
        hostName: host:
        nixpkgs.lib.nixosSystem {
          system = host.system;
          specialArgs = inputs // {
            inherit hostName;
            hostUser = host.user;
          };
          modules = [
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit hostName;
                  hostUser = host.user;
                };
                users.${host.user} = import host.homeModule;
              };
            }
          ] ++ host.modules;
        }
      ) nixosHosts;

      homeConfigurations = lib.mapAttrs (
        _name: home:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${home.system};
          extraSpecialArgs = {
            hostName = home.hostName;
            hostUser = home.user;
          };
          modules = [ home.module ];
        }
      ) homes;
    };
}
