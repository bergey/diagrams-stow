{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  tmpHaskellPkgs= haskellPackages.override {
        extension = self: super: {
        # required, not in Nix
        fsnotify = self.callPackage /home/bergey/code/nixHaskellVersioned/fsnotify/0.1.0.3.nix {};
        optparseApplicative = self.callPackage /home/bergey/code/nixHaskellVersioned/optparse-applicative/0.10.0 {};
        # HEAD packages
        monoidExtras = self.callPackage ../../../monoid-extras {};
        active = self.callPackage ../../../active {};
        diagramsCore = self.callPackage ../../../core {};
        diagramsLib = self.callPackage ../../../lib {};
        svgFonts = self.callPackage ./. {};
      };
    };
  in let
     haskellPackages = tmpHaskellPkgs;
     in pkgs.lib.overrideDerivation haskellPackages.svgFonts (attrs: {
       buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })
