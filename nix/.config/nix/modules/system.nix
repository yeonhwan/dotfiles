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
          "Applications/Visual Studio Code.app"
          "Applications/Kitty.app"
          "System/Applications/System Settings.app"
          ];
        };
      finder = {
        AppleShowAllFiles = true;
        FXPreferredViewStyle = "Nlsv";
      };
    };
    activationScripts = {
      extraActivation.text = ''
            echo "Checking if Kitty is installed"
            if [ -d /Applications/kitty.app ]; then
              echo "Kitty is installed Changing the icon"
              curl -L -o /tmp/neue_azure.icns https://raw.githubusercontent.com/k0nserv/kitty-icon/main/build/neue_azure.icns
              echo "Copying the new icon to Kitty"
              cp -f /tmp/neue_azure.icns /Applications/kitty.app/Contents/Resources/kitty.icns
              echo "Clearing the icon cache and restarting the dock to apply the changes"
              rm /var/folders/*/*/*/com.apple.dock.iconcache;
              killall Dock
            else 
              echo "Kitty seems not correctly installed"
            fi
            '';
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
