{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  hs = haskellPackages.override {
        extension = self: super: rec {
          hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
          lens = hsPkg "lens" "4.7";
          linear = hsPkg "linear" "1.16";
          diagramsCore = self.callPackage ../../../core {};
          thisPackage = self.callPackage ./. {};
      };
    };
  in
      pkgs.lib.overrideDerivation hs.thisPackage (attrs: {
       buildInputs = [hs.cabalInstall ] ++ attrs.buildInputs;
 })
