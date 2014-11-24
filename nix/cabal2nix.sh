for pkg in active core lib contrib statestack svg cairo postscript rasterific canvas SVGFonts builder haddock docutils povray; do
    cd ~/code/diagrams/$pkg
    cabal2nix ./. > default.nix     
done
