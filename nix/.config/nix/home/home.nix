{ pkgs,lib, ... }:  # Remove other arguments for now

{
  home = {
    stateVersion = "24.11";
  };

  imports = [
    ./packages.nix
  ];

  programs = {
    home-manager.enable = true;

    git = {
        enable = true;
        userName = "yeonhwan";
        userEmail = "yeonhwan619@gmail.com";
        extraConfig = {
            init.defaultBranch = "main";
            pull.rebase = true;
        };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };


    # starship shell prompt
    starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        palettes = {
          teal = {
            tealwhite = "#e8fbfb";
            teal100 = "#b2d8d8";
            teal200 = "#66b2b2";
            teal300 = "#008080";
            teal400 = "#006666";
            teal500 = "#004c4c";
            tealsubtle = "#bec2c2";
            tealblack = "#002727";

          };
        };
        palette = "teal";

        right_format = lib.concatStrings[
          "$memory_usage"
          "$localip"
        ];

        format = lib.concatStrings [ 
          "[](teal100)"
          "[  ](bg:teal100 fg:teal500)"
          "$username"
          "[](bg:teal200 fg:teal100)"
          "$directory"
          "[](fg:teal200 bg:teal300)"
          "$git_branch"
          "$git_status"
          "[](fg:teal300 bg:teal400)"
          "$nodejs"
          "$rust"
          "$golang"
          "$php"
          "$nix_shell"
          "$lua"
          "$python"
          "[](fg:teal400 bg:teal500)"
          "$time"
          "[ ](fg:teal500)"
          "$character" 
        ];
        username = { 
          show_always = true;
          style_user = "bold bg:teal100 fg:teal500";
          style_root = "bg:teal100 fg:teal500";
          format = "[ $user ]($style)";
        };
        continuation_prompt = "🏃";
        directory = { 
          style = "fg:teal400 bg:teal200";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/"; 

          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
          };
        };
        localip = {
          disabled = false;
          ssh_only = false;
          format = "🌐 [$localipv4](dimmed fg:tealwhite)"; 
        };
        memory_usage = {
          disabled = false;
          symbol = "🤖";
          format = "$symbol [$ram_pct](dimmed fg:tealwhite) ";
        };
        git_branch = {
          symbol = "";
          style = "bg:teal300";
          format = "[[ $symbol $branch ](fg:tealblack bg:teal300)]($style)";
        };
        git_status = {
          style = "bg:teal300";
          format = "[[($all_status$ahead_behind )](fg:tealblack bg:teal300)]($style)";
        };
        
        # lang specific
        nodejs = {
          symbol = "";
          style = "bg:teal400";
          format = "[[ $symbol ($version) ](fg:tealwhite bg:teal400)]($style)";
        };
        rust = { 
          symbol = "";
          style = "bg:teal400";
          format = "[[ $symbol ($version) ](fg:tealwhite bg:teal400)]($style)";
        };

        golang = { 
          symbol = "";
          style = "bg:teal400";
          format = "[[ $symbol ($version) ](fg:tealwhite bg:teal400)]($style)";
        };

        php = { 
          symbol = "";
          style = "bg:teal400";
          format = "[[ $symbol ($version) ](fg:tealwhite bg:teal400)]($style)" ;
        };

        nix_shell = { 
          disabled = false;
          symbol = "";
          style = "bg:teal400";
          format = "[[ $symbol ($version) ](fg:tealwhite bg:teal400)]($style)" ;
        };

        lua = { 
          symbol = "";
          style = "bg:teal400";
          format = "[[ $symbol ($version) ](fg:tealwhite bg:teal400)]($style)" ;
        };

        time = { 
          disabled = false;
          # Hour:Minute Format
          time_format = "%R";   
          style = "bg:teal500";
          format = "[[  $time ](fg:tealwhite bg:teal500)]($style)";
        };
      };
    };

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

      sessionVariables = {
        PATH = "/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/.bun/bin:$HOME/.console-ninja/.bin:$PATH";
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
      nixgc = "nix-collect-garbage -d && nix-collect-garbage -d";
      ls = "eza --icons=always";
      cd = "z";
      lg = "lazygit";
      ll = "ls -al";
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

      # Bun completions
      [ -s "/Users/yh/.bun/_bun" ] && source "/Users/yh/.bun/_bun"
        '';
    };
  };
}
