{ pkgs, self, username, lib, ... }:
{
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  nix.package = pkgs.nix;

  # nixpkgs
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # Add user to the system.
   users.users.${username} = {
     name = "${username}";
     home = "/Users/${username}";
   };

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Set basic system environment.
  environment = {
    systemPackages = with pkgs; [ 
      neovim 
      git
      home-manager
      libiconv
    ];
    shells = [ pkgs."zsh" ];
    systemPath = [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
      "/opt/homebrew/opt/postgresql@17/bin"
      "$HOME/.bun/bin"
      "$HOME/.local/share/pnpm"
      "$HOME/Library/Android/sdk/emulator"
      "$HOME/Library/Android/sdk/platform-tools"
    ];
    variables = {
      EDITOR = "nvim";
      HOMEBREW_PREFIX = "/opt/homebrew/opt";
      NVM_DIR = "$HOME/nvm";
      PNPM_HOME = "$HOME/.local/share/pnpm";
      JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home";
      ANDROID_HOME="$HOME/Library/Android/sdk";
    };
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;
}
