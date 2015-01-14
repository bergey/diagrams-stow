{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  tmpHaskellPkgs= haskellPackages.override {
    extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        # required, not in Nix
        blankCanvas = self.callPackage /home/bergey/code/nixHaskellVersioned/blank-canvas/0.5.nix {};
        kansasComet= self.callPackage /home/bergey/code/nixHaskellVersioned/kansas-comet/0.3.1.nix {};
        # newer than Nix
        lens = hsPkg "lens" "4.7";
        vectorSpace = hsPkg "vector-space" "0.9";
        # HEAD packages
        vectorSpacePoints = self.callPackage ../../../vector-space-points {};
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
