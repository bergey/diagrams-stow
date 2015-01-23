{ mkDerivation, ansi-terminal, base, base64-bytestring, blaze-svg
, bytestring, Cabal, cautious-file, cmdargs, containers, cpphs
, diagrams-builder, diagrams-lib, diagrams-svg, directory, filepath
, haskell-src-exts, lens, linear, mtl, parsec, QuickCheck, split
, stdenv, strict, tasty, tasty-quickcheck, text, uniplate
}:
mkDerivation {
  pname = "diagrams-haddock";
  version = "0.2.2.8";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    ansi-terminal base base64-bytestring blaze-svg bytestring Cabal
    cautious-file cmdargs containers cpphs diagrams-builder
    diagrams-lib diagrams-svg directory filepath haskell-src-exts lens
    linear mtl parsec split strict text uniplate
  ];
  testDepends = [
    base containers haskell-src-exts lens parsec QuickCheck tasty
    tasty-quickcheck
  ];
  homepage = "http://projects.haskell.org/diagrams/";
  description = "Preprocessor for embedding diagrams in Haddock documentation";
  license = stdenv.lib.licenses.bsd3;
}
