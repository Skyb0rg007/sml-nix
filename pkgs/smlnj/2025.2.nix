{
  cmake,
  git,
  lib,
  ninja,
  python3,
  stdenv,
  fetchFromGitHub,
  fetchurl,
  autoconf,
  automake,
  ...
}: let
  version = "2025.2";
  targets =
    lib.optional stdenv.targetPlatform.isx86_64 "X86"
    ++ lib.optional stdenv.targetPlatform.isAarch64 "AArch64";
  src = fetchFromGitHub {
    owner = "smlnj";
    repo = "smlnj";
    rev = "v${version}";
    hash = "sha256-TEchaj0YSCK4kCQJNdgvHi83RtCZcRv64RSgYMlpZIY=";
    fetchSubmodules = true;
  };
  bootfile = fetchurl {
    url = "https://smlnj.cs.uchicago.edu/dist/working/2025.2/boot.amd64-unix.tgz";
    hash = "sha256-N4EfJcHrco0aB7bAeXnAZzL7naZaM3yKI/U7iuSoMBs=";
  };
  smlnj-llvm = stdenv.mkDerivation {
    pname = "smlnj-llvm";
    inherit src version;
    sourceRoot = "${src.name}/runtime/llvm18";
    nativeBuildInputs = [
      cmake
      git
      python3
      ninja
    ];
    cmakeFlags = [
      (lib.cmakeFeature "LLVM_TARGETS_TO_BUILD" (lib.concatStringsSep ";" targets))
      (lib.cmakeBool "SMLNJ_CFGC_BUILD" true)
      # (lib.cmakeBool "LLVM_ENABLE_DUMP" true)
      # The checkout doesn't include these files
      (lib.cmakeBool "LLVM_INCLUDE_TESTS" false)
      (lib.cmakeBool "LLVM_INCLUDE_EXAMPLES" false)
      (lib.cmakeBool "LLVM_INCLUDE_BENCHMARKS" false)
      # (lib.cmakeBool "LLVM_INCLUDE_UTILS" false)
      # (lib.cmakeBool "LLVM_INCLUDE_DOCS" false)
      (lib.cmakeBool "LLVM_BUILD_TOOLS" false)
    ];
    buildPhase = ''
    '';
  };
in
  assert targets != [];
  stdenv.mkDerivation {
    pname = "smlnj";
    inherit src version;
    passthru.llvm = smlnj-llvm;
    nativeBuildInputs = [
      cmake
      autoconf
      automake
    ];
    dontUseCmakeConfigure = true;
    patchPhase = ''
      unpackFile ${bootfile}
      sed -i '/^PATH=/d' config/_arch-n-opsys runtime/config/gen-posix-names.sh
      rm -r runtime/llvm18
      mkdir -p runtime/bin runtime/lib
      ln -s ${smlnj-llvm}/bin/llvm-config runtime/bin/llvm-config
      ln -s ${smlnj-llvm}/lib/libCFGCodeGen.a runtime/lib/libCFGCodeGen.a
    '';
    buildPhase = ''
      export INSTALLDIR=$out
      mkdir -pv $out
      ./build.sh
    '';
  }
