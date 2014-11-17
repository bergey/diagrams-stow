# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, dualTree, lens, MemoTrie, monoidExtras, newtype
, semigroups, vectorSpace, vectorSpacePoints
}:

cabal.mkDerivation (self: {
  pname = "diagrams-core";
  version = "1.2.0.3";
  src = ./.;
  buildDepends = [
    dualTree lens MemoTrie monoidExtras newtype semigroups vectorSpace
    vectorSpacePoints
  ];
  meta = {
    homepage = "http://projects.haskell.org/diagrams";
    description = "Core libraries for diagrams EDSL";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
