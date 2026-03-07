{ pkgs, config, ... }:
let
  enabled = {
    enable = true;
  };
in
{
  imports = [
    ../../modules/darwin/import.nix
    ../../modules/shared/import.nix
  ];

  config = {
    networking.hostName = "ab-mbp-m3";
    nixpkgs.hostPlatform = "aarch64-darwin";

    system = {
      primaryUser = config.mine.user.name;
      stateVersion = 5;
    };

    mine = {
      user = {
        enable = true;
        name = "ab";
        homeDir = "/Users/ab";
        home-manager.enable = true;
        shell.package = pkgs.zsh;
      };
      cli-tools.homebrew = enabled;
      apps = {
        aerospace = enabled;
        alfred = enabled;
        anki = enabled;
        anydesk = enabled;
        betterdisplay = enabled;
        bitwarden = enabled;
        codex = enabled;
        dbeaverCommunity = enabled;
        discord = enabled;
        dockerDesktop = enabled;
        googleChrome = enabled;
        hiddenbar = enabled;
        iina = enabled;
        karabinerElements = enabled;
        obsidian = enabled;
        onedrive = enabled;
        raycast = enabled;
        scrollReverser = enabled;
        skim = enabled;
        spotify = enabled;
        steam = enabled;
        subsurface = enabled;
        visualStudioCode = enabled;
        wezterm = enabled;
        zotero = enabled;
      };
      system = {
        defaults = enabled;
        nix = enabled;
        fonts = enabled;
        utils = enabled;
      };
    };
  };
}
