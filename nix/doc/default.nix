# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, cmdargs, diagramsBuilder, hsDocutils, hakyll, safe, shake,
diagramsCore, active, diagramsLib, diagramsContrib, SVGFonts, palette }:

cabal.mkDerivation (self: {
  pname = "diagrams-doc";
  version = "1.3";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  noHaddock = true;
  buildDepends = [
    cmdargs diagramsBuilder hsDocutils hakyll safe shake diagramsCore
    active diagramsLib diagramsContrib SVGFonts palette
  ];
  meta = {
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
