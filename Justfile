set shell := ["bash", "-euo", "pipefail", "-c"]

host := `hostname -s`
user := `whoami`

default:
  @just --list

build:
  @just build-host
  @just build-home

switch:
  @just switch-host
  @just switch-home

host:
  @just build-host
  @just switch-host

build-host:
  @if [ "$(uname)" = "Darwin" ]; then \
    nix build .#darwinConfigurations.{{host}}.system; \
  elif [ "$(uname)" = "Linux" ]; then \
    nix build .#nixosConfigurations.{{host}}.config.system.build.toplevel; \
  else \
    echo "Unsupported OS: $(uname)"; \
    exit 1; \
  fi

switch-host:
  @if [ "$(uname)" = "Darwin" ]; then \
    sudo darwin-rebuild switch --flake .#{{host}}; \
  elif [ "$(uname)" = "Linux" ]; then \
    sudo nixos-rebuild switch --flake .#{{host}}; \
  else \
    echo "Unsupported OS: $(uname)"; \
    exit 1; \
  fi

home:
  @just build-home
  @just switch-home

check:
  nix flake check --show-trace

show:
  nix flake show

update:
  nix flake update

build-home:
  @cfg="{{user}}@{{host}}"; \
  if [ "$(nix eval --impure --raw --expr "let f = builtins.getFlake (toString ./.); in if builtins.hasAttr \"${cfg}\" f.homeConfigurations then \"true\" else \"false\"")" = "true" ]; then \
    if command -v nh >/dev/null 2>&1; then \
      nh home build . --configuration "${cfg}"; \
    else \
      nix run home-manager -- build --flake ".#${cfg}"; \
    fi; \
  else \
    echo "Skipping Home Manager: no homeConfigurations.${cfg} in flake outputs"; \
  fi

switch-home:
  @cfg="{{user}}@{{host}}"; \
  if [ "$(nix eval --impure --raw --expr "let f = builtins.getFlake (toString ./.); in if builtins.hasAttr \"${cfg}\" f.homeConfigurations then \"true\" else \"false\"")" = "true" ]; then \
    if command -v nh >/dev/null 2>&1; then \
      nh home switch . --configuration "${cfg}"; \
    else \
      nix run home-manager -- switch --flake ".#${cfg}"; \
    fi; \
  else \
    echo "Skipping Home Manager: no homeConfigurations.${cfg} in flake outputs"; \
  fi
