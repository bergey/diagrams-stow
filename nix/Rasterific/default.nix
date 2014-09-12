{ haskellPackages ? (import <nixpkgs> {}).haskellPackages }:

let 
  FontyFruity = import ../FontyFruity {haskellPackages = haskellPackages;};
  inherit (haskellPackages)
    cabal binary criterion deepseq dlist filepath
    free JuicyPixels mtl QuickCheck statistics vector
    vectorAlgorithms cabalInstall;

in cabal.mkDerivation (self: {
  pname = "Rasterific";
  version = "0.3-git";
  src = /home/bergey/code/diagrams/Rasterific;
  buildDepends = [
    dlist FontyFruity free JuicyPixels mtl vector vectorAlgorithms
  ];
  doCheck= false; # depends on criterion < 0.9
  noHaddock = true; # images in docs only build on Windows
  testDepends = [
    binary criterion deepseq filepath FontyFruity JuicyPixels
    QuickCheck statistics vector
  ];
  buildTools = [cabalInstall];
  meta = {
    description = "A pure haskell drawing engine";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
