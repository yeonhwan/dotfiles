# Setting up a darwin environment

## 0. Clone the repository

```bash

git clone git@github.com:yeonhwan/dotfiles.git ~/.dotfiles
```

## 1. Installing Nix

Refer the Nix installation process : <https://nixos.org/download/>

```bash
sh <(curl -L https://nixos.org/nix/install)
```

## 2. Build the flake

```bash
nix run nix-darwin switch --flake  ~/.dotfiles/nix/.config/nix
```

## 3. Stow the dotfiles to the home directory

```bash
cd ~/.dotfiles
# dotfiles for ~
stow .

# you can stow dotfiles for specific directory
stow nvim nix (...)
```
