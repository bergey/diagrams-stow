{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellngPackages }:

let 
  hs = haskellPackages.override {
        overrides = self: super: rec {
          hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
          diagrams-core = self.callPackage ../../../core {};
          diagrams-lib = self.callPackage ../../../lib {};
          force-layout = self.callPackage ../../../force-layout {};
          active = self.callPackage ../../../active {};
          thisPackage = self.callPackage ./. {};
      };
    };
  in hs.thisPackage.env
