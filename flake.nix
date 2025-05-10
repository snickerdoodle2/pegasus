{
  description = "Pegasus";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        buildInputs = with pkgs; [
          ant
          gnumake
          jdk23
          libgcc

          python3
          python312Packages.gitpython
          python312Packages.pip
          python312Packages.pyyaml
          python312Packages.tox
        ];
      in
        with pkgs; {
          devShells.default = mkShell {
            inherit buildInputs;
          };
        }
    );
}
