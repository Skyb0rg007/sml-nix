{
  pkgs ? import <nixpkgs> { },
}:
rec {
  smlnj-all = pkgs.writeText "smlnj-all.txt" ''
    ${smlnj-2026_1}
    ${smlnj-2025_3}
    ${smlnj-2025_2}
    ${smlnj-110_99_9}
    ${smlnj-110_99_8}
    ${smlnj-110_99_7_1}
    ${smlnj-110_99_7}
    ${smlnj-110_99_6_1}
    ${smlnj-110_99_6}
    ${smlnj-110_99_5}
    ${smlnj-110_99_4}
    ${smlnj-110_99_3}
    ${smlnj-110_99_2}
    ${smlnj-110_99_1}
    ${smlnj-110_99}
    ${smlnj-110_98_1}
    ${smlnj-110_98}
    ${smlnj-110_97}
    ${smlnj-110_96}
    ${smlnj-110_95}
    ${smlnj-110_94}
    ${smlnj-110_93}
    ${smlnj-110_92}
    ${smlnj-110_91}
    ${smlnj-110_89}
    ${smlnj-110_88}
    ${smlnj-110_87}
    ${smlnj-110_85}
    ${smlnj-110_84}
    ${smlnj-110_83}
    ${smlnj-110_82}
    ${smlnj-110_81}
    ${smlnj-110_80}
    ${smlnj-110_79}
    ${smlnj-110_78}
    ${smlnj-110_77}
    ${smlnj-110_76}
    ${smlnj-110_75}
    ${smlnj-110_74}
    ${smlnj-110_73}
    ${smlnj-110_72}
    ${smlnj-110_71}
    ${smlnj-110_70}
    ${smlnj-110_69}
    ${smlnj-110_68}
    ${smlnj-110_67}
    ${smlnj-110_66}
    ${smlnj-110_65}
    ${smlnj-110_64}
    ${smlnj-110_63}
    ${smlnj-110_62}
    ${smlnj-110_61}
  '';

  smlnj-2026_1 = pkgs.callPackage ./release.nix {
    version = "2026.1";
    llvmVersion = "21";
  };
  smlnj-2025_3 = pkgs.callPackage ./release.nix {
    version = "2025.3";
    llvmVersion = "18";
  };
  smlnj-2025_2 = pkgs.callPackage ./release.nix {
    version = "2025.2";
    llvmVersion = "18";
    stdenv = pkgs.gcc14Stdenv;
  };
  # smlnj-2025_1 = pkgs.callPackage ./release.nix {
  #   version = "2025.1";
  #   stdenv = pkgs.gcc14Stdenv;
  # };

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
  smlnj-110_84 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.84";
    patches = [
      ./sig_setdefault.patch
      ./linux-v6.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_83 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.83";
    patches = [
      ./sig_setdefault.patch
      ./linux-v56.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_82 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.82";
    patches = [
      ./sig_setdefault.patch
      ./linux-v56.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_81 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.81";
    patches = [
      ./sig_setdefault.patch
      ./linux-v56.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_80 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.80";
    patches = [
      ./sig_setdefault.patch
      ./linux-v56.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_79 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.79";
    patches = [
      ./sig_setdefault.patch
      ./linux-v56.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_78 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.78";
    patches = [
      ./sig_setdefault.patch
      ./linux-v456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_77 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.77";
    patches = [
      ./sig_setdefault.patch
      ./linux-v456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_76 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.76";
    patches = [
      ./sig_setdefault.patch
      ./linux-v456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_75 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.75";
    patches = [
      ./sig_setdefault.patch
      ./linux-v456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_74 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.74";
    patches = [
      ./sig_setdefault.patch
      ./linux-v456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_73 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.73";
    patches = [
      ./sig_setdefault.patch
      ./linux-v3456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_72 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.72";
    patches = [
      ./sig_setdefault.patch
      ./linux-v3456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_71 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.71";
    patches = [
      ./sig_setdefault.patch
      ./linux-v3456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_70 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.70";
    patches = [
      ./sig_setdefault.patch
      ./linux-v3456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_69 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.69";
    patches = [
      ./sig_setdefault.patch
      ./linux-v3456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_68 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.68";
    patches = [
      ./sig_setdefault.patch
      ./linux-v3456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_67 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.67";
    patches = [
      ./sig_setdefault.patch
      ./linux-v3456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_66 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.66";
    patches = [
      ./sig_setdefault.patch
      ./linux-v3456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_65 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.65";
    patches = [
      ./sig_setdefault.patch
      ./linux-v3456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_64 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.64";
    patches = [
      ./sig_setdefault.patch
      ./linux-v3456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_63 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.63";
    patches = [
      ./sig_setdefault.patch
      ./linux-v3456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_62 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.62";
    patches = [
      ./sig_setdefault.patch
      ./linux-v3456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  smlnj-110_61 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
    version = "110.61";
    patches = [
      ./sig_setdefault.patch
      ./linux-v3456.patch
      ./chk-global-names-returntype.patch
    ];
  };
  # lexgen archive missing
  # smlnj-110_60 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
  #   version = "110.60";
  #   patches = [
  #     ./sig_setdefault.patch
  #     ./linux-v3456.patch
  #     ./chk-global-names-returntype.patch
  #   ];
  # };

  # Error while unpacking
  # smlnj-110_59 = pkgs.pkgsi686Linux.callPackage ./legacy-release.nix {
  #   version = "110.59";
  #   patches = [
  #     ./sig_setdefault.patch
  #     ./linux-v3456.patch
  #     ./chk-global-names-returntype.patch
  #   ];
  # };

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
