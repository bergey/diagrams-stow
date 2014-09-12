{ haskellPackages ? (import <nixpkgs> {}).haskellPackages }:

let
  inherit (haskellPackages)
    cabal dataDefaultClass lens vectorSpace vectorSpacePoints
    cabalInstall;

in cabal.mkDerivation (self: {
  pname = "force-layout";
  version = "0.3-git";
  src = ../../../force-layout;
  buildDepends = [
    dataDefaultClass lens vectorSpace vectorSpacePoints
  ];
  buildTools = [ cabalInstall ];
  meta = {
    description = "Simple force-directed layout";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
