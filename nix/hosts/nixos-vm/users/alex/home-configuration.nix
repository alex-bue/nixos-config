{ inputs, ... }:
{
  imports = [
    inputs.self.homeModules.shared
    inputs.self.homeModules.linux_packages
  ];

  home.stateVersion = "24.11";
}
