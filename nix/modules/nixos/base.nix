{ pkgs, ... }:
{
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    coreutils
    curl
    fd
    git
    gnupg
    jq
    ripgrep
    wget
    yq-go
  ];

  programs.zsh.enable = true;
  services.openssh.enable = true;
}
