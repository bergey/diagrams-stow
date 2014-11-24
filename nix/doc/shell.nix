{ pkgs ? import <nixpkgs> {}, haskellPackages ? pkgs.haskellPackages }:

let 
   hs = haskellPackages.override {
        extension = self: super: {
        # required, not in Nix
        # fsnotify = self.callPackage /home/bergey/code/nixHaskellVersioned/fsnotify/0.1.0.3.nix {};
        # optparseApplicative = self.callPackage /home/bergey/code/nixHaskellVersioned/optparse-applicative/0.11.0.1.nix {};
        # tasty = self.callPackage /home/bergey/code/nixHaskellVersioned/tasty/0.10.0.2.nix {};
        # haskellSrcExts = self.callPackage /home/bergey/code/nixHaskellVersioned/haskell-src-exts/1.16.0.nix {};
        # hlint= self.callPackage /home/bergey/code/nixHaskellVersioned/hlint/1.9.5.nix {};
        # lens = pkgs.lib.overrideDerivation super.lens (attrs: {
        #       doCheck = false;
        #     });
        # network = self.callPackage /home/bergey/code/nixHaskellVersioned/network/2.6.0.2.nix {};
        # pandocCiteproc = self.callPackage /home/bergey/code/nixHaskellVersioned/pandoc-citeproc/0.4.0.1.nix {};
        # hakyll = pkgs.lib.overrideDerivation (self.callPackage /home/bergey/code/nixHaskellVersioned/hakyll/4.5.4.0.nix {}) (attrs: {
        #   doCheck = false;
        # });
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
        svgFonts = self.callPackage ../../../SVGFonts {};
        hsDocutils = self.callPackage ../../../docutils {};
        palette = self.callPackage ../../../palette {};
        # self
        thisPackage = self.callPackage ./. {};
      };
    };
         in 
          pkgs.lib.overrideDerivation hs.thisPackage (attrs: {
                 buildInputs = [hs.cabalInstall pkgs.python33Packages.docutils ] ++ attrs.buildInputs;
           })
