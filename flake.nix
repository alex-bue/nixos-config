{
  description = "Starter Configuration for MacOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };
  };

  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      ...
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

      mkSystem = import ./lib/mkSystem.nix { inherit nixpkgs inputs; };
      mkHome = import ./lib/mkHome.nix { inherit home-manager nixpkgs; };

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

    in
    {
      devShells = forAllSystems devShell;

      darwinConfigurations = {
        mbp-work = mkSystem "mbp-work" {
          system = "aarch64-darwin";
          user = "ab";
          darwin = true;
        };

        ab-mbp-m3 = mkSystem "ab-mbp-m3" {
          system = "aarch64-darwin";
          user = "ab";
          darwin = true;
          homeManager = false;
        };
      };

      nixosConfigurations = {
        nixos-main = mkSystem "nixos-main" {
          system = "x86_64-linux";
          user = "ab";
        };
      };

      homeConfigurations = {
        "ab@mbp-work" = mkHome {
          name = "mbp-work";
          system = "aarch64-darwin";
          user = "ab";
          darwin = true;
        };

        "ab@nixos-main" = mkHome {
          name = "nixos-main";
          system = "x86_64-linux";
          user = "ab";
        };
      };
    };
}
