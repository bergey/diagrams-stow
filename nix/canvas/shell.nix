{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  tmpHaskellPkgs= haskellPackages.override {
        extension = self: super: {
        # required, not in Nix
        fsnotify = self.callPackage /home/bergey/code/nixHaskellVersioned/fsnotify/0.1.0.3.nix {};
        optparseApplicative = self.callPackage /home/bergey/code/nixHaskellVersioned/optparse-applicative/0.10.0 {};
        blankCanvas = self.callPackage /home/bergey/code/nixHaskellVersioned/blank-canvas/0.5.nix {};
        kansasComet= self.callPackage /home/bergey/code/nixHaskellVersioned/kansas-comet/0.3.1.nix {};
        # HEAD packages
        monoidExtras = self.callPackage ../../../monoid-extras {};
        active = self.callPackage ../../../active {};
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
