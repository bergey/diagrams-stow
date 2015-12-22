 for pkg in monoid-extras dual-tree active force-layout palette solve statestack SVGFonts core lib contrib svg cairo postscript rasterific canvas html5 builder haddock docutils pandoc povray ghcjs reflex openscad; do
     packdeps $pkg/*.cabal
done
