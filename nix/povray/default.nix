{ mkDerivation, base, colour, containers, diagrams-core
, diagrams-lib, lens, pretty, stdenv
}:
mkDerivation {
  pname = "diagrams-povray";
  version = "0.1";
  src = ./.;
  buildDepends = [
    base colour containers diagrams-core diagrams-lib lens pretty
  ];
  homepage = "http://projects.haskell.org/diagrams";
  description = "Persistence Of Vision raytracer backend for diagrams EDSL";
  license = stdenv.lib.licenses.bsd3;
}
