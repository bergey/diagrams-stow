{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE OverloadedStrings    #-}
{-# OPTIONS_GHC -fno-warn-type-defaults #-}

-- | Checkout release branches of Diagrams packages.

module Main where

import           Prelude       hiding (FilePath, foldl, foldl1, foldr, foldr1,
                                head, init, last, lines, map, mapM, mapM_,
                                sequence, sequence_, tail, (!!), (++))

import           Data.Foldable
import           Data.Text     hiding (filter, map)
import           Shelly

main :: IO ()
main = shelly $ mapM_ checkout branches

checkout :: (FilePath, Text) ->  Sh ()
checkout (dir, branch) = chdir dir $
                         cmd "git" "checkout" branch

branches :: [(FilePath, Text)]
branches =
    [ ("core", "core-1.2")
    , ("lib", "lib-1.2")
    , ("contrib", "contrib-1.1")
    , ("cairo", "cairo-1.2")
    , ("canvas", "canvas-0.3")
    , ("postscript", "postscript-1.1")
    , ("rasterific", "rasterific-0.1")
    , ("svg", "svg-1.1")
    , ("SVGFonts", "SVGFonts-1.3")
    , ("builder", "builder-0.6")
    , ("haddock", "haddock-0.2")
    , ("stow", "release")
    ]
