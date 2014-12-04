{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  tmpHaskellPkgs= haskellPackages.override {
        extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        active = self.callPackage ./. {};
        semigroups = hsPkg "semigroups" "0.16";
      };
    };
  in let
     haskellPackages = tmpHaskellPkgs;
     in pkgs.lib.overrideDerivation haskellPackages.active (attrs: {
       buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })
