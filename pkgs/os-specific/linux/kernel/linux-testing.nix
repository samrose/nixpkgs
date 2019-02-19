{ stdenv, buildPackages, fetchurl, perl, buildLinux, libelf, utillinux, ... } @ args:

buildLinux (args // rec {
  version = "4.20-rc7";
  modDirVersion = "4.20.0-rc7";
  extraMeta.branch = "4.20";

  src = fetchurl {
    url = "https://git.kernel.org/torvalds/t/linux-${version}.tar.gz";
    sha256 = "0qga2x4rz1vphi7j044f4b4la24qyk5sm7lm8q991imq5wm5s2rl";
  };
  kernelPatches = [{
    patch = ./uart2.patch;
    name = "uart2";
  }];
  extraConfig = ''
      NLS  y
      NLS_DEFAULT  "utf8"
      NLS_UTF8     m
      NLS_CODEPAGE_437 m
      NLS_ISO8859_1    m
      DEVTMPFS y
  '' + (args.extraConfig or "");
  # Should the testing kernels ever be built on Hydra?
  extraMeta.hydraPlatforms = [];

} // (args.argsOverride or {}))
