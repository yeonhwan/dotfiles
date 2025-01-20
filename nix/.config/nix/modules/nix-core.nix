{ pkgs, self, username, lib, ... }:
{
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  nix.package = pkgs.nix;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  
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
    ];
    shells = [ pkgs."zsh" ];
    systemPath = [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
    ];
    variables = {
      EDITOR = "nvim";
      BREW_INSTALLED = "/opt/homebrew/opt";
      HOMEBREW_PREFIX = "/opt/homebrew/opt";
      HISTFILE = "$HOME/.zhistory";
      SAVEHIST = "1000";
      HISTSIZE = "999";
      NVM_DIR = "$BREW_INSTALLED/nvm";
      BUN_INSTALL = "$HOME/.bun";
    };
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;
}
