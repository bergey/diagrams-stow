{ mkDerivation, attoparsec, base, blaze-markup, blaze-svg
, containers, data-default-class, diagrams-core, diagrams-lib
, directory, parsec, split, stdenv, text, tuple, vector, xml
}:
mkDerivation {
  pname = "SVGFonts";
  version = "1.4.0.3";
  src = ./.;
  buildDepends = [
    attoparsec base blaze-markup blaze-svg containers
    data-default-class diagrams-core diagrams-lib directory parsec
    split text tuple vector xml
  ];
  description = "Fonts from the SVG-Font format";
  license = stdenv.lib.licenses.bsd3;
}
