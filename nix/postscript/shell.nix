{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  tmpHaskellPkgs= haskellPackages.override {
        extension = self: super: {
        # system under test
        # newer than nixpkgs, not needed
        # newer than Nix, needed
        fsnotify = self.callPackage ../nix-updates/fsnotify/0.1.0.3.nix {};
        optparseApplicative = self.callPackage ../nix-updates/optparse-applicative/0.10.0 {};
        preludeExtras = self.preludeExtras.override {}
        # local copies
        diagramsCore= self.callPackage ../../../core {};
        diagramsLib = self.callPackage ../../../lib {};
        diagramsPostscript = self.callPackage ./. {};
      };
    };
 in let
 haskellPackages = tmpHaskellPkgs;
in pkgs.lib.overrideDerivation haskellPackages.diagramsPostscript (attrs: {
   buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })