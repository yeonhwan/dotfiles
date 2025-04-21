{config, pkgs, lib, ...}:
{
  # zsh configuration is done through nix-home-manager
  # .zshrc / .zshenv is locked
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };

    oh-my-zsh = {
      enable = true;
      theme = "apple";
      plugins = ["git"];
    };

    sessionVariables = {
      HISTFILE = "$HOME/.zhistory";
      SAVEHIST = "1000";
      HISTSIZE = "999";
    };

    # aliases
    shellAliases = {
      ".." = "cd ..";
      dotconfig = "cd ~/dotfiles/ && nvim";
      vim = "nvim";
      buildflake = "darwin-rebuild switch --impure --flake \"$(readlink -f ~/.config/nix)\"#default";
      # garbage collect twice as sudo & user
      nixgc = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
      ls = "eza --icons=always";
      cd = "z";
      lg = "lazygit";
      ldoc = "lazydocker";
      ll = "ls -al";
      tm = "tmux";
      tmx = "tmuxinator";
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.zsh";
      }
    ];

    # This will written to .zshrc
    initExtra = ''
      # brew setup
      eval "$(/opt/homebrew/bin/brew shellenv)"

      # History setup
      setopt share_history
        setopt hist_expire_dups_first
        setopt hist_ignore_dups
        setopt hist_verify

      # Key bindings
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward

      # zoxide
      eval "$(zoxide init zsh)"

      # autojump
      [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

      # thefuck
      eval $(thefuck --alias)

      # yazi function
      function yy() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }

      # NVM
      [ -s "$HOMEBREW_PREFIX/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/nvm/nvm.sh"
      [ -s "$HOMEBREW_PREFIX/nvm/etc/bash_completion" ] && . "$HOMEBREW_PREFIX/nvm/etc/bash_completion"


      # Load secret environment variables
      if [ -f "$HOME/.secrets.env" ]; then
        source "$HOME/.secrets.env"
      fi
    '';
  };
}
