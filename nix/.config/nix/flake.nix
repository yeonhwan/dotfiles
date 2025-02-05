
# Build darwin flake using:
# $ darwin-rebuild build --impure --flake 

{
  description = "YH nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }:

  let
    username = builtins.getEnv "USER";
    useremail = "yeonhwan619@gmail.com";
    system = builtins.currentSystem;
    hostname = "YH-macbook";

    specialArgs = inputs // { 
      inherit username hostname useremail system;
      lib = nixpkgs.lib;
    };
  in 

  {
    darwinConfigurations = {
      default = nix-darwin.lib.darwinSystem {
        inherit system specialArgs;
        modules = [ 
          # nix & system base configuration
          ./darwin/nix-core.nix
          # darwin system configuration 
          ./darwin/system.nix
          # brew
          ./darwin/brew.nix
          # user level & packages configuration
          home-manager.darwinModules.home-manager 
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./home/home.nix;
              backupFileExtension = "bak";
            };
          }
        ];
      };
    };
  };
}
