{
  description = "Flake for Standard ML compilers and utilities";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        formatter = pkgs.nixfmt-tree;
        packages = import ./default.nix { inherit pkgs; };
        hydraJobs = {
          inherit (self.packages) "x86_64-linux";
        };
      }
    );
}
