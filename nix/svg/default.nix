{ mkDerivation, base, base64-bytestring, blaze-markup, blaze-svg
, bytestring, colour, containers, diagrams-core, diagrams-lib
, directory, filepath, hashable, JuicyPixels, lens, monoid-extras
, mtl, old-time, optparse-applicative, process, split, stdenv, time
, unix
}:
mkDerivation {
  pname = "diagrams-svg";
  version = "1.1";
  src = ./.;
  buildDepends = [
    base base64-bytestring blaze-markup blaze-svg bytestring colour
    containers diagrams-core diagrams-lib directory filepath hashable
    JuicyPixels lens monoid-extras mtl old-time optparse-applicative
    process split time unix
  ];
  homepage = "http://projects.haskell.org/diagrams/";
  description = "SVG backend for diagrams drawing EDSL";
  license = stdenv.lib.licenses.bsd3;
}
