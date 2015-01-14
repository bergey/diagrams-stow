{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  tmpHaskellPkgs= haskellPackages.override {
        extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        # required, not in Nix
        # newer than Nix
        lens = hsPkg "lens" "4.7";
        linear = hsPkg "linear" "1.16";
        # HEAD packages
        active = self.callPackage ../../../active {};
        forceLayout = self.callPackage ../../../force-layout {};
        diagramsCore = self.callPackage ../../../core {};
        diagramsLib = self.callPackage ../../../lib {};
        # self
        thisPackage = self.callPackage ./. {};
      };
    };
  in let
     haskellPackages = tmpHaskellPkgs;
          in pkgs.lib.overrideDerivation haskellPackages.thisPackage (attrs: {
       buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })
