{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  hs = haskellPackages.override {
        extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        # required, not in Nix
        fsnotify = hsPkg "fsnotify" "0.1.0.3";
        optparseApplicative = hsPkg "optparse-applicative" "0.11.0.1";
        # newer than Nix
        lens = hsPkg "lens" "4.6";
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
