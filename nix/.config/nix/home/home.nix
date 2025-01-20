{ pkgs, ... }:  # Remove other arguments for now

{
  home = {
    stateVersion = "24.11";
  };

  imports = [
    ./packages.nix
  ];

  programs = {
    home-manager.enable = true;

    # zsh configuration is done through nix-home-manager
    # .zshrc / .zshenv is locked
    zsh = {
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

      initExtraFirst = ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
            fi
            '';

      sessionVariables = {
        PATH = "/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/.bun/bin:$HOME/.console-ninja/.bin:$PATH";
      };

    # aliases
    shellAliases = {
      ".." = "cd ..";
      desktop = "cd /Users/yh/desktop";
      nixconfig = "cd ~/.config/nix && nvim";
      kittyconfig = "nvim ~/.config/kitty";
      vim = "nvim";
      imgpr = "kitten icat $(fd -e jpg -e svg -e webp -e png -e jpeg -e gif | fzf)";
      buildflake = "darwin-rebuild switch --flake \"$(readlink -f ~/.config/nix)\"#$HOSTNAME";
      ls = "eza --icons=always";
      cd = "z";
      lg = "lazygit";
      ll = "ls -al";
    };

    plugins = [
      {
        name = "zsh-powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
    ];

    # This will written to .zshrc
    initExtra = ''
      # brew setup
      eval "$(/opt/homebrew/bin/brew shellenv)"
      # P10k setup
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

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
      [ -s "$BREW_INSTALLED/nvm/nvm.sh" ] && . "$BREW_INSTALLED/nvm/nvm.sh"
      [ -s "$BREW_INSTALLED/nvm/etc/bash_completion" ] && . "$BREW_INSTALLED/nvm/etc/bash_completion"

      # Bun completions
      [ -s "/Users/yh/.bun/_bun" ] && source "/Users/yh/.bun/_bun"
        '';
    };
  };
}
