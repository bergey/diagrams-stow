{ mkDerivation, base, mtl, stdenv, transformers
, transformers-compat
}:
mkDerivation {
  pname = "statestack";
  version = "0.2.0.3";
  src = ./.;
  buildDepends = [ base mtl transformers transformers-compat ];
  description = "Simple State-like monad transformer with saveable and restorable state";
  license = stdenv.lib.licenses.bsd3;
}
