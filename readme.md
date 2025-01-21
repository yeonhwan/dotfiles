# Setting up a Darwin Environment

## 0. Clone the Repository

Clone your dotfiles repository to the desired location on your system:

```bash
git clone git@github.com:yeonhwan/dotfiles.git ~/.dotfiles
```

## 1. Install Nix

Follow the Nix installation process as described on the official website: <https://nixos.org/download/>.
Alternatively, you can use the following command:

```bash
sh <(curl -L https://nixos.org/nix/install)
```

- Need to setup custom username & hostname before the building process

## 2. Build the Flake

Build and apply the `nix-darwin` configuration using your `flake.nix`:

```bash
nix run nix-darwin switch --impure --flake ~/.dotfiles/nix/.config/nix
```

## 3. Stow Dotfiles

Use GNU Stow to link your dotfiles to their appropriate locations in the home directory:

- To stow all configurations at once:

  ```bash
  cd ~/.dotfiles
  stow .
  ```

- To stow specific configurations (e.g., Neovim and Nix only):

  ```bash
  stow nvim nix
  ```

## Verifications

After completing the steps, verify the setup:

1. Check the Nix installation:

   ```bash
   nix --version
   ```

2. Verify that `nix-darwin` is installed and functioning:

   ```bash
   darwin-rebuild --version
   ```

3. Confirm that GNU Stow has correctly applied the dotfiles by inspecting your home directory.

## Notes and Troubleshooting

1. **Using `darwin-rebuild` Instead of `nix run`**:
   After the initial `nix-darwin` setup, you can use the following command to rebuild and apply configuration changes:
   _Note_ : --impure flag is needed to access system enviornment variables

   ```bash
   darwin-rebuild switch --impure --flake ~/.dotfiles/nix

   # can use shell alias after building the flake
   buildflake
   ```

2. **Preview Stow Changes**:
   Before applying `stow`, preview the changes to avoid overwriting existing files:

   ```bash
   stow --no .
   ```

3. **SSH Key Issues with Git**:
   Ensure your SSH keys are properly set up for GitHub. Test them with:

   ```bash
   ssh -T git@github.com
   ```

4. **Resolving Path Conflicts**:
   If `~/.config/nix-darwin` exists and is causing conflicts, you can either:

   - Remove it and replace it with a symlink to your flake:

     ```bash
     rm -rf ~/.config/nix-darwin
     ln -sf ~/.dotfiles/nix ~/.config/nix-darwin
     ```

   - Or always reference the correct path in your commands:

     ```bash
     darwin-rebuild switch --flake ~/.dotfiles/nix
     ```
