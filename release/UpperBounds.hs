{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE OverloadedStrings    #-}

-- | Bump upper bounds in .cabal files, update changelogs, commit to git.

module Main where

import           Control.Monad
import           Data.Foldable
import           Data.List.Split                       (splitWhen)
import           Data.Semigroup
import           Data.Text                             (Text)
import qualified Data.Text                             as T
import qualified Distribution.Package                  as C
import qualified Distribution.PackageDescription.Parse as C
import qualified Distribution.Verbosity                as C
import qualified Distribution.Version                  as C
import qualified Filesystem.Path.CurrentOS             as FP
import           Shelly

-- TODO imports for GHC < 7.10?

import           Prelude                               hiding (FilePath)

main :: IO ()
main = shelly $ do
    goals <- filterM (needsUpdate example) repos
    echo "preparing to update .cabal files for:"
    echo $ T.unwords $ map toTextIgnore goals
    traverse_ (updateCabal example) goals
    -- cleanBuild repos
    -- traverse_ (commitAll "test cabal changes") goals
    traverse_ (commitChanges example) goals
    echo "The following packages were modified:"
    echo $ T.unwords $ map toTextIgnore goals

data Package = Pkg
               { name    :: Text
               , version :: Text
               }

formatPkg :: Package -> Text
formatPkg (Pkg n v) = mconcat [n, "-", v]

cabalFilename :: FilePath -> Sh FilePath
cabalFilename repo = do
    files <- ls repo
    case filter (`FP.hasExtension` "cabal") files of
      (fn:_) -> return fn
      _ -> errorExit $ "Could not find .cabal file in: " <> toTextIgnore repo

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
    sed_ ["s/\\(", pkg, ".*\\)< [0-9\\.]*/\\1< ", v, "/"] fn

sed_ :: [Text] -> FilePath -> Sh ()
sed_ parts fn = cmd "sed" "-i" (mconcat parts) fn

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

today :: Sh Text
today = T.strip <$> cmd "date" "+%d %b %Y"

gitCommit :: Text -> Sh ()
gitCommit msg  = cmd "git" "commit" "-am" msg

commitChanges :: Package -> FilePath -> Sh ()
commitChanges pkg repo = chdir repo $ do
    -- .cabal file already changed
    gitCommit $ "cabal: allow " <> formatPkg pkg
    fn <- cabalFilename =<< pwd
    description <- liftIO $ C.readPackageDescription C.normal . FP.encodeString $ fn
    let oldVer = C.packageVersion description
    let newVer = bumpVersion oldVer
    sed_ ["s/\\(^[Vv]ersion: *\\)[0-9\\.]*/\\1", showVersion newVer, "/"] fn
    gitCommit $ "bump version to " <> showVersion newVer
    (clFN, oldCL) <- readChangelog
    date <- today
    writefile clFN $ changelog newVer date pkg <> oldCL
    gitCommit $ "CHANGELOG for " <> showVersion newVer

showVersion :: C.Version -> Text
showVersion (C.Version ns _tags) = T.intercalate "." $ map (T.pack . show) ns

bumpVersion :: C.Version -> C.Version
bumpVersion (C.Version ns tags) = C.Version ns' tags where
  ns' = case ns of
      [] -> [0,0,0,1] -- is this possible?
      [a] -> [a,0,0,1]
      [a,b] -> [a,b,0,1]
      [a,b,c] -> [a,b,c,1]
      (a:b:c:d:e) -> (a:b:c:d+1:e)

changelog :: C.Version -> Text -> Package -> Text
changelog newVer date pkg =
    mconcat ["## ", showVersion newVer, " (", date, ")\n"
            , "\n"
            , "allow ", formatPkg pkg, "\n"
            , "\n"
            ]

readChangelog :: Sh (FilePath, Text)
readChangelog = do
    dir <- pwd
    fns <- ls dir
    case filter (T.isPrefixOf "CHANGE" . toTextIgnore . FP.filename) fns of
     [] -> errorExit $ "Could not find Changelog in " <> toTextIgnore dir
     [fn] -> do
         contents <- readfile fn
         return (fn, contents)
     fns -> errorExit $ "Could not choose among: " <> T.unwords (map toTextIgnore fns)

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
