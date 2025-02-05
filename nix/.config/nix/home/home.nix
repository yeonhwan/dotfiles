{ pkgs,lib, ... }: 
{
  home = {
    stateVersion = "25.05";
  };
  programs = {
    home-manager.enable = true;
  };
  imports = [
    ./packages.nix
    ./modules/starship.nix
    ./modules/zsh.nix
    ./modules/etc.nix
  ];
}
