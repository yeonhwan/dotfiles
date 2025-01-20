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

    #shell
    zsh-syntax-highlighting
    
    # dev
    lazygit
    neovim

    # misc
    btop
    cmatrix
    fastfetch
  ];
}
