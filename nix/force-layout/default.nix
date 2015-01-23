{ mkDerivation, base, containers, data-default-class, lens, linear
, stdenv
}:
mkDerivation {
  pname = "force-layout";
  version = "0.3.0.7";
  src = ./.;
  buildDepends = [ base containers data-default-class lens linear ];
  description = "Simple force-directed layout";
  license = stdenv.lib.licenses.bsd3;
}
