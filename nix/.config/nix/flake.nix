
# Build darwin flake using:
# $ darwin-rebuild build --flake 

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
    username = "yh";
    useremail = "yeonhwan619@gmail.com";
    system = "aarch64-darwin"; 
    hostname = "YH-macbook";

    specialArgs = inputs // { 
      inherit username hostname useremail system;
      lib = nixpkgs.lib;
    };
  in 

  {
    darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [ 
        # nix & system base configuration
        ./modules/nix-core.nix
        # darwin system configuration 
        ./modules/system.nix
        # brew
        ./modules/brew.nix
        # user level & packages configuration
        home-manager.darwinModules.home-manager 
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.yh = import ./home/home.nix;
            backupFileExtension = "bak";
          };
        }
      ];
    };
  };
}
