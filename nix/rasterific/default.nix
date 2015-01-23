{ mkDerivation, base, bytestring, containers, data-default-class
, diagrams-core, diagrams-lib, filepath, FontyFruity, hashable
, JuicyPixels, lens, mtl, optparse-applicative, Rasterific, split
, statestack, stdenv, unix
}:
mkDerivation {
  pname = "diagrams-rasterific";
  version = "0.1";
  src = ./.;
  buildDepends = [
    base bytestring containers data-default-class diagrams-core
    diagrams-lib filepath FontyFruity hashable JuicyPixels lens mtl
    optparse-applicative Rasterific split statestack unix
  ];
  homepage = "http://projects.haskell.org/diagrams/";
  description = "Rasterific backend for diagrams";
  license = stdenv.lib.licenses.bsd3;
}
