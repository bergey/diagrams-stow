{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  hs = haskellPackages.override {
        extension = self: super: rec {
          thisPackage = self.callPackage ./. {};
          hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
          # not in Nix           
            # lens = pkgs.lib.overrideDerivation super.lens (attrs: {
            #   doCheck = false;
            # });         
          # Hackage versions
          # haskellSrcExts = self.callPackage /home/bergey/code/nixHaskellVersioned/haskell-src-exts/1.15.0.1.nix {};
          # hlint= self.callPackage /home/bergey/code/nixHaskellVersioned/hlint/1.9.4.nix {};
          # diagramsBuilder = hsPkg "diagrams-builder" "0.6.0.2";
          pandoc = hsPkg "pandoc" "1.13.1";
          # HEAD deps
          linear = hsPkg "linear" "1.15.4";
          diagramsBuilder = self.callPackage ../../../builder {};
          diagramsCore= self.callPackage ../../../core {};
          diagramsLib = self.callPackage ../../../lib {};
          diagramsCairo = self.callPackage ../../../cairo {};
          diagramsSvg = self.callPackage ../../../svg {};
          diagramsPostscript = self.callPackage ../../../postscript {};
      };
    };
     in pkgs.lib.overrideDerivation hs.thisPackage (attrs: {
       buildInputs = [ hs.cabalInstall ] ++ attrs.buildInputs;
 })
