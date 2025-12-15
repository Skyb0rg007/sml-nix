{
  stdenv,
  fetchFromGitHub,
  lib,
  bootstrapSmlnj,
  rev,
  hash,
  version,
  ...
}:
let
  arch = if stdenv.hostPlatform.is64bit then "64" else "32";
  inherit version;
  src = fetchFromGitHub {
    owner = "smlnj";
    repo = "legacy";
    inherit rev hash;
  };
  bootFileName = if stdenv.hostPlatform.isx86_64 then "boot.amd64-unix.tgz" else throw "nyi";
  bootFile = stdenv.mkDerivation {
    pname = "smlnj-bootfile";
    inherit version src;
    nativeBuildInputs = [ bootstrapSmlnj ];
    buildPhase = ''
      sed -ni '/^# boot the base SML system/q;p' config/install.sh
      ./config/install.sh -default ${arch}

      pushd base/system
        sed -i 's:^SML=.*:SML=sml:' fixpt
        ./fixpt
        ./makeml
        ./installml -boot
      popd
    '';
    installPhase = ''
      cp -v ${bootFileName} $out
    '';
  };
in
stdenv.mkDerivation {
  pname = "smlnj";
  inherit version src;
  passthru.bootFile = bootFile;
  postUnpack = ''
    ln -s ${bootFile} source/boot.amd64-unix.tgz
    pushd source || exit
      bash -x ./config/unpack $PWD boot.amd64-unix
    popd
  '';
  buildPhase = ''
    mkdir -pv "''${!outputBin}"
    export INSTALLDIR="''${!outputBin}"
    ./config/install.sh -default ${arch}
  '';

  meta = {
    description = "Standard ML of New Jersey";
    homepage = "https://smlnj.org";
    changelog =
      let
        baseurl = "https://smlnj.cs.uchicago.edu/dist/working/${version}";
      in
      if lib.versionAtLeast version "110.78" then
        "${baseurl}/HISTORY.html"
      else if lib.versionAtLeast version "110.60" then
        "${baseurl}/NOTES/HISTORY"
      else
        "${baseurl}/HISTORY";
    license = lib.licenses.smlnj;
    platforms =
      lib.lists.intersectLists lib.platforms.unix lib.platforms.x86
      ++ lib.lists.intersectLists lib.platforms.unix lib.platforms.power
      ++ lib.platforms.darwin
      ++ [ "i686-windows" ];
    mainProgram = "sml";
  };
}
