 for pkg in monoid-extras dual-tree active force-layout palette solve statestack SVGFonts core lib contrib svg cairo postscript rasterific canvas builder haddock docutils pandoc povray; do
     packdeps $pkg/*.cabal
done
