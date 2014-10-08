{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages_ghc763 }:

let 
  tmpHaskellPkgs= haskellPackages.override {
        extension = self: super: {
        # required, not in Nix
        fsnotify = self.callPackage /home/bergey/code/nixHaskellVersioned/fsnotify/0.1.0.3.nix {};
        optparseApplicative = self.callPackage /home/bergey/code/nixHaskellVersioned/optparse-applicative/0.11.0.1.nix {};
        # cairo-0.13 does not build with GHC < 7.8
        cairo = self.callPackage /home/bergey/code/nixHaskellVersioned/cairo/0.12.5.3.nix {
          inherit (pkgs) cairo zlib;
          libc = pkgs.stdenv.gcc.libc;
        };
         glib = self.callPackage  /home/bergey/code/nixHaskellVersioned/glib/0.12.5.4.nix {
            glib = pkgs.glib;
            libc = pkgs.stdenv.gcc.libc;
        };
        pango = self.callPackage    /home/bergey/code/nixHaskellVersioned/pango/0.12.5.3.nix {
          inherit (pkgs) pango;
          libc = pkgs.stdenv.gcc.libc;
        };
        # HEAD packages
        diagramsCore = self.callPackage ../../../core {};
        diagramsLib = self.callPackage ../../../lib {};
        # self
        diagramsCairo = self.callPackage ./. {};
      };
    };
  in let
     haskellPackages = tmpHaskellPkgs;
     in pkgs.lib.overrideDerivation haskellPackages.diagramsCairo (attrs: {
       buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })
