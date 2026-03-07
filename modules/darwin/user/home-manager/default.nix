{ lib, config, inputs, ... }:
let
  inherit (config.mine) user;
  cfg = user.home-manager;
in
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  config = lib.mkIf cfg.enable {
    mine.home-manager.shared.enable = true;

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      extraSpecialArgs = {
        inherit inputs user;
      };
      users.${user.name}.imports = [ ./home.nix ];
    };
  };
}
