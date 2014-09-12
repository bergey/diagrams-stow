{ haskellPackages ? (import <nixpkgs> {}).haskellPackages }:

let 
 inherit (haskellPackages) 
    cabal base64Bytestring blazeMarkup blazeSvg colour filepath hashable
    JuicyPixels lens monoidExtras mtl  split time
    vectorSpace 
    cabalInstall callPackage;
  diagramsCore = import ../core {haskellPackages = haskellPackages;};
  diagramsLib  = import ../lib {haskellPackages = haskellPackages;};
  optparseApplicative  = callPackage ../../../optparseApplicative.nix {};

in cabal.mkDerivation (self: {
  pname = "diagrams-svg";
  version = "1.1";
  src = ../../../svg;
  buildDepends = [
    base64Bytestring blazeMarkup blazeSvg colour diagramsCore
    diagramsLib filepath hashable JuicyPixels lens monoidExtras mtl
    optparseApplicative split time vectorSpace
  ];
  buildTools = [ cabalInstall ];
  meta = {
    homepage = "http://projects.haskell.org/diagrams/";
    description = "SVG backend for diagrams drawing EDSL";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
