{ home-manager, nixpkgs }:
{
  name,
  system,
  user,
  darwin ? false,
  wsl ? false,
}:
home-manager.lib.homeManagerConfiguration {
  pkgs = nixpkgs.legacyPackages.${system};
  extraSpecialArgs = {
    hostName = name;
    hostUser = user;
    isDarwin = darwin;
    isLinux = !darwin && !wsl;
    isWSL = wsl;
  };
  modules = [ ../hosts/${name}/home.nix ];
}
