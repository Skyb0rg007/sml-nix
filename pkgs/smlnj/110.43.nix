{ pkgs, ... }:
pkgs.callPackage ./release.nix {
  version = "110.43";
  bootFile = "boot.x86-unix.tgz";
  platforms = [ "i686-linux" ];
  patches = [
    # ./linux-v6.patch
    # ./sig_setdefault.patch
    ./chk-global-names-returntype.patch
  ];
}
