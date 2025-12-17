{
  pkgs ? import <nixpkgs> { },
}:
rec {
  smlnj-2025_3_rc1 = pkgs.callPackage ./release.nix {
    version = "2025.3-rc1";
  };
  smlnj-2025_2 = pkgs.callPackage ./release.nix {
    version = "2025.2";
  };
  # smlnj-2025_1 = pkgs.callPackage ./release.nix {
  #   version = "2025.1";
  # };

  smlnj-HEAD = pkgs.callPackage ./legacy-git.nix {
    version = "110.99.10-f210dfe";
    rev = "f210dfea76f162f7918a6c607658eee9d3469843";
    hash = "sha256-iKtJF4Dfyr8WW494wQWET2JLdLIRbAG6jwA8xNcYAn4=";
    bootstrapSmlnj = smlnj-110_99_9;
  };

  smlnj-110_99_9 = pkgs.callPackage ./legacy-release.nix {
    version = "110.99.9";
  };
  smlnj-110_99_8 = pkgs.callPackage ./legacy-release.nix {
    version = "110.99.8";
  };
  smlnj-110_99_7_1 = pkgs.callPackage ./legacy-release.nix {
    version = "110.99.7.1";
  };
  smlnj-110_99_7 = pkgs.callPackage ./legacy-release.nix {
    version = "110.99.7";
  };
  smlnj-110_99_6_1 = pkgs.callPackage ./legacy-release.nix {
    version = "110.99.6.1";
  };
  smlnj-110_99_6 = pkgs.callPackage ./legacy-release.nix {
    version = "110.99.6";
  };
  smlnj-110_99_5 = pkgs.callPackage ./legacy-release.nix {
    version = "110.99.5";
  };
  smlnj-110_99_4 = pkgs.callPackage ./legacy-release.nix {
    version = "110.99.4";
    patches = [
      ./sig_setdefault.patch
    ];
  };
  smlnj-110_99_3 = pkgs.callPackage ./legacy-release.nix {
    version = "110.99.3";
    patches = [
      ./sig_setdefault.patch
    ];
  };
  smlnj-110_99_2 = pkgs.callPackage ./legacy-release.nix {
    version = "110.99.2";
    patches = [
      ./sig_setdefault.patch
    ];
  };
  smlnj-110_99_1 = pkgs.callPackage ./legacy-release.nix {
    version = "110.99.1";
    patches = [
      ./sig_setdefault.patch
    ];
  };
  smlnj-110_99 = pkgs.callPackage ./legacy-release.nix {
    version = "110.99";
    patches = [
      ./sig_setdefault.patch
    ];
  };
  smlnj-110_98_1 = pkgs.callPackage ./legacy-release.nix {
    version = "110.98.1";
    patches = [
      ./sig_setdefault.patch
    ];
  };
  smlnj-110_98 = pkgs.callPackage ./legacy-release.nix {
    version = "110.98";
    patches = [
      ./sig_setdefault.patch
    ];
  };
  smlnj-110_97 = pkgs.callPackage ./legacy-release.nix {
    version = "110.97";
    patches = [
      ./sig_setdefault.patch
    ];
  };
  smlnj-110_96 = pkgs.callPackage ./legacy-release.nix {
    version = "110.96";
    patches = [
      ./sig_setdefault.patch
    ];
  };
  smlnj-110_95 = pkgs.callPackage ./legacy-release.nix {
    version = "110.95";
    patches = [
      ./sig_setdefault.patch
    ];
  };
  smlnj-110_94 = pkgs.callPackage ./legacy-release.nix {
    version = "110.94";
    patches = [
      ./sig_setdefault.patch
    ];
  };
  smlnj-110_93 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.93";
    patches = [
      ./sig_setdefault.patch
      ./linux-v6.patch
    ];
  };
  smlnj-110_92 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.92";
    patches = [
      ./sig_setdefault.patch
      ./linux-v6.patch
    ];
  };
  smlnj-110_91 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.91";
    patches = [
      ./sig_setdefault.patch
      ./linux-v6.patch
    ];
  };
  # XXX: Uncaught exception CFunNotFound SMLNJ-RunT.itick
  # smlnj-110_90 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
  #   version = "110.90";
  #   patches = [
  #     ./sig_setdefault.patch
  #     ./linux-v6.patch
  #   ];
  # };
  smlnj-110_89 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.89";
    patches = [
      ./sig_setdefault.patch
      ./linux-v6.patch
    ];
  };
  smlnj-110_88 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.88";
    patches = [
      ./sig_setdefault.patch
      ./linux-v6.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_87 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.87";
    patches = [
      ./sig_setdefault.patch
      ./linux-v6.patch
      ./chk-global-names-returntype.patch
    ];
  };
  # SML/NJ 110.86 doesn't exist
  smlnj-110_85 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.85";
    patches = [
      ./sig_setdefault.patch
      ./linux-v6.patch
      ./chk-global-names-returntype.patch
    ];
  };
  # smlnj-110_45 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
  #   version = "110.45";
  #   patches = [
  #     ./chk-global-names-returntype.patch
  #   ];
  # };
  # smlnj-110_44 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
  #   version = "110.44";
  #   patches = [
  #     ./chk-global-names-returntype.patch
  #   ];
  # };
  # smlnj-110_43 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
  #   version = "110.43";
  #   patches = [
  #     ./chk-global-names-returntype.patch
  #   ];
  # };
  # smlnj-110_42 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
  #   version = "110.42";
  #   patches = [
  #     ./chk-global-names-returntype.patch
  #   ];
  # };
}
