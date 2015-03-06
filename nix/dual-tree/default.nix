{ mkDerivation, base, monoid-extras, newtype, semigroups, stdenv }:
mkDerivation {
  pname = "dual-tree";
  version = "0.2.0.5";
  src = ./.;
  buildDepends = [ base monoid-extras newtype semigroups ];
  description = "Rose trees with cached and accumulating monoidal annotations";
  license = stdenv.lib.licenses.bsd3;
}
