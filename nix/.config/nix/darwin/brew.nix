{pkgs,...}:
{
  homebrew = {
      enable = true;
      global.autoUpdate = false; 
      onActivation = {
          autoUpdate = true; 
          upgrade = true; 
          cleanup = "zap";
        };

        # App Store
        masApps = {
          Magnet = 441258766;
          Dropover = 1355679052;
          MinimaList = 1387764101;
          "카카오톡" = 869223134;
          discord = 985746746;
        };

        taps = [
          "nikitabobko/tap"
          "oven-sh/bun"
        ];

        brews = [
          "wget"
          "nvm"
          "node"
          "mas"
          "deno"
          "postgresql@17"
          "mysql"
        ];

        casks = [
          "raycast"
          "aerospace"
          "kitty"
          "visual-studio-code"
          "arc"
          "google-chrome"
          "keka"
          "iina"
          "obsidian"
          "karabiner-elements"
          "ghostty"
          "pgadmin4"
          "dbeaver-community"
        ];
    };

}
