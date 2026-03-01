{
  config,
  pkgs,
  ...
}:
{
  programs.home-manager.enable = true;

  home.sessionPath = [
    "${config.home.homeDirectory}/.nix-profile/bin"
    "/etc/profiles/per-user/${config.home.username}/bin"
    "/run/current-system/sw/bin"
    "/nix/var/nix/profiles/default/bin"
  ];

  home.packages = with pkgs; [
    # Shell and terminal UX
    bash-completion
    bat
    btop
    htop
    starship
    tmux
    zoxide
    zsh-powerlevel10k

    # Core CLI utilities
    chezmoi
    tree
    unzip
    zip

    # Editors and navigation
    eza
    fzf
    neovim
    yazi

    # Security and secrets
    bitwarden-cli

    # Containers and cloud tooling
    docker
    docker-compose

    # Development and source control
    gh
    just
    lazygit
    nixfmt
    statix

    # Languages and runtimes
    tree-sitter
    cargo
    go
    nodejs_24
    openjdk
    pipx
    python3
    php
    rustc

    # Document and graphics tooling
    ffmpeg
    ghostscript
    graphviz
    imagemagick
    poppler
    tex-fmt
    texliveFull

    # Typography and fonts
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];
}
