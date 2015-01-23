{ mkDerivation, base, lens, linear, QuickCheck, semigroupoids
, semigroups, stdenv, vector
}:
mkDerivation {
  pname = "active";
  version = "0.1.0.17";
  src = ./.;
  buildDepends = [
    base lens linear semigroupoids semigroups vector
  ];
  testDepends = [
    base lens linear QuickCheck semigroupoids semigroups vector
  ];
  description = "Abstractions for animation";
  license = stdenv.lib.licenses.bsd3;
}
