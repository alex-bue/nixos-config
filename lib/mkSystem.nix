{ nixpkgs, inputs }:
name:
{
  system,
  user,
  darwin ? false,
  wsl ? false,
  homeManager ? true,
}:
let
  lib = nixpkgs.lib;
  isDarwin = darwin;
  isWSL = wsl;
  isLinux = !darwin && !wsl;

  machineConfig = ../hosts/${name}/default.nix;
  userHMConfig = ../hosts/${name}/home.nix;

  systemFunc =
    if darwin then
      inputs.darwin.lib.darwinSystem
    else
      nixpkgs.lib.nixosSystem;

  hmModule =
    if darwin then
      inputs.home-manager.darwinModules.home-manager
    else
      inputs.home-manager.nixosModules.home-manager;
in
systemFunc {
  inherit system;

  specialArgs = inputs // {
    inherit inputs;
    hostName = name;
    hostUser = user;
    inherit isDarwin isLinux isWSL;
  };

  modules =
    [
      machineConfig
    ]
    ++ lib.optionals homeManager [
      hmModule
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            hostName = name;
            hostUser = user;
            inherit isDarwin isLinux isWSL;
          };
          users.${user} = import userHMConfig;
        };
      }
    ];
}
