 for pkg in active core lib contrib statestack svg cairo postscript rasterific canvas SVGFonts builder haddock docutils pandoc povray; do
     packdeps $pkg/*.cabal
done
