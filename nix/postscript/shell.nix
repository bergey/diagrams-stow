{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  tmpHaskellPkgs= haskellPackages.override {
    extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        # required, not in Nix
        # newer than Nix
        semigroups = hsPkg "semigroups" "0.16";
        # HEAD packages
        # monoidExtras = self.callPackage ../../../monoid-extras {};
        # active = self.callPackage ../../../active {};
        diagramsCore= self.callPackage ../../../core {};
        diagramsLib= self.callPackage ../../../lib {};
        # self
        diagramsPostscript = self.callPackage ./. {};
      };
    };
  in let
     haskellPackages = tmpHaskellPkgs;
     in pkgs.lib.overrideDerivation haskellPackages.diagramsPostscript (attrs: {
       buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })
