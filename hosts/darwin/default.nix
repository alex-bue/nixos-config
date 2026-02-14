{ pkgs, ... }:

let
  user = "ab";
in

{
  imports = [
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
  ];

  # Determinate manages Nix and nix.conf, so disable nix-darwin's Nix management.
  nix.enable = false;

  # nix = {
  #   package = pkgs.nix;
  #
  #   settings = {
  #     trusted-users = [ "@admin" "${user}" ];
  #     substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
  #     trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  #   };
  #
  #   gc = {
  #     automatic = true;
  #     interval = { Weekday = 0; Hour = 2; Minute = 0; };
  #     options = "--delete-older-than 30d";
  #   };
  #
  #   extraOptions = ''
  #     experimental-features = nix-command flakes
  #   '';
  # };

  environment = {
    systemPackages = import ../../modules/shared/packages.nix { inherit pkgs; };
    shells = [ pkgs.zsh ];
  };

  system = {
    checks.verifyNixPath = false;
    primaryUser = user;
    stateVersion = 5;

    defaults = {
      ".GlobalPreferences" = {
        "com.apple.mouse.scaling" = 0.6875;
      };

      NSGlobalDomain = {
        # keyboard
        KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2
        InitialKeyRepeat = 10; # Values: 120, 94, 68, 35, 25, 15
        ApplePressAndHoldEnabled = false;

        AppleInterfaceStyleSwitchesAutomatically = true;

        # spelling and prediction
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticInlinePredictionEnabled = true;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;

        # windows
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowShouldDragOnGesture = true;

        # menubar
        _HIHideMenuBar = false;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.trackpad.scaling" = 1.5;
      };

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 48;
        expose-group-apps = true; # nice to have for aerospace
        mru-spaces = false; # rearrange spaces on recent use
        persistent-apps = [
          {
            app = "/System/Applications/System Settings.app";
          }
          {
            app = "/Applications/Google Chrome.app";
          }
        ];
      };

      finder = {
        AppleShowAllExtensions = true;
        FXDefaultSearchScope = null;
        FXPreferredViewStyle = "clmv";
        FXRemoveOldTrashItems = true;
        NewWindowTarget = "Home";
        QuitMenuItem = false;
        ShowExternalHardDrivesOnDesktop = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = false;
      };

      hitoolbox = {
        AppleFnUsageType = "Change Input Source";
      };

      screencapture = {
        target = "clipboard";
      };

      spaces = {
        spans-displays = true;
      };

      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
        TrackpadPinch = true;
        TrackpadRotate = true;
      };

      universalaccess = {
        reduceMotion = false;
      };

      WindowManager = {
        AppWindowGroupingBehavior = true;
        EnableStandardClickToShowDesktop = false;
        EnableTilingByEdgeDrag = false;
        EnableTilingOptionAccelerator = false;
        EnableTopTilingByEdgeDrag = false;
      };
    };

    keyboard = {
      enableKeyMapping = true;
    };

  };
}
