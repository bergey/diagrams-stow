{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  hs = haskellPackages.override {
        extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        lens = hsPkg "lens" "4.6";
        # required, not in Nix
        # HEAD packages
        # monoidExtras = self.callPackage ../../../monoid-extras {};
        # active = self.callPackage ../../../active {};
        # diagramsCore = self.callPackage ../../../core {};
        # diagramsLib = self.callPackage ../../../lib {};
        # diagramsSvg = self.callPackage ../../../svg {};
        diagramsBuilder = self.callPackage ../../../builder {};
        # self
        diagramsHaddock= self.callPackage ./. {};
      };
    };
         in pkgs.lib.overrideDerivation hs.diagramsHaddock (attrs: {
                buildInputs = [hs.cabalInstall ] ++ attrs.buildInputs;
 })
