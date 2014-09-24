let pkgs = import <nixpkgs> {};
    haskellPackages = pkgs.haskellPackages.override {
      extension = self: super: {
        text = self.callPackage ../nix-updates/text/1.2.0.0.nix {};
        lens = self.callPackage ../nix-updates/lens/4.4.0.2.nix {}; # needed for text-1.2
        fsnotify = self.callPackage ../nix-updates/fsnotify/0.1.0.3.nix {};
        linear = self.callPackage ../../../linear {};
        optparseApplicative = self.callPackage ../nix-updates/optparse-applicative/0.10.0 {};
        diagramsCore= self.callPackage ../../../core {};
        diagramsLib = self.callPackage ./. {};
      };
    };
 in pkgs.lib.overrideDerivation haskellPackages.diagramsLib (attrs: {
   buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })