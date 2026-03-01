{ pkgs }:

with pkgs;
[
  # Shell and terminal UX
  bash-completion
  bat
  btop
  htop
  starship
  tmux
  wezterm
  zoxide
  zsh-powerlevel10k

  # Core CLI utilities
  chezmoi
  coreutils
  fd
  git
  jq
  ripgrep
  tree
  unzip
  wget
  yq-go
  zip

  # Editors and navigation
  eza
  fzf
  neovim
  yazi

  # Security and secrets
  bitwarden-cli
  gnupg

  # Containers and cloud tooling
  docker
  docker-compose

  # Development and source control
  # codex # seems broken atm?
  curl
  gh
  just
  lazygit
  nixfmt
  statix
  luajitPackages.luarocks

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
]
