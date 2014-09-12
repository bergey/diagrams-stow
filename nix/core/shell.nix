let pkgs = import <nixpkgs> {};
    haskellPackages = pkgs.haskellPackages.override {
      extension = self: super: {
        diagramsCore= self.callPackage ./. {};
      };
    };
 in pkgs.lib.overrideDerivation haskellPackages.diagramsCore (attrs: {
   buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
 })