{pkgs, ...}:

{ 
  #nixpkgs package
  home.packages =  with pkgs; [
    # test
    cowsay 

    # environment
    stow 
    gcc
    cargo
    mkcert

    # terminal
    autojump
    bat
    eza
    fd
    fselect
    fzf
    yazi
    zoxide
    thefuck
    tldr
    ripgrep
    tmux
    tmuxinator
    httpie

    
    #shell
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-fzf-tab
    nushell
    
    # dev
    lazygit
    neovim
    bun

    # misc
    btop
    cmatrix
    fastfetch
  ];
}
