{ mkDerivation, base, bytestring, cairo, colour, containers
, data-default-class, diagrams-core, diagrams-lib, filepath
, hashable, JuicyPixels, lens, mtl, optparse-applicative, pango
, split, statestack, stdenv, transformers, unix, vector
}:
mkDerivation {
  pname = "diagrams-cairo";
  version = "1.2";
  src = ./.;
  buildDepends = [
    base bytestring cairo colour containers data-default-class
    diagrams-core diagrams-lib filepath hashable JuicyPixels lens mtl
    optparse-applicative pango split statestack transformers unix
    vector
  ];
  homepage = "http://projects.haskell.org/diagrams";
  description = "Cairo backend for diagrams drawing EDSL";
  license = stdenv.lib.licenses.bsd3;
}
