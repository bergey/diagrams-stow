 for pkg in active core lib contrib statestack svg cairo postscript rasterific canvas SVGFonts builder haddock docutils povray; do
     packdeps $pkg/*.cabal
done
