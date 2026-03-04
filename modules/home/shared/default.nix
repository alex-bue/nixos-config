{ lib, config, pkgs, ... }:
let
  cfg = config.mine.home.shared;
in
{
  options.mine.home.shared.enable = lib.mkEnableOption "shared home-manager settings";

  config = lib.mkIf cfg.enable {
    programs.home-manager.enable = true;

    home.sessionPath = [
      "${config.home.homeDirectory}/.nix-profile/bin"
      "/etc/profiles/per-user/${config.home.username}/bin"
      "/run/current-system/sw/bin"
      "/nix/var/nix/profiles/default/bin"
    ];

    home.packages = with pkgs; [
      bash-completion
      bat
      btop
      htop
      starship
      tmux
      zoxide
      zsh-powerlevel10k
      chezmoi
      tree
      unzip
      zip
      eza
      fzf
      neovim
      yazi
      bitwarden-cli
      docker
      docker-compose
      gh
      just
      lazygit
      nixfmt
      statix
      tree-sitter
      cargo
      go
      nodejs_24
      openjdk
      pipx
      python3
      php
      rustc
      gcc
      ffmpeg
      ghostscript
      graphviz
      imagemagick
      poppler
      tex-fmt
      texliveFull
    ];
  };
}
