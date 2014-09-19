{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  tmpHaskellPkgs= haskellPackages.override {
        extension = self: super: {
        # system under test
        # newer than nixpkgs, not needed
        # needed for GHC < 7.8
        # cairo = self.callPackage ../nix-updates/cairo/0.12.5.3.nix { libc = pkgs.stdenv.gcc.libc; cairo = pkgs.cairo;};
        # newer than Nix, needed
        fsnotify = self.callPackage ../nix-updates/fsnotify/0.1.0.3.nix {};
        optparseApplicative = self.callPackage ../nix-updates/optparse-applicative/0.10.0 {};
        MonadRandom = self.callPackage ../nix-updates/MonadRandom/0.3.nix {};
        # local copies
        diagramsCore= self.callPackage ../../../core {};
        diagramsLib = self.callPackage ../../../lib {};
        diagramsCairo = self.callPackage ./. {};
      };
    };
 in let
 haskellPackages = tmpHaskellPkgs;
in pkgs.lib.overrideDerivation haskellPackages.diagramsCairo (attrs: {
   buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })