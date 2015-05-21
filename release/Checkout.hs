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
    -- smaller dependencies
    [ ("monoid-extras", "master")
    , ("dual-tree", "master")
    , ("active", "master")
    , ("force-layout", "master")
    , ("palette", "master")
    , ("SVGFonts", "master")
    , ("solve", "master")
    , ("statestack", "master")
      -- core packages
    , ("core", "master")
    , ("lib", "lib-1.3")
    , ("contrib", "master")
      -- Backend Deps
      -- ("texrunner", )
      -- ("lucid-svg", )
      -- ("static-canvas", )
      -- Backends
    , ("cairo", "master")
    , ("gtk", "master")
    -- , ("html5", )
    -- , ("canvas", "canvas-0.3")
    , ("postscript", "postscript-1.3")
    -- , ("pgf", )
    , ("rasterific", "rasterific-1.3")
    , ("svg", "master")
      -- builder
    , ("builder", "master")
    , ("haddock", "master")
    ]
