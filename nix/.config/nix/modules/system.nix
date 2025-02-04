{pkgs, ... }:
{
  system = {
    stateVersion = 5;
    defaults = {
      # Darwin system configuration
      NSGlobalDomain = {
        #24-hour time
        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        AppleShowAllExtensions = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
      };
      WindowManager = {
        StandardHideDesktopIcons = true;
      };
      controlcenter = {
        BatteryShowPercentage = true;
      };
      dock = {
          show-recents = false;
          persistent-apps = [
          "System/Applications/Music.app"
          "System/Applications/Messages.app"
          "Applications/KakaoTalk.app"
          "Applications/Arc.app"
          "Applications/Ghostty.app"
          "Applications/Visual Studio Code.app"
          "System/Applications/System Settings.app"
          ];
        };
      finder = {
        AppleShowAllFiles = true;
        FXPreferredViewStyle = "Nlsv";
      };
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

 # Fonts
  fonts = {
    packages = with pkgs; [
      material-design-icons
      font-awesome
      material-design-icons
      font-awesome
      nerd-fonts.symbols-only  
      nerd-fonts.fira-code    
      nerd-fonts.jetbrains-mono  
      nerd-fonts.iosevka      
    ];
  };
}
