{pkgs,...}:
{
  homebrew = {
      enable = true;
      global.autoUpdate = false; 
      onActivation = {
          # autoUpdate = true; 
          # upgrade = true; 
          cleanup = "zap";
        };

        # App Store
        masApps = {
          Magnet = 441258766;
          Dropover = 1355679052;
          MinimaList = 1387764101;
          "카카오톡" = 869223134;
        };

        taps = [
          "nikitabobko/tap"
          "oven-sh/bun"
        ];

        brews = [
          "wget"
          "node"
          "nvm"
          "mas"
          "deno"
          "postgresql@17"
          "mysql"
          "docker-compose"
          "colima"
          "fonttools"
          "rbenv"
          "watchman"
          {
            name = "neovim";
            args = [ "HEAD" ];
          }
        ];

        casks = [
          "aerospace"
          "raycast"
          "kitty"
          "visual-studio-code"
          "arc"
          "google-chrome"
          "keka"
          "iina"
          "obsidian"
          "karabiner-elements"
          "obs"
          "ghostty"
          "pgadmin4"
          "dbeaver-community"
          "discord"
          "docker"
          "shottr"
          "notion"
          "zulu@17"
          "android-studio"
        ];
    };

}
