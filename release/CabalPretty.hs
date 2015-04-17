{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# OPTIONS_GHC -fno-warn-type-defaults #-}

-- | Test how Cabal pretty prints .cabal files

module Main where

import Prelude hiding
    (foldl, foldl1, foldr, foldr1
    , mapM, mapM_, sequence, sequence_
    , head, tail, last, init, map, (++), (!!), FilePath, lines)

import Distribution.PackageDescription
import Distribution.PackageDescription.Parse
import Distribution.PackageDescription.PrettyPrint
import Distribution.Verbosity

import Data.Monoid
import Data.Text hiding (map, filter)
import Data.Text.Encoding
import qualified Data.Text as T
import Data.Foldable
import Shelly
import Data.String (IsString)

import Text.Regex.PCRE
import Text.Regex.Base

filename :: IsString s => s
filename = "diagrams-core.cabal"

main :: IO ()
main = shelly $ do
    rawCabal <- readfile filename
    pkg <- liftIO $ readPackageDescription normal filename
    writefile "native-parse" . T.pack . show $ pkg
    liftIO $ writeGenericPackageDescription "pretty-print.cabal" pkg
    case match pkgVersionRe (encodeUtf8 rawCabal) of



pkgVersionRe :: Regex
pkgVersionRe = makeRegex "(Version: *)([0-9.]+)"

dependencyRe :: Regex
dependencyRe = makeRegex "(text *>=? *[0-9.]+ *&& *<=? *)[0-9.]*"

instance Extract Text where
    before = T.take
    after = T.drop
    empty = mempty
