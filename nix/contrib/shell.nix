{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskell-ng.packages.ghc7101 }:

with pkgs.haskell-ng.lib;

let 
  hs = haskellPackages.override {
        overrides = self: super: rec {
          hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
          # version pins
          prelude-extras = dontCheck super.prelude-extras;
          fingertree = dontCheck super.fingertree;
          lens = dontCheck super.lens;
          # HEAD packages
          monoid-extras = self.callPackage ../../../monoid-extras {};
          dual-tree = self.callPackage ../../../dual-tree {};
          diagrams-solve = self.callPackage ../../../solve {};
          diagrams-core = self.callPackage ../../../core {};
          diagrams-lib = self.callPackage ../../../lib {};
          force-layout = self.callPackage ../../../force-layout {};
          active = self.callPackage ../../../active {};
          thisPackage = self.callPackage ./. {};
      };
    };
  in (hs.thisPackage.override (args: args // {
    mkDerivation = expr: args.mkDerivation (expr // {
      buildTools = [  hs.cabal-install ];
    });
  })).env

