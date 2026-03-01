{ inputs, ... }:
{
  imports = [
    inputs.self.homeModules.shared
  ];

  home.stateVersion = "24.11";
}
