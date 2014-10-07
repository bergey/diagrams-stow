let pkgs = import <nixpkgs> {};
    haskellPackages = pkgs.haskellPackages.override {
      extension = self: super: {
      # versions under test
        text = self.callPackage /home/bergey/code/nixHaskellVersioned/text/1.2.0.0.nix {};
        lens = self.callPackage  /home/bergey/code/nixHaskellVersioned/lens/4.4.0.2.nix {}; # needed for text-1.2
        # required, not in Nix
        fsnotify = self.callPackage /home/bergey/code/nixHaskellVersioned/fsnotify/0.1.0.3.nix {};
        optparseApplicative = self.callPackage /home/bergey/code/nixHaskellVersioned/optparse-applicative/0.11.0.1.nix {};
        # HEAD packages
        diagramsCore= self.callPackage ../../../core {};
        diagramsLib = self.callPackage ./. {};
      };
    };
 in pkgs.lib.overrideDerivation haskellPackages.diagramsLib (attrs: {
   buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })