{ mkDerivation, base, mtl, stdenv, transformers }:
mkDerivation {
  pname = "statestack";
  version = "0.2.0.3";
  src = ./.;
  buildDepends = [ base mtl transformers ];
  description = "Simple State-like monad transformer with saveable and restorable state";
  license = stdenv.lib.licenses.bsd3;
}
