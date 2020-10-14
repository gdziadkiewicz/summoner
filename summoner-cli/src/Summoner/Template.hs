{- |
Module                  : Summoner.Template
Copyright               : (c) 2017-2020 Kowainik
SPDX-License-Identifier : MPL-2.0
Maintainer              : Kowainik <xrom.xkov@gmail.com>
Stability               : Stable
Portability             : Portable

This module contains functions for the Haskell project template creation.
-}

module Summoner.Template
       ( createProjectTemplate
       ) where

import Summoner.Settings (Settings (..), BuildSystem(..))
import Summoner.Template.Cabal (cabalFile)
import Summoner.Template.Doc (docFiles)
import Summoner.Template.GitHub (gitHubFiles)
import Summoner.Template.Haskell (haskellFiles)
import Summoner.Template.Stack (stackFiles)
import Summoner.Tree (TreeFs (..), insertTree)


-- | Creating tree structure of the project.
createProjectTemplate :: Settings -> TreeFs
createProjectTemplate settings@Settings{..} = Dir
    (toString settingsRepo)
    (foldr insertTree generatedFiles settingsFiles)
  where
    generatedFiles :: [TreeFs]
    generatedFiles = concat
        [ cabal
        , stack
        , haskell
        , docs
        , gitHub
        ]
    useStack = settingsBuildSystem `elem` [UseStack, UseCabalAndStack]
    cabal, stack :: [TreeFs]
    cabal = [cabalFile settings]
    stack = memptyIfFalse useStack $ stackFiles settings

    haskell, docs, gitHub :: [TreeFs]
    haskell = haskellFiles settings
    docs    = docFiles settings
    gitHub  = gitHubFiles settings
