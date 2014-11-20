{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  hs = haskellPackages.override {
        extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        # required, not in Nix
        # fsnotify = self.callPackage /home/bergey/code/nixHaskellVersioned/fsnotify/0.1.0.3.nix {};
        # optparseApplicative = self.callPackage /home/bergey/code/nixHaskellVersioned/optparse-applicative/0.11.0.1.nix {};
        # tasty = self.callPackage /home/bergey/code/nixHaskellVersioned/tasty/0.10.0.2.nix {};
        # haskellSrcExts = self.callPackage /home/bergey/code/nixHaskellVersioned/haskell-src-exts/1.16.0.nix {};
        # hlint= self.callPackage /home/bergey/code/nixHaskellVersioned/hlint/1.9.5.nix {};
        # Newer versions than in Nix
        lens = hsPkg "lens" "4.6";
        linear = hsPkg "linear" "1.15.2";
        # HEAD packages
        monoidExtras = self.callPackage ../../../monoid-extras {};
        active = self.callPackage ../../../active {};
        diagramsCore = self.callPackage ../../../core {};
        diagramsLib = self.callPackage ../../../lib {};
        diagramsSvg = self.callPackage ../../../svg {};
        diagramsBuilder = self.callPackage ../../../builder {};
        # self
        thisPackage = self.callPackage ./. {};
      };
    };
    in pkgs.lib.overrideDerivation hs.thisPackage (attrs: {
        buildInputs = [hs.cabalInstall ] ++ attrs.buildInputs;
 })
