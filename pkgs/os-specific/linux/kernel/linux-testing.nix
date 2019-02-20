{ stdenv, buildPackages, fetchurl, perl, buildLinux, libelf, utillinux, ... } @ args:

buildLinux (args // rec {
  version = "4.19-rc1";
  modDirVersion = "4.19.0-rc1";
  extraMeta.branch = "4.19";

  src = fetchurl {
    url = "https://git.kernel.org/torvalds/t/linux-${version}.tar.gz";
    sha256 = "14c9xg9sv0jrdri36das97vdbybi7vmcy59mj9wmgaz81cdk3wg5";
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
