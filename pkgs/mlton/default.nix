{
  pkgs ? import <nixpkgs> { },
}:
rec {
  mlton-20251029 = pkgs.callPackage ./from-git.nix {
    bootstrapMlton = mlton-20241230-binary;
    rev = "61baac7108fbd91413f0537b7a42d9a1023455f4";
    hash = "sha256-nWR7ZaXfKxeXfZ9IHipAQ39ASVtva4BeDHP3Zq8mqPo=";
    version = "20251029";
  };

  mlton-20241230-binary = pkgs.callPackage ./20241230-binary.nix { };
  mlton-20241230 = pkgs.callPackage ./from-git.nix {
    bootstrapMlton = mlton-20241230-binary;
    rev = "on-20241230-release";
    hash = "sha256-gJUzav2xH8C4Vy5FuqN73Z6lPMSPQgJApF8LgsJXRWo=";
    version = "20241230";
  };
}
