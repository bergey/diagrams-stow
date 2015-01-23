{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellngPackages }:

with pkgs.haskell-ng.lib;

let 
  hs = haskellPackages.override {
        overrides = self: super: rec {
          hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
          # required, not in Nix
          # version pins
          # other fixes
          Rasterific = dontCheck super.Rasterific;
          # HEAD packages
          active = self.callPackage ../../../active {};
          diagrams-core = self.callPackage ../../../core {};
          diagrams-lib = self.callPackage ../../../lib {};
          diagrams-cairo = self.callPackage ../../../cairo {};
          diagrams-postscript = self.callPackage ../../../postscript {};
          diagrams-svg = self.callPackage ../../../svg {};
          diagrams-rasterific = self.callPackage ../../../rasterific {};
          # self
          thisPackage = self.callPackage ./. {};
      };
    };
  in hs.thisPackage.env
