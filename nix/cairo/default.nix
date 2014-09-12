{ haskellPackages ? (import <nixpkgs> {}).haskellPackages }:

let 
  diagramsCore = import ../core {haskellPackages = haskellPackages;};
  diagramsLib  = import ../lib {haskellPackages = haskellPackages;};
  inherit (haskellPackages)
    cabal cairo colour dataDefaultClass filepath hashable JuicyPixels
    lens mtl pango split statestack time
    transformers vector 
    cabalInstall callPackage;
  optparseApplicative  = callPackage ../../../optparseApplicative.nix {};

in
cabal.mkDerivation (self: {
  pname = "diagrams-cairo";
  version = "1.2-git";
  src = ../../../cairo;
  buildDepends = [
    cairo colour dataDefaultClass diagramsCore diagramsLib filepath
    hashable JuicyPixels lens mtl optparseApplicative pango split
    statestack time transformers vector
  ];
  buildTools = [cabalInstall];
  meta = {
    homepage = "http://projects.haskell.org/diagrams";
    description = "Cairo backend for diagrams drawing EDSL";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
