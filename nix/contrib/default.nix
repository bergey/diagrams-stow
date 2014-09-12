
{ haskellPackages ? (import <nixpkgs> {}).haskellPackages }:

let
  inherit (haskellPackages)
    arithmoi circlePacking colour dataDefault
    dataDefaultClass HUnit
    lens mtl QuickCheck semigroups split
    testFramework testFrameworkHunit testFrameworkQuickcheck2 
    # MonadRandom text
    vectorSpace vectorSpacePoints
    cabalInstall callPackage;
  cabal = haskellPackages.cabal;
  diagramsCore = import ../core {haskellPackages = haskellPackages;};
  diagramsLib  = import ../lib {haskellPackages = haskellPackages;};
  forceLayout  = import ../force-layout {haskellPackages = haskellPackages;};
  MonadRandom = callPackage ../nix-updates/MonadRandom.nix {};
  text = callPackage ../nix-updates/text.nix {};
  parsec = callPackage ../nix-updates/parsec.nix {};

in cabal.mkDerivation (self: {
  pname = "diagrams-contrib";
  version = "1.1-git";
  src = /home/bergey/code/diagrams/contrib;
  buildDepends = [
    arithmoi circlePacking colour dataDefault dataDefaultClass
    diagramsCore diagramsLib forceLayout lens MonadRandom mtl parsec
    semigroups split text vectorSpace vectorSpacePoints
  ];
  buildTools = [ cabalInstall ];
  testDepends = [
    diagramsLib HUnit QuickCheck testFramework testFrameworkHunit
    testFrameworkQuickcheck2
  ];
  meta = {
    homepage = "http://projects.haskell.org/diagrams/";
    description = "Collection of user contributions to diagrams EDSL";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
