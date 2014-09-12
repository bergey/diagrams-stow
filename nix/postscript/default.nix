{ cabal, dataDefaultClass, diagramsCore, diagramsLib, dlist
, filepath, hashable, lens, monoidExtras, mtl, semigroups, split
, vectorSpace, cabalInstall
}:

cabal.mkDerivation (self: {
  pname = "diagrams-postscript";
  version = "1.1-git";
 src = ./.;
 buildDepends = [
    dataDefaultClass diagramsCore diagramsLib dlist filepath hashable
    lens monoidExtras mtl semigroups split vectorSpace
  ];
  buildTools = [cabalInstall];
  meta = {
    homepage = "http://projects.haskell.org/diagrams/";
    description = "Postscript backend for diagrams drawing EDSL";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
