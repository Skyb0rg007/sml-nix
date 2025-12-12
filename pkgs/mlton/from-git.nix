{
  lib,
  bootstrap,
  fetchFromGitHub,
  version,
  rev,
  hash,
  stdenv,
  gmp,
}:
stdenv.mkDerivation {
  pname = "mlton";
  inherit version;

  src = fetchFromGitHub {
    owner = "mlton";
    repo = "mlton";
    inherit rev hash;
  };

  nativeBuildInputs = [bootstrap];
  buildInputs = [gmp];
  strictDeps = true;

  doCheck = true;

  preBuild = ''
    find . -type f -exec \
      sed -i "s@/usr/bin/env bash@$(command -v bash)@" {} +
    sed -i "s@/tmp@$TMPDIR@" bin/*

    makeFlagsArray=(
      PREFIX="$out"
      MLTON_VERSION="${version} ${rev}"
      CC="${lib.getExe stdenv.cc}"
      WITH_GMP_INC_DIR="${gmp.dev}/include"
      WITH_GMP_LIB_DIR="${gmp}/lib"
    )
  '';

  meta = {
    homepage = "http://mlton.org";
    license = lib.licenses.smlnj;
  };
}
