{ mkDerivation, base, blaze-svg, bytestring, cmdargs
, diagrams-cairo, diagrams-lib, diagrams-postscript
, diagrams-rasterific, diagrams-svg, directory, exceptions
, filepath, hashable, haskell-src-exts, hint, JuicyPixels, lens
, mtl, split, stdenv, transformers
}:
mkDerivation {
  pname = "diagrams-builder";
  version = "0.6.0.1";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    base blaze-svg bytestring cmdargs diagrams-cairo diagrams-lib
    diagrams-postscript diagrams-rasterific diagrams-svg directory
    exceptions filepath hashable haskell-src-exts hint JuicyPixels lens
    mtl split transformers
  ];
  configureFlags = [ "-fcairo" "-fsvg" "-fps" "-frasterific" ];
  homepage = "http://projects.haskell.org/diagrams";
  description = "hint-based build service for the diagrams graphics EDSL";
  license = stdenv.lib.licenses.bsd3;
}
