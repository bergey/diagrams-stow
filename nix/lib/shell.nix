{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  hs = haskellPackages.override {
        extension = self: super: rec {
          hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
          linear = hsPkg "linear" "1.15.4";
          diagramsCore = self.callPackage ../../../core {};
          thisPackage = self.callPackage ./. {};
      };
    };
  in
      pkgs.lib.overrideDerivation hs.thisPackage (attrs: {
       buildInputs = [hs.cabalInstall ] ++ attrs.buildInputs;
 })
