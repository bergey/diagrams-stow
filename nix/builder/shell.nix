{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  hs = haskellPackages.override {
        extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        # required, not in Nix
        # newer versions
        lens = hsPkg "lens" "4.6";
        # HEAD packages        
        monoidExtras = self.callPackage ../../../monoid-extras {};
        active = self.callPackage ../../../active {};
        diagramsCore = self.callPackage ../../../core {};
        diagramsLib = self.callPackage ../../../lib {};
        # self
        diagramsBuilder = self.callPackage ./. {};
      };
    };
         in pkgs.lib.overrideDerivation hs.diagramsBuilder (attrs: {
                buildInputs = [hs.cabalInstall ] ++ attrs.buildInputs;
 })
