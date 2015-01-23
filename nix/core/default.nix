{ mkDerivation, adjunctions, base, containers, distributive
, dual-tree, lens, linear, monoid-extras, mtl, semigroups, stdenv
, unordered-containers, haddock-api
}:
mkDerivation {
  pname = "diagrams-core";
  version = "1.2";
  src = ./.;
  buildDepends = [
    adjunctions base containers distributive dual-tree lens linear
    monoid-extras mtl semigroups unordered-containers haddock-api
  ];
  homepage = "http://projects.haskell.org/diagrams";
  description = "Core libraries for diagrams EDSL";
  license = stdenv.lib.licenses.bsd3;
}
