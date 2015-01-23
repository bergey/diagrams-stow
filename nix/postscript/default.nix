{ mkDerivation, base, containers, data-default-class, diagrams-core
, diagrams-lib, dlist, filepath, hashable, lens, monoid-extras, mtl
, semigroups, split, stdenv
}:
mkDerivation {
  pname = "diagrams-postscript";
  version = "1.1.0.1";
  src = ./.;
  buildDepends = [
    base containers data-default-class diagrams-core diagrams-lib dlist
    filepath hashable lens monoid-extras mtl semigroups split
  ];
  homepage = "http://projects.haskell.org/diagrams/";
  description = "Postscript backend for diagrams drawing EDSL";
  license = stdenv.lib.licenses.bsd3;
}
