let pkgs = import <nixpkgs> {};
    haskellPackages = pkgs.haskellPackages.override {
      extension = self: super: rec {
        hsPkg = pkg: version: self.callPackage "/home/bergey/code/nixHaskellVersioned/${pkg}/${version}.nix" {};
        concurrentSupply = self.callPackage  /home/bergey/code/nixHaskellVersioned/concurrent-supply/0.1.7.nix {};
        lens = hsPkg "lens" "4.6";
        linear = hsPkg "linear" "1.15.2";
        # optparseApplicative = self.callPackage  /home/bergey/code/nixHaskellVersioned/optparse-applicative/0.11.0.1.nix {};
        diagramsCore= self.callPackage ../../../core {};
        diagramsLib= self.callPackage ../../../lib {};
        diagramsPovray = self.callPackage ./. {};
      };
    };
 in pkgs.lib.overrideDerivation haskellPackages.diagramsPovray (attrs: {
   buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })
