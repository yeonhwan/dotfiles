# Setting up a Darwin Environment

## 0. Clone the Repository

Clone your dotfiles repository to the desired location on your system:

```bash
git clone git@github.com:yeonhwan/dotfiles.git ~/dotfiles
# if you have not set up SSH keys, use HTTPS
git clone https://github.com/LnL7/nix-darwin.git ~/dotfiles
```

## 1. Install Nix

Follow the Nix installation process as described on the official website: <https://nixos.org/download/>.

Alternatively, you can use the following command:

```bash
sh <(curl -L https://nixos.org/nix/install)
```

## 2. Build the Flake

Build and apply the `nix-darwin` configuration using your `flake.nix`:

```bash
# you should enable nix flake and nix-command first

mkdir -p ~/.config/nix && echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf

# this is the default flake for all environments (not plan to support multiple environments yet)
nix run nix-darwin -- switch --impure --flake ~/.dotfiles/nix/.config/nix#default
```

## 3. Stow Dotfiles

Use GNU Stow to link your dotfiles to their appropriate locations in the home directory:

- To stow all configurations at once:

  ```bash
  cd ~/dotfiles
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

2. **Homebrew is not installed**:

   if the nix-darwin doesn't install homebrew, you can install it manually by running the following command:

   ```bash
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. **Preview Stow Changes**:
   Before applying `stow`, preview the changes to avoid overwriting existing files:

   ```bash
   stow --no .
   ```

4. **SSH Key Issues with Git**:
   Ensure your SSH keys are properly set up for GitHub. Test them with:

   ```bash
   ssh -T git@github.com
   ```

5. **If you encounter Brew package error with Application.app**:

   Delete the Application.app from the /Applications directory and reinstall the package with brew.

6. **Commands**:

   ```bash
    # Update packages and rebuild the flake (brew packages are updated when rebuilding is done)
    nix flake update
    # Garbage Collecting
    sudo nix-collect-garbage -d

    # Rollback to certain version
    # switch to certain commit and rebuild the system
   ```

7. **If xCode is not installed**

   ```bash
   xcode-select --install

   ```
