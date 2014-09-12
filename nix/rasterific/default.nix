{ haskellPackages ? (import <nixpkgs> {}).haskellPackages }:

let 
  FontyFruity = import ../FontyFruity {haskellPackages = haskellPackages;};
  Rasterific= import ../Rasterific {haskellPackages = haskellPackages;};
  diagramsCore = import ../core {haskellPackages = haskellPackages;};
  diagramsLib  = import ../lib {haskellPackages = haskellPackages;};
  inherit (haskellPackages)
    dataDefaultClass filepath
    JuicyPixels lens mtl optparseApplicative split statestack time 
    cabal cabalInstall;

in cabal.mkDerivation (self: {
  pname = "diagrams-rasterific";
  version = "0.1-git";
  src = /home/bergey/code/diagrams/rasterific;
  buildDepends = [
    dataDefaultClass diagramsCore diagramsLib filepath FontyFruity
    JuicyPixels lens mtl optparseApplicative Rasterific split
    statestack time
  ];
  buildTools = [cabalInstall];
  meta = {
    homepage = "http://projects.haskell.org/diagrams/";
    description = "Rasterific backend for diagrams";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
