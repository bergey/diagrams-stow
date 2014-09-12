{ haskellPackages ? (import <nixpkgs> {}).haskellPackages }:

let 
  inherit (haskellPackages)
    cabal binary deepseq filepath text vector
    cabalInstall;

in cabal.mkDerivation (self: {
  pname = "FontyFruity";
  version = "0.3-git";
  src = /home/bergey/code/diagrams/FontyFruity;
  buildDepends = [ binary deepseq filepath text vector ];
  buildTools = [cabalInstall];
  meta = {
    description = "A true type file format loader";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
