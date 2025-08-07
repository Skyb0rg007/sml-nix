{pkgs, stdenv, ...}:
pkgs.callPackage ./release.nix {
  version = "110.99.7";
  bootFile =
    if stdenv.hostPlatform.is64bit
    then "boot.amd64-unix.tgz"
    else "boot.x86-unix.tgz";
  platforms = ["x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-darwin"];
}
