{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellngPackages }:

let 
  hs = haskellPackages.override {
        overrides = self: super: rec {
          hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
          # required, not in Nix
          # concurrentSupply = self.callPackage  /home/bergey/code/nixHaskellVersioned/concurrent-supply/0.1.7.nix {};
          # version pins
          # HEAD packages
        diagrams-core= self.callPackage ../../../core {};
        diagrams-lib= self.callPackage ../../../lib {};
          # self
          thisPackage = self.callPackage ./. {};
      };
    };
  in hs.thisPackage.env
