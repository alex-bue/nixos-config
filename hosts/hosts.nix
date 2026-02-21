{
  mbp-work = {
    type = "darwin";
    system = "aarch64-darwin";
    user = "ab";
    modules = [ ./mbp-work/defaults.nix ];
    homeModule = ./mbp-work/home.nix;
  };

  ab-mbp-m3 = {
    type = "darwin";
    system = "aarch64-darwin";
    user = "ab";
    modules = [ ./ab-mbp-m3/defaults.nix ];
    homeModule = null;
  };

  nixos-main = {
    type = "nixos";
    system = "x86_64-linux";
    user = "ab";
    modules = [ ./nixos-main/default.nix ];
    homeModule = ./nixos-main/home.nix;
  };
}
