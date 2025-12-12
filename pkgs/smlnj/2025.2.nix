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
      # Required features
      (lib.cmakeBool "SMLNJ_CFGC_BUILD" true)
      (lib.cmakeBool "LLVM_ENABLE_DUMP" true)
      # The checkout doesn't include these files
      (lib.cmakeBool "LLVM_INCLUDE_TESTS" false)
      (lib.cmakeBool "LLVM_INCLUDE_EXAMPLES" false)
      (lib.cmakeBool "LLVM_INCLUDE_BENCHMARKS" false)
      # Not required, but can help avoid compilation
      (lib.cmakeBool "LLVM_ENABLE_LIBXML2" false)
      (lib.cmakeBool "LLVM_ENABLE_OCAMLDOC" false)
      (lib.cmakeBool "LLVM_ENABLE_BINDINGS" false)
      (lib.cmakeBool "LLVM_ENABLE_ZSTD" false)
      (lib.cmakeBool "LLVM_INCLUDE_DOCS" false)
      (lib.cmakeBool "LLVM_INCLUDE_UTILS" false)
      # We need llvm-config
      (lib.cmakeBool "LLVM_BUILD_TOOLS" true)
      # Unnecessary tools
      (lib.cmakeBool "LLVM_TOOL_BUGPOINT_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_BUGPOINT_PASSES_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_DSYMUTIL_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_GOLD_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_AR_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_AS_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_AS_FUZZER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_BCANALYZER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_CAT_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_CFI_VERIFY_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_COV_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_CVTRES_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_CXXDUMP_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_CXXFILT_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_CXXMAP_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_C_TEST_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_DEBUGINFO_ANALYZER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_DEBUGINFOD_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_DEBUGINFOD_FIND_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_DIFF_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_DIS_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_DWARFDUMP_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_DWARFUTIL_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_DWP_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_EXEGESIS_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_EXTRACT_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_GSYMUTIL_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_IFS_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_ISEL_FUZZER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_ITANIUM_DEMANGLE_FUZZER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_JITLINK_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_JITLISTENER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_LINK_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_LIPO_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_LTO2_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_LTO_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_MCA_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_MC_ASSEMBLE_FUZZER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_MC_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_MC_DISASSEMBLE_FUZZER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_MICROSOFT_DEMANGLE_FUZZER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_ML_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_MODEXTRACT_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_MT_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_NM_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_OBJCOPY_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_OBJDUMP_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_OPT_FUZZER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_OPT_REPORT_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_PDBUTIL_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_PROFDATA_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_PROFGEN_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_RC_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_READOBJ_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_READTAPI_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_REDUCE_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_REMARKUTIL_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_RTDYLD_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_SHLIB_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_SIM_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_SIZE_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_SPECIAL_CASE_LIST_FUZZER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_SPLIT_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_STRESS_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_STRINGS_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_SYMBOLIZER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_TLI_CHECKER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_UNDNAME_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LLVM_XRAY_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_LTO_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_OBJ2YAML_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_OPT_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_OPT_VIEWER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_REMARKS_SHLIB_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_SANCOV_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_SANSTATS_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_VERIFY_USELISTORDER_BUILD" false)
      (lib.cmakeBool "LLVM_TOOL_VFABI_DEMANGLE_FUZZER_BUILD" false)
    ];
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
