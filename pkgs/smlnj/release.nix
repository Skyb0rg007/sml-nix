{
  pkgs,
  lib,
  stdenv,
  version,
  fetchurl,
  extraSources ? [ ],
  platforms,
  bootFile,
  patches ? [ ],
  gnumake42,
  ...
}:
let
  baseurl = "https://smlnj.cs.uchicago.edu/dist/working/${version}";
  arch = if stdenv.hostPlatform.is64bit then "64" else "32";
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
stdenv.mkDerivation {
  pname = "smlnj";
  inherit version sources patches;

  buildInputs = [ gnumake42 ];

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
  '';

  prePatch = ''
    sed -i '/^PATH=/d' config/_arch-n-opsys
    if [[ -e base/runtime/config/gen-posix-names.sh ]]; then
      sed -i '/^PATH=/d' base/runtime/config/gen-posix-names.sh
    fi
    echo "SRCARCHIVEURL=file:/$TMP" > config/srcarchiveurl
  '';

  buildPhase = ''
    mkdir -pv $out
    export INSTALLDIR="$out"
    ./config/install.sh -default ${arch}
  '';

  meta = {
    description = "Standard ML of New Jersey";
    homepage = "https://smlnj.org";
    license = lib.licenses.bsd3;
    inherit platforms;
    mainProgram = "sml";
  };
}
