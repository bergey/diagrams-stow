{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  hs = haskellPackages.override {
     extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        lens = hsPkg "lens" "4.7";
        vectorSpace = hsPkg "vector-space" "0.9";
        vectorSpacePoints = self.callPackage ../../../vector-space-points {};
        thisPackage = self.callPackage ./. {};
      };
    };
     in pkgs.lib.overrideDerivation hs.thisPackage (attrs: {
       buildInputs = [ hs.cabalInstall ] ++ attrs.buildInputs;
 })
