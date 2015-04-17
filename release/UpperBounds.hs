{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE OverloadedStrings    #-}

-- | Bump upper bounds in .cabal files, update changelogs, commit to git.

module Main where

import           Control.Monad
import           Data.Foldable
import           Data.List.Split           (splitWhen)
import           Data.Semigroup
import           Data.Text                 (Text)
import qualified Data.Text                 as T
import qualified Filesystem.Path.CurrentOS as FP
import           Shelly

-- TODO imports for GHC < 7.10?

import           Prelude                   hiding (FilePath)

main :: IO ()
main = shelly $ do
    goals <- filterM (needsUpdate example) repos
    echo "preparing to update .cabal files for:"
    echo $ T.unwords $ map toTextIgnore goals
    traverse_ (updateCabal example) goals
    cleanBuild repos

data Package = Pkg
               { name    :: Text
               , version :: Text
               }

cabalFilename :: FilePath -> Sh FilePath
cabalFilename repo = do
    files <- ls repo
    case filter (`FP.hasExtension` "cabal") files of
      (fn:_) -> return fn
      _ -> errorExit $ "Did not find .cabal file in: " <> toTextIgnore repo

-- | Test whether a given repo needs updating for the given package and version
needsUpdate :: Package -> FilePath -> Sh Bool
needsUpdate (Pkg pkg v) repo = errExit False $ do
    fn <- cabalFilename repo
    match <- cmd "grep" (pkg <> ".*<") fn
    exit <- lastExitCode
    case exit of
      1 -> return False
    -- pkg is used, but maybe all the lines are up to date
      0 -> return . not $ all (v `T.isInfixOf`) (T.lines match)
      _ -> errorExit $ "grep exited with code " <> (T.pack . show $ exit)

-- | Modify a cabal file in place
updateCabal :: Package -> FilePath -> Sh ()
updateCabal (Pkg pkg v) repo = do
    fn <- cabalFilename repo
    -- TODO Don't use regexen
    cmd "sed" "-i" (mconcat ["s/\\(", pkg, ".*\\)< [0-9\\.]*/\\1< ", v, "/"]) fn

cabal_ :: Text -> [Text] -> Sh ()
cabal_ = command1_ "cabal" []

cabal :: Text -> [Text] -> Sh Text
cabal = command1 "cabal" []

createSandbox  :: Sh ()
createSandbox = cabal_ "sandbox" ["init"]

addSource :: [Text] -> Sh ()
addSource [] = return ()
addSource dirs = command_ "cabal" ["sandbox", "add-source"] dirs

getAddSource :: Sh [Text]
getAddSource = do
    inSandbox <- test_f "cabal.sandbox.config"
    if inSandbox then do
        cout <- cabal "sandbox" ["list-sources"]
        return $ case splitWhen T.null (T.lines cout) of
            (_:dirs: _) -> dirs -- middle of 3
            _ -> []
        else return []

cleanSandbox :: Sh ()
cleanSandbox = do
    dirs <- getAddSource
    cabal_ "sandbox" ["delete"]
    createSandbox
    addSource dirs

cleanBuild :: [FilePath] -> Sh ()
cleanBuild repos =  do
    cleanSandbox
    cabal_ "install" $ map (flip T.snoc '/' . toTextIgnore) repos

    -- Hardcoded for development; should be read from CLI

repos :: [FilePath]
repos =
    [ "monoid-extras"
    , "dual-tree"
    , "core"
    , "active"
    , "solve"
    , "lib"
    , "SVGFonts"
    , "palette"
    , "force-layout"
    , "contrib"
    , "statestack"
    , "cairo"
    , "gtk"
    , "postscript"
    , "rasterific"
    , "svg"
    , "canvas"
    , "html5"
    , "builder"
    , "haddock"
    ]

-- TODO parse "package<version" from argument
example = Pkg "lens" "4.11"
