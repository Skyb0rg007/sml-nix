{
  pkgs ? import <nixpkgs> { },
}:
import ./pkgs/smlnj { inherit pkgs; } // import ./pkgs/mlton { inherit pkgs; }
