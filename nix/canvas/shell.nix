{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  tmpHaskellPkgs= haskellPackages.override {
    extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        # required, not in Nix
        fsnotify = hsPkg "fsnotify" "0.1.0.3";
        optparseApplicative = hsPkg "optparse-applicative" "0.11.0.1";
        blankCanvas = self.callPackage /home/bergey/code/nixHaskellVersioned/blank-canvas/0.5.nix {};
        kansasComet= self.callPackage /home/bergey/code/nixHaskellVersioned/kansas-comet/0.3.1.nix {};
        # newer than Nix
        lens = hsPkg "lens" "4.6"; 
        tasty = hsPkg "tasty" "0.10.1";
        # HEAD packages
        # monoidExtras = self.callPackage ../../../monoid-extras {};
        # active = self.callPackage ../../../active {};
        diagramsCore = self.callPackage ../../../core {};
        diagramsLib = self.callPackage ../../../lib {};
        # self
        diagramsCanvas = self.callPackage ./. {};
      };
    };
  in let
     haskellPackages = tmpHaskellPkgs;
     in pkgs.lib.overrideDerivation haskellPackages.diagramsCanvas (attrs: {
       buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })
