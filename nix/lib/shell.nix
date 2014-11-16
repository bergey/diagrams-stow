{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let
     hs = haskellPackages.override {
      extension = self: super: {
        # required, not in Nix
        # fsnotify = self.callPackage /home/bergey/code/nixHaskellVersioned/fsnotify/0.1.0.3.nix {};
        # optparseApplicative = self.callPackage /home/bergey/code/nixHaskellVersioned/optparse-applicative/0.11.0.1.nix {};
        # # newer than in Nix
        # # HEAD packages
        # monoidExtras = self.callPackage ../../../monoid-extras {};
        # active = self.callPackage ../../../active {};
        # diagramsCore= self.callPackage ../../../core {};
        thisPackage = self.callPackage ./. {};
      };
    };
in pkgs.lib.overrideDerivation hs.thisPackage (attrs: {
            buildInputs = [hs.cabalInstall ] ++ attrs.buildInputs;
 })
