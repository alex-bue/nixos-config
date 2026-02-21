{ pkgs, hostUser ? "ab", ... }:
{
  imports = [
    ../common/default.nix
  ];

  nix.enable = false;

  environment = {
    systemPackages = import ../common/packages.nix { inherit pkgs; };
    shells = [ pkgs.zsh ];
  };

  system = {
    checks.verifyNixPath = false;
    primaryUser = hostUser;
    stateVersion = 5;

    defaults = {
      ".GlobalPreferences" = {
        "com.apple.mouse.scaling" = 0.6875;
      };

      NSGlobalDomain = {
        KeyRepeat = 2;
        InitialKeyRepeat = 10;
        ApplePressAndHoldEnabled = false;
        AppleInterfaceStyleSwitchesAutomatically = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticInlinePredictionEnabled = true;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowShouldDragOnGesture = true;
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
        expose-group-apps = true;
        mru-spaces = false;
        persistent-apps = [
          { app = "/System/Applications/System Settings.app"; }
          { app = "/Applications/Google Chrome.app"; }
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

      hitoolbox.AppleFnUsageType = "Change Input Source";
      screencapture.target = "clipboard";
      spaces.spans-displays = true;

      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
        TrackpadPinch = true;
        TrackpadRotate = true;
      };

      universalaccess.reduceMotion = false;

      WindowManager = {
        AppWindowGroupingBehavior = true;
        EnableStandardClickToShowDesktop = false;
        EnableTilingByEdgeDrag = false;
        EnableTilingOptionAccelerator = false;
        EnableTopTilingByEdgeDrag = false;
      };
    };

    keyboard.enableKeyMapping = true;
  };

  users.users.${hostUser} = {
    name = hostUser;
    home = "/Users/${hostUser}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    masApps = {
      # "wireguard" = 1451685025;
    };
  };
}
