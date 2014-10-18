{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
  tmpHaskellPkgs= haskellPackages.override {
        extension = self: super: {
          diagramsPandoc = self.callPackage ./. {};
          # not in Nix           
            lens = pkgs.lib.overrideDerivation super.lens (attrs: {
              doCheck = false;
            });         
          # Hackage versions
          # haskellSrcExts = self.callPackage /home/bergey/code/nixHaskellVersioned/haskell-src-exts/1.15.0.1.nix {};
          # hlint= self.callPackage /home/bergey/code/nixHaskellVersioned/hlint/1.9.4.nix {};
          # diagramsBuilder = self.callPackage /home/bergey/code/nixHaskellVersioned/diagrams-builder/0.6.0.1.nix {};
          # HEAD deps
          haskellSrcExts = self.callPackage /home/bergey/code/nixHaskellVersioned/haskell-src-exts/1.16.0.nix {};
          hlint= self.callPackage /home/bergey/code/nixHaskellVersioned/hlint/1.9.5.nix {};
          fsnotify = self.callPackage /home/bergey/code/nixHaskellVersioned/fsnotify/0.1.0.3.nix {};            
          optparseApplicative = self.callPackage /home/bergey/code/nixHaskellVersioned/optparse-applicative/0.11.0.1.nix {};
          tasty = self.callPackage /home/bergey/code/nixHaskellVersioned/tasty/0.10.0.2.nix {};
          diagramsBuilder = self.callPackage ../../../builder {};
          diagramsCore= self.callPackage ../../../core {};
          diagramsLib = self.callPackage ../../../lib {};
          diagramsCairo = self.callPackage ../../../cairo {};
      };
    };
  in let
     haskellPackages = tmpHaskellPkgs;
     in pkgs.lib.overrideDerivation haskellPackages.diagramsPandoc (attrs: {
       buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })
