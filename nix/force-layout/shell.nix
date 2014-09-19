{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  tmpHaskellPkgs= haskellPackages.override {
        extension = self: super: {
        # system under test
        # newer than nixpkgs, not needed
        # newer than Nix, needed
        fsnotify = self.callPackage ../nix-updates/fsnotify/0.1.0.3.nix {};
        optparseApplicative = self.callPackage ../nix-updates/optparse-applicative/0.10.0 {};
        MonadRandom = self.callPackage ../nix-updates/MonadRandom/0.3.nix {};
        # local copies
      };
    };
 in let
 haskellPackages = tmpHaskellPkgs;
in pkgs.lib.overrideDerivation haskellPackages.forceLayout (attrs: {
   buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })