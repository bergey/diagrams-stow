{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskell-ng.packages.ghc7101 }:

with pkgs.haskell-ng.lib;

let 
  hs = haskellPackages.override {
        overrides = self: super: rec {
          hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
          # required, not in Nix
          # version pins
          prelude-extras = dontCheck super.prelude-extras;
          fingertree = dontCheck super.fingertree;
          lens = dontCheck super.lens;
          # HEAD packages
          monoid-extras = self.callPackage ../../../monoid-extras {};
          dual-tree = self.callPackage ../../../dual-tree {};
          active = self.callPackage ../../../active {};
          diagrams-solve = self.callPackage ../../../solve {};
          diagrams-core = self.callPackage ../../../core {};
          # self
          thisPackage = self.callPackage ./. {};
      };
    };
  in (hs.thisPackage.override (args: args // {
    mkDerivation = expr: args.mkDerivation (expr // {
      buildTools = [  hs.cabal-install ];
    });
  })).env
