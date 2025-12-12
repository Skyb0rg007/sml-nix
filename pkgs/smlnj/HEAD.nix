{
  stdenv,
  smlnj-110_99_8,
  fetchFromGitHub,
  lib,
  ...
}: let
  arch =
    if stdenv.hostPlatform.is64bit
    then "64"
    else "32";
  version = "110.99.9-alpha+e29054f";
  src = fetchFromGitHub {
    owner = "smlnj";
    repo = "legacy";
    rev = "e29054f5a1892ab52401d4fee2201ec78cace53f";
    hash = "sha256-okxzWk6QwawY/0rBy+e679OBnkPxCyF0Scf/3PxjLoU=";
  };
  bootFile = stdenv.mkDerivation {
    pname = "smlnj-bootfile";
    inherit version src;
    buildInputs = [smlnj-110_99_8];
    buildPhase = ''
      sed -ni '/^# boot the base SML system/q;p' config/install.sh
      ./config/install.sh

      cd base/system
      sed -i 's:^SML=.*:SML=sml:' fixpt
      ./fixpt
      ./makeml
      ./installml -boot
      cd ../..
    '';
    installPhase = ''
      cp -v boot.amd64-unix.tgz $out
    '';
  };
in
  stdenv.mkDerivation {
    pname = "smlnj";
    inherit version src;
    passthru.bootFile = bootFile;
    postUnpack = ''
      ln -s ${bootFile} source/boot.amd64-unix.tgz
      (cd source && bash -x ./config/unpack $PWD boot.amd64-unix)
    '';
    buildPhase = ''
      ./config/install.sh -default ${arch}
    '';
    installPhase = ''
      mkdir -pv $out
      cp -rv bin lib $out

      for f in $out/bin/*; do
        sed -i "2iSMLNJ_HOME=$out/" "$f"
      done
    '';

    meta = {
      description = "Standard ML of New Jersey";
      homepage = "https://smlnj.org";
      license = lib.licenses.bsd3;
      platforms = ["x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-darwin"];
      mainProgram = "sml";
    };
  }
