#!/usr/bin/env bash

declare -a files=(
    "boot.amd64-unix.tgz"
    "boot.x86-unix.tgz"
    "config.tgz"
    "cm.tgz"
    "compiler.tgz"
    "runtime.tgz"
    "system.tgz"
    "MLRISC.tgz"
    "smlnj-lib.tgz"
    "old-basis.tgz"
    "ckit.tgz"
    "nlffi.tgz"
    "cml.tgz"
    "eXene.tgz"
    "ml-lpt.tgz"
    "ml-lex.tgz"
    "ml-yacc.tgz"
    "ml-burg.tgz"
    "pgraph.tgz"
    "trace-debug-profile.tgz"
    "heap2asm.tgz"
    "smlnj-c.tgz"
    "doc.tgz"
    "asdl.tgz"
)

base=https://smlnj.cs.uchicago.edu/dist/working
vsn="$1"

printf '  "%s": {' "$vsn"
sep=""
for name in "${files[@]}"; do
    printf '%s\n    "%s": "%s"' "$sep" "$name" "$(nix store prefetch-file "$base/$vsn/$name" --json | jq -r .hash)"
    sep=","
done
printf '\n  }\n'
