{ pkgs, ... }:
{
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    coreutils
    curl
    fd
    git
    gnupg
    jq
    ripgrep
    vim
    wget
    yq-go
  ];

  programs.zsh.enable = true;
  services.openssh.enable = true;
}
