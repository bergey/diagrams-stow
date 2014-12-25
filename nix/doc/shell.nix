{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
   hs = haskellPackages.override {
        extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        # required, not in Nix
        # HEAD packages
        monoidExtras = self.callPackage ../../../monoid-extras {};
        active = self.callPackage ../../../active {};
        diagramsCore = self.callPackage ../../../core {};
        diagramsLib = self.callPackage ../../../lib {};
        forceLayout = self.callPackage ../../../force-layout {};
        diagramsContrib = self.callPackage ../../../contrib {};
        diagramsCairo = self.callPackage ../../../cairo {};
        diagramsPostscript = self.callPackage ../../../postscript {};
        diagramsSvg = self.callPackage ../../../svg {};
        diagramsBuilder = self.callPackage ../../../builder {};
        SVGFonts = self.callPackage ../../../SVGFonts {};
        hsDocutils = self.callPackage ../../../docutils {};
        palette = self.callPackage ../../../palette {};
        # self
        thisPackage = self.callPackage ./. {};
      };
    };
         in 
          pkgs.lib.overrideDerivation hs.thisPackage (attrs: {
                 buildInputs = [hs.cabalInstall pkgs.python33Packages.docutils pkgs.python33Packages.pygments ] ++ attrs.buildInputs;
           })
