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

  fetchsrc =
    {
      hash,
      arch,
      os,
      variant,
    }:
    fetchurl {
      url = "https://github.com/MLton/mlton/releases/download/on-${version}-release/mlton-${version}-1.${arch}.${os}_${variant}.tgz";
      inherit hash;
    };

  src-amd64-focal-glibc2_31 = fetchsrc {
    arch = "amd64-linux";
    os = "ubuntu-20.04";
    variant = "glibc2.31";
    hash = "sha256-eFHJLilrT4STtHv5jIE1jrsjWrU+czI9wAtL2VWvV1I=";
  };
  src-amd64-jammy-glibc2_35 = fetchsrc {
    arch = "amd64-linux";
    os = "ubuntu-22.04";
    variant = "glibc2.35";
    hash = "sha256-E6wVRxC1eTbFUKdnCw6W2g+vU2XQM9CcGaXDyQfxKiU=";
  };
  src-amd64-noble-glibc2_39 = fetchsrc {
    arch = "amd64-linux";
    os = "ubuntu-24.04";
    variant = "glibc2.39";
    hash = "sha256-ldXnjHcWGu77LP9WL6vTC6FngzhxPFAUflAA+bpIFZM=";
  };
  src-amd64-focal-static = fetchsrc {
    arch = "amd64-linux";
    os = "ubuntu-20.04";
    variant = "static";
    hash = "sha256-3ifxO+Dl2EU5RnWYC89TTJWGZSHEMXt3qUCAXUGamPI=";
  };
  src-amd64-jammy-static = fetchsrc {
    arch = "amd64-linux";
    os = "ubuntu-22.04";
    variant = "static";
    hash = "sha256-as0hDM3viqCRDGQXqkj7BRsz3qP4U6xWmt3RQxwu/U8=";
  };
  src-amd64-noble-static = fetchsrc {
    arch = "amd64-linux";
    os = "ubuntu-24.04";
    variant = "static";
    hash = "sha256-dhcnfy0Mq6iA31cvarfxHfMRBDnCpNq53Rui4efNTOY=";
  };
in
stdenv.mkDerivation {
  inherit pname version;
  passthru = {
    inherit src-amd64-focal-glibc2_31;
    inherit src-amd64-focal-static;
    inherit src-amd64-jammy-glibc2_35;
    inherit src-amd64-jammy-static;
    inherit src-amd64-noble-glibc2_39;
    inherit src-amd64-noble-static;
  };

  src =
    if stdenv.hostPlatform.system == "x86_64-linux" then
      src-amd64-noble-glibc2_39
    else
      throw "Unsupported platform";

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
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
