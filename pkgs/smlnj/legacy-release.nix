{
  pkgs,
  lib,
  stdenv,
  version,
  fetchurl,
  patches ? [ ],
  gnumake42,
  libfaketime,
  diffoscope,
  ...
}:
let
  baseurl = "https://smlnj.cs.uchicago.edu/dist/working/${version}";
  arch = if stdenv.hostPlatform.is64bit then "64" else "32";
  bootFile =
    if stdenv.hostPlatform.isUnix && stdenv.hostPlatform.isPower then
      "boot.ppc-unix.tgz"
    else if stdenv.hostPlatform.isUnix && stdenv.hostPlatform.isSparc then
      "boot.sparc-unix.tgz"
    else if stdenv.hostPlatform.isUnix && stdenv.hostPlatform.isx86_64 then
      "boot.amd64-unix.tgz"
    else if stdenv.hostPlatform.isUnix && stdenv.hostPlatform.isx86_32 then
      "boot.x86-unix.tgz"
    else if stdenv.hostPlatform.isWindows && stdenv.hostPlatform.isx86 then
      "boot.x86-win32.tgz"
    else
      throw "Unsupported host platform: ${stdenv.hostPlatform.config}";
  hashes = builtins.fromJSON (builtins.readFile ./hashes.json);
  fetchSource =
    name:
    fetchurl {
      url = "${baseurl}/${name}";
      hash = hashes.${version}.${name};
    };

  sources = map fetchSource (
    [ bootFile ]
    ++ builtins.filter (name: !lib.strings.hasPrefix "boot" name) (lib.attrNames hashes.${version})
  );
in
stdenv.mkDerivation (finalAttrs: {
  pname = "smlnj";
  inherit version sources patches;

  nativeBuildInputs = [
    gnumake42 # TODO: Determine which version needs this
    libfaketime
  ];

  outputs = [ "out" "doc" ];

  doCheck = true;

  unpackPhase = ''
    for s in $sources; do
      b="$(basename "$s")"
      cp "$s" "''${b#*-}"
    done
    unpackFile config.tgz
    mkdir base
    if [[ -e ./config/unpack ]]; then
      bash -x ./config/unpack $TMP runtime
    else
      unpackFile runtime.tgz
    fi
    ${lib.optionalString (version != "110.89") ''
      unpackFile doc.tgz
    ''}
    ${
      # This version mispackaged the doc.tgz file
      lib.optionalString (version == "110.89") ''
        tar --strip-components=1 -xf doc.tgz doc/doc
      ''
    }
  '';

  prePatch = ''
    sed -i '/^PATH=/d' config/_arch-n-opsys
    if [[ -e base/runtime/config/gen-posix-names.sh ]]; then
      sed -i '/^PATH=/d' base/runtime/config/gen-posix-names.sh
    fi
    echo "SRCARCHIVEURL=file:/$TMP" > config/srcarchiveurl
  '';

  buildPhase = ''
    ${lib.optionalString (lib.versionOlder version "110.99.2") ''
      PATH="$PATH:''${!outputBin}/bin"
    ''}
    mkdir -pv ''${!outputBin}
    export INSTALLDIR="''${!outputBin}"
    t="$(TZ=UTC date -d "@$SOURCE_DATE_EPOCH" +'%Y-%m-%d %H:%M:%S')"
    faketime -f "$t" ./config/install.sh -default ${arch}

    mkdir -pv ''${!outputDoc}/share/doc/smlnj ''${!outputMan}/share
    cp -rv doc/man ''${!outputMan}/share
    cp -rv doc/pdf doc/html ''${!outputDoc}/share/doc/smlnj
  '';

  checkPhase = ''
    runHook preCheck

    echo "Check that the compiler runs"
    ID=a228a0bf2c3d4198a5f55c5ba489566c
    $out/bin/sml <<EOF | grep -q "$ID"
    CM.make "\$/smlnj-lib.cm";
    TextIO.print "$ID\n";
    EOF

    runHook postCheck
  '';

  passthru.tests = {
    version = testers.testVersion {
      package = finalAttrs.finalPackage;
      command = "sml";
    };
    exportml = (
      pkgs.writeShellApplication {
        name = "exportml-test";
        runtimeInputs = [libfaketime finalAttrs.finalPackage diffoscope];
        text = let 
          file = pkgs.writeText "test.sml" ''
            val () =
              if SMLofNJ.exportML "t"
              then (TextIO.print "Hello, World!\n"; OS.Process.exit OS.Process.success)
              else (TextIO.print "Exported!\n"; OS.Process.exit OS.Process.success)
          '';
        in ''
          out=_output
          mkdir -p $out
          cd $out || exit
          t="$(TZ=UTC date -d "@0" +'%Y-%m-%d %H:%M:%S')"
          for i in $(seq 5); do
            echo "======================"
            faketime -f "$t" ${lib.getExe finalAttrs.finalPackage} @SMLgcmessages ${file}
            mv t.* "t$i"
          done
          for i in $(seq 4); do
            diffoscope "t$i" "t$((i+1))" --html "diff$i$((i+1)).html" || true
          done
      '';
    });
  };

  meta = {
    description = "Standard ML of New Jersey";
    homepage = "https://smlnj.org";
    changelog =
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
})
