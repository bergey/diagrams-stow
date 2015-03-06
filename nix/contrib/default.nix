{ mkDerivation, base, circle-packing, colour, containers
, data-default, data-default-class, diagrams-core, diagrams-lib
, diagrams-solve, force-layout, HUnit, lens, linear, MonadRandom
, mtl, parsec, QuickCheck, random, semigroups, split, stdenv
, test-framework, test-framework-hunit, test-framework-quickcheck2
, text
}:
mkDerivation {
  pname = "diagrams-contrib";
  version = "1.1.2";
  src = ./.;
  buildDepends = [
    base circle-packing colour containers data-default
    data-default-class diagrams-core diagrams-lib diagrams-solve
    force-layout lens linear MonadRandom mtl parsec random semigroups
    split text
  ];
  testDepends = [
    base containers diagrams-lib HUnit QuickCheck test-framework
    test-framework-hunit test-framework-quickcheck2
  ];
  homepage = "http://projects.haskell.org/diagrams/";
  description = "Collection of user contributions to diagrams EDSL";
  license = stdenv.lib.licenses.bsd3;
}
