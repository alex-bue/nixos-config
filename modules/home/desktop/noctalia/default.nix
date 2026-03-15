{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.mine.desktop.noctalia;
  user = config.mine.user.name;
in
{
  options.mine.desktop.noctalia.enable = lib.mkEnableOption "Enable Noctalia (Home Manager)";

  config = lib.mkIf cfg.enable {
    home-manager.users.${user} = {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia-shell = {
        enable = true;
        settings = {
          colorSchemes = {
            predefinedScheme = "Everforest";
            schedulingMode = "off";
          };
          bar = {
            barType = "simple";
            density = "compact";
            outerCorners = false;
            showCapsule = false;
            widgets = {
              left = [
                {
                  id = "Clock";
                }
                {
                  id = "SystemMonitor";
                  compactMode = false;
                }
                {
                  id = "ActiveWindow";
                }
                {
                  id = "MediaMini";
                }
              ];
              center = [
                {
                  id = "Workspace";
                }
              ];
              right = [
                {
                  id = "Tray";
                }
                {
                  id = "NotificationHistory";
                }
                {
                  id = "Volume";
                }
                {
                  id = "Battery";
                }
                {
                  id = "Launcher";
                }
                {
                  id = "ControlCenter";
                }
              ];
            };
          };
          ui = {
            settingsPanelMode = "centered";
            settingsPanelSideBarCardStyle = true;
          };
          location = {
            name = "Copenhagen";
          };
          appLauncher = {
            enableClipboardHistory = true;
          };
          controlCenter = {
            cards = [
              {
                enabled = true;
                id = "profile-card";
              }
              {
                enabled = true;
                id = "shortcuts-card";
              }
              {
                enabled = true;
                id = "audio-card";
              }
              {
                enabled = true;
                id = "brightness-card";
              }
              {
                enabled = true;
                id = "weather-card";
              }
              {
                enabled = true;
                id = "media-sysmon-card";
              }
            ];
          };
        };
      };
    };
  };
}
