-- | This module contains some default values to use.

module Summoner.Default
       ( defaultGHC
       , defaultTomlFile
       , defaultConfigFile
       , defaultDescription
       , currentYear
       ) where

import Data.Time (getCurrentTime, toGregorian, utctDay)
import System.Directory (getHomeDirectory)
import System.FilePath ((</>))

import Summoner.GhcVer (GhcVer)

----------------------------------------------------------------------------
-- Default Settings
----------------------------------------------------------------------------

-- | Default GHC version is the latest available.
defaultGHC :: GhcVer
defaultGHC = maxBound

defaultTomlFile :: FilePath
defaultTomlFile = ".summoner.toml"

defaultConfigFile :: IO FilePath
defaultConfigFile = (</> defaultTomlFile) <$> getHomeDirectory

defaultDescription :: Text
defaultDescription = "See README for more info"

currentYear :: IO Text
currentYear = do
    now <- getCurrentTime
    let (year, _, _) = toGregorian $ utctDay now
    pure $ show year