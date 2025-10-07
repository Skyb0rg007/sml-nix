{
  stdenv,
  smlnj-110_99_8,
  gnumake42,
  fetchFromGitHub,
  lib,
  ...
}: let
  platforms = ["x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-darwin"];
  arch = if stdenv.hostPlatform.is64bit then "64" else "32";
  version = "110.99.9-alpha+1e19a08";
  src =
    fetchFromGitHub {
      owner = "smlnj";
      repo = "legacy";
      rev = "1e19a08901738425e24e373b24813a264e93d3b0";
      hash = "sha256-bbr0qBCV6jkNdowLhV5AASFBplWWsMiFiqxXxEaQobc=";
    };
  bootFile = stdenv.mkDerivation {
    pname = "smlnj-bootfile";
    inherit version src;
    buildInputs = [smlnj-110_99_8];
    patchPhase = ''
      sed -i '/^PATH=/d' config/_arch-n-opsys base/runtime/config/gen-posix-names.sh
    '';
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
      ls -l
      cp -v boot.amd64-unix.tgz $out
    '';
  };
in
  stdenv.mkDerivation {
    pname = "smlnj";
    inherit version src;
    buildInputs = [gnumake42];
    passthru.bootFile = bootFile;
    postUnpack = ''
      ln -s ${bootFile} source/boot.amd64-unix.tgz
      (cd source && bash -x ./config/unpack $PWD boot.amd64-unix)
    '';
    patchPhase = ''
      sed -i '/^PATH=/d' config/_arch-n-opsys base/runtime/config/gen-posix-names.sh
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
      inherit platforms;
      mainProgram = "sml";
    };
  }
