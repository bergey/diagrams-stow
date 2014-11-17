# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, active, adjunctions, colour, dataDefaultClass
, diagramsCore, distributive, dualTree, filepath, fingertree
, fsnotify, hashable, intervals, JuicyPixels, lens, linear
, monoidExtras, mtl, optparseApplicative, semigroups
, systemFilepath, tagged, text, unorderedContainers
}:

cabal.mkDerivation (self: {
  pname = "diagrams-lib";
  version = "1.2";
  src = ./.;
  buildDepends = [
    active adjunctions colour dataDefaultClass diagramsCore
    distributive dualTree filepath fingertree fsnotify hashable
    intervals JuicyPixels lens linear monoidExtras mtl
    optparseApplicative semigroups systemFilepath tagged text
    unorderedContainers
  ];
  meta = {
    homepage = "http://projects.haskell.org/diagrams";
    description = "Embedded domain-specific language for declarative graphics";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
