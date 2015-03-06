{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskell-ng.packages.ghc784 }:

with pkgs.haskell-ng.lib;

let 
  hs = haskellPackages.override {
        overrides = self: super: rec {
          hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
          lens = dontCheck super.lens;
          thisPackage = self.callPackage ./. {};
      };
    };
  in (hs.thisPackage.override (args: args // {
    mkDerivation = expr: args.mkDerivation (expr // {
      buildTools = [  hs.cabal-install ];
    });
  })).env
