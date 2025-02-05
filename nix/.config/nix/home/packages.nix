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

    
    #shell
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-fzf-tab
    
    # dev
    lazygit
    neovim

    # misc
    btop
    cmatrix
    fastfetch
  ];
}
