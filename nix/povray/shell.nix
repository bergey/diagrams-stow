let pkgs = import <nixpkgs> {};
    haskellPackages = pkgs.haskellPackages.override {
      extension = self: super: {
        fsnotify = self.callPackage /home/bergey/code/nixHaskellVersioned/fsnotify/0.1.0.3.nix {};
        concurrentSupply = self.callPackage  /home/bergey/code/nixHaskellVersioned/concurrent-supply/0.1.7.nix {};
        linear = self.callPackage ../../../linear {};
        optparseApplicative = self.callPackage  /home/bergey/code/nixHaskellVersioned/optparse-applicative/0.10.0 {};
        diagramsCore= self.callPackage ../../../core {};
        diagramsLib= self.callPackage ../../../lib {};
        diagramsPovray = self.callPackage ./. {};
      };
    };
 in pkgs.lib.overrideDerivation haskellPackages.diagramsPovray (attrs: {
   buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })