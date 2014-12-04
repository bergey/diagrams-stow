{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  tmpHaskellPkgs= haskellPackages.override {
        extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        dualTree = self.callPackage ./. {};
        semigroups = hsPkg "semigroups" "0.16";
      };
    };
  in let
     haskellPackages = tmpHaskellPkgs;
     in pkgs.lib.overrideDerivation haskellPackages.dualTree (attrs: {
       buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })
