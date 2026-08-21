{
  description = "Cedric's Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Install herdr as a flake input because it does not exist as a package in nixpkgs yet.
    # TODO: Move herdr to home.nix when it exists as a nixpkg. You can search for herdr in nixpkgs
    # using `nix search nixpkgs herdr`.
    herdr = {
      url = "github:herdrdev/herdr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, herdr, ... }: {
    homeConfigurations = {
      "cedric" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          herdr = herdr.packages.aarch64-linux.default;
        };
      };
    };
  };
}
