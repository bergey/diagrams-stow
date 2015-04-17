 for pkg in  monoid-extras dual-tree core active solve lib SVGFonts palette force-layout contrib statestack cairo gtk postscript rasterific svg canvas html5 diagrams builder haddock; do
     packdeps $pkg/*.cabal
done
