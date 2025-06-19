{
  description = "Multi-host Nix flake for knosence";

  inputs = {
    # two channels of nixpkgs
    nixpkgs-stable = { url = "github:NixOS/nixpkgs/nixos-24.05"; };
    nixpkgs-unstable = { url = "github:NixOS/nixpkgs/nixos-unstable"; };

    # home-manager tied to stable
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # extra overlays
    stylix     = { url = "github:danth/stylix"; };
    # orca-slicer = { /* your orca-slicer flake URL here */ };

    #doom-emacs = {
    #url = "github:doomemacs/doom-emacs";
    # pin to a commit/branch if you like, e.g. ref = "develop";
    #};
  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable, stylix, home-manager, ...}:
  let
    system = "x86_64-linux";

    # 1. Build two pkg sets with the same overlays
    unstablePkgs = import nixpkgs-unstable {
      inherit system;
      overlays = [ stylix.overlay ];
    };
    stablePkgs = import nixpkgs-stable {
      inherit system;
      overlays = [ stylix.overlay ];
    };

    # 2. Merge: unstable overrides, stable provides the holes
    pkgs = stablePkgs // unstablePkgs;
  in {
      # ---- NixOS hosts ----
      nixosConfigurations = {
        framework13 = nixpkgs-stable.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            ./Config/default.nix
            ./Config/Hosts/framework13.nix
          ];
        };
        pi-deck = nixpkgs-stable.lib.nixosSystem {
          system = "aarch64-linux";  # Pi architecture
          inherit pkgs;
          modules = [
            ./Config/default.nix
            ./Config/Hosts/pi-deck.nix
          ];
        };
      };

      # ---- Home-manager profile ----
      homeConfigurations = {
        knosence = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./Home/default.nix
            ./Home/Users/knosence.nix
          ];
        };
      };
    };
}
