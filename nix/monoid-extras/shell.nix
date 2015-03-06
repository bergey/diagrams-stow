{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskell-ng.packages.ghc7101 }:

let 
  hs = haskellPackages.override {
        overrides = self: super: rec {
          hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
          # required, not in Nix
          # version pins
          # HEAD packages
          # self
          thisPackage = self.callPackage ./. {};
      };
    };
  in (hs.thisPackage.override (args: args // {
    mkDerivation = expr: args.mkDerivation (expr // {
      buildTools = [  hs.cabal-install ];
    });
  })).env
