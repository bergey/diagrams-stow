{ mkDerivation, base, blank-canvas, cmdargs, containers
, data-default-class, diagrams-core, diagrams-lib, lens, mtl
, NumInstances, optparse-applicative, statestack, stdenv, text
}:
mkDerivation {
  pname = "diagrams-canvas";
  version = "0.3.0.1";
  src = ./.;
  buildDepends = [
    base blank-canvas cmdargs containers data-default-class
    diagrams-core diagrams-lib lens mtl NumInstances
    optparse-applicative statestack text
  ];
  homepage = "http://projects.haskell.org/diagrams/";
  description = "HTML5 canvas backend for diagrams drawing EDSL";
  license = stdenv.lib.licenses.bsd3;
}
