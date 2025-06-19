{
  description = "Multi-host Nix flake for knosence";

  inputs = {
    nixpkgs-unstable = { url = "github:NixOS/nixpkgs/nixos-unstable"; };

    # home-manager tied to stable
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };


  };

  outputs = { self, nixpkgs-unstable, home-manager, ...}:
  let
    system = "x86_64-linux";

    # 1. Build two pkg sets with the same overlays
    unstablePkgs = import nixpkgs-unstable {
      inherit system;
    };


    # 2. Merge: unstable overrides, stable provides the holes
    pkgs = unstablePkgs;
  in {

      # ---- NixOS hosts ----
      nixosConfigurations = {
        framework13 = pkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            ./Config/default.nix
            ./Config/Hosts/framework13.nix
          ];
        };
        pi-deck = pkgs.lib.nixosSystem {
          system = "aarch64-linux";  # Pi architecture
          inherit pkgs;
          modules = [
            ./Config/default.nix
            #./Config/Hosts/pi-deck.nix
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
