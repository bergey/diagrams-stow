let pkgs = import <nixpkgs> {};
    haskellPackages = pkgs.haskellPackages.override {
      extension = self: super: {
        text = self.callPackage ../nix-updates/text/1.2.0.0.nix {};
        parsec = self.callPackage ../nix-updates/parsec/3.1.6.nix {};
        diagramsCore= self.callPackage ../core {};
        diagramsLib = self.callPackage ./. {};
      };
    };
 in pkgs.lib.overrideDerivation haskellPackages.diagramsLib (attrs: {
   buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })