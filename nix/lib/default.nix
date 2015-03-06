{ mkDerivation, active, adjunctions, array, base, colour
, containers, data-default-class, diagrams-core, diagrams-solve
, directory, distributive, dual-tree, filepath, fingertree
, fsnotify, hashable, intervals, JuicyPixels, lens, linear
, monoid-extras, mtl, optparse-applicative, process, semigroups
, stdenv, system-filepath, tagged, text, unordered-containers
}:
mkDerivation {
  pname = "diagrams-lib";
  version = "1.2";
  src = ./.;
  buildDepends = [
    active adjunctions array base colour containers data-default-class
    diagrams-core diagrams-solve directory distributive dual-tree
    filepath fingertree fsnotify hashable intervals JuicyPixels lens
    linear monoid-extras mtl optparse-applicative process semigroups
    system-filepath tagged text unordered-containers
  ];
  homepage = "http://projects.haskell.org/diagrams";
  description = "Embedded domain-specific language for declarative graphics";
  license = stdenv.lib.licenses.bsd3;
}
