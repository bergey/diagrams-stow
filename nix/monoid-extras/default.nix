{ mkDerivation, base, groups, semigroupoids, semigroups, stdenv }:
mkDerivation {
  pname = "monoid-extras";
  version = "0.3.3.5";
  src = ./.;
  buildDepends = [ base groups semigroupoids semigroups ];
  description = "Various extra monoid-related definitions and utilities";
  license = stdenv.lib.licenses.bsd3;
}
