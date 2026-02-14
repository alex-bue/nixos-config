{ pkgs }:

with pkgs;
[
  # General packages for development and system management
  wezterm
  bash-completion
  bat
  btop
  chezmoi
  coreutils
  eza
  ffmpeg
  fd
  git
  graphviz
  imagemagick
  neovim
  starship
  wget
  yazi
  yq-go
  yt-dlp
  zoxide
  zip

  # Encryption and security tools
  gnupg
  bitwarden-cli

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Node.js development tools
  nodejs_24

  # Text and terminal utilities
  htop
  jetbrains-mono
  nerd-fonts.jetbrains-mono
  jq
  nixfmt
  ripgrep
  tree
  tmux
  unzip
  zsh-powerlevel10k

  # Development tools
  curl
  gh
  lazygit
  fzf

  # Programming languages and runtimes
  go
  rustc
  cargo
  openjdk

  # Python packages
  python3
]
