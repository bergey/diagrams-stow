{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  hs = haskellPackages.override {
        extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        # required, not in Nix
        # newer than Nix
        # HEAD packages
        # monoidExtras = self.callPackage ../../../monoid-extras {};
        active = self.callPackage ../../../active {};
        diagramsCore= self.callPackage ../../../core {};
        diagramsLib= self.callPackage ../../../lib {};
        # self
        diagramsSvg = self.callPackage ./. {};
      };
    };
        in pkgs.lib.overrideDerivation hs.diagramsSvg (attrs: {
       buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })
