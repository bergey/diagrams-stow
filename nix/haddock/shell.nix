{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  hs = haskellPackages.override {
        extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        # required, not in Nix
        # newer than in Nixpkgs
        lens = hsPkg "lens" "4.7";
        vectorSpace = hsPkg "vector-space" "0.9";
        # HEAD packages
        vectorSpacePoints = self.callPackage ../../../vector-space-points {};
        diagramsCore = self.callPackage ../../../core {};
        diagramsLib = self.callPackage ../../../lib {};
        diagramsCairo = self.callPackage ../../../cairo {};
        diagramsPostscript = self.callPackage ../../../postscript {};
        diagramsSvg = self.callPackage ../../../svg {};
        diagramsBuilder = self.callPackage ../../../builder {};
        # self
        diagramsHaddock= self.callPackage ./. {};
      };
    };
         in pkgs.lib.overrideDerivation hs.diagramsHaddock (attrs: {
                buildInputs = [hs.cabalInstall ] ++ attrs.buildInputs;
 })
