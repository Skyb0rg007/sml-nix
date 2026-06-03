# TODO:
# - Darwin support
# - cross-compilation support
# - Windows support
# - support static build
# - choose binary download based on stdenv libc version
{
  lib,
  fetchurl,
  gmp,
  patchelf,
  stdenv,
}:
let
  pname = "mlton";
  version = "20241230";
  hashes = builtins.fromJSON (builtins.readFile ./hashes.json);

  arch = if stdenv.hostPlatform.isx86_64 then "amd64-linux" else throw "NYI";

  variant = if stdenv.hostPlatform.isLinux then "ubuntu-24.04_glibc2.39" else throw "NYI";

  src = fetchurl {
    url = "https://github.com/MLton/mlton/releases/download/on-${version}-release/mlton-${version}-1.${arch}.${variant}.tgz";
    hash = hashes.${version}.${arch}.${variant};
  };
in
assert stdenv.hostPlatform == stdenv.targetPlatform;
stdenv.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = lib.optional stdenv.hostPlatform.isLinux [ patchelf ];
  buildInputs = [ gmp ];
  strictDeps = true;

  buildPhase = ''
    make update \
      CC="${lib.getExe stdenv.cc}" \
      WITH_GMP_INC_DIR="${gmp.dev}/include" \
      WITH_GMP_LIB_DIR="${gmp}/lib"
  '';

  installPhase = ''
    make install PREFIX=$out
  '';

  postFixup = lib.optionalString stdenv.hostPlatform.isLinux ''
    for f in $out/lib/mlton/mlton-compile $out/bin/{mllex,mlnlffigen,mlprof,mlyacc}; do
      patchelf --set-interpreter ${stdenv.cc.bintools.dynamicLinker} $f
      patchelf --set-rpath ${gmp}/lib $f
    done
  '';

  meta = {
    description = "Open-source, whole-program, optimizing Standard ML compiler";
    homepage = "http://mlton.org";
    licenses = lib.licenses.smlnj;
    mainProgram = "mlton";
    maintainers = [ lib.maintainers.skyesoss ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
