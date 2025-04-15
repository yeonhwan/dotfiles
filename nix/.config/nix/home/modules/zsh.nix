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
      # pnpm global directory added
      PNPM_HOME = "$HOME/.local/share/pnpm";
      PATH = "/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/.bun/bin:$HOME:/opt/homebrew/opt/postgresql@17/bin:$HOME/.local/share/pnpm:$PATH";
    };

    # aliases
    shellAliases = {
      ".." = "cd ..";
      desktop = "cd /Users/yh/desktop";
      dotconfig = "cd ~/dotfiles/ && nvim";
      kittyconfig = "nvim ~/.config/kitty";
      vim = "nvim";
      imgpr = "kitten icat $(fd -e jpg -e svg -e webp -e png -e jpeg -e gif | fzf)";
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
      [ -s "$BREW_INSTALLED/nvm/nvm.sh" ] && . "$BREW_INSTALLED/nvm/nvm.sh"
      [ -s "$BREW_INSTALLED/nvm/etc/bash_completion" ] && . "$BREW_INSTALLED/nvm/etc/bash_completion"
    '';
  };
}
