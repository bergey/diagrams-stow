{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  tmpHaskellPkgs= haskellPackages.override {
        extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        # required, not in Nix
        # newer than in Nix
        lens = hsPkg "lens" "4.7";
        vectorSpace = hsPkg "vector-space" "0.9";
        # HEAD packages        
        vectorSpacePoints = self.callPackage ../../../vector-space-points {};
        diagramsCore = self.callPackage ../../../core {};
        diagramsLib = self.callPackage ../../../lib {};
        diagramsCairo = self.callPackage ../../../cairo {};
        diagramsPostscript = self.callPackage ../../../postscript {};
        diagramsSvg = self.callPackage ../../../svg {};
        # self
        diagramsBuilder = self.callPackage ./. {};
      };
    };
  in let
     haskellPackages = tmpHaskellPkgs;
     in pkgs.lib.overrideDerivation haskellPackages.diagramsBuilder (attrs: {
       buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })
