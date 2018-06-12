# This module defines a small NixOS installation CD.  It does not
# contain any graphical stuff.
{config, pkgs, ...}:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];
  environment.systemPackages = [ pkgs.rustc 
				 pkgs.cargo
                                 pkgs.binutils 
		                 pkgs.gcc 
                                 pkgs.gnumake 
                                 pkgs.openssl 
                                 pkgs.pkgconfig
                                 pkgs.git
                                 pkgs.carnix
			       ];
}
