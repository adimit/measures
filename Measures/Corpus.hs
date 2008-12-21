-- |
-- Module      : Measures.Corpus
-- Copyright   : 2008 Aleksandar Dimitrov
-- License     : BSD3
--
-- Maintainer  : Aleksandar Dimitrov <aleks.dimitrov@gmail.com>
-- Stability   : stable
-- Portability : portable
--
-- Data structure definitions for Corpora and entries in the main Data.Map.

module Measures.Corpus where

import qualified Data.Map as M
import qualified Data.ByteString.Lazy.Char8 as L

-- | A map that maps the category names to the number of times it has
--   been used by a specific annotator.
type Category = M.Map L.ByteString (Int,Int)

-- | A strict data structure storing a corpus.
data Corpus = Corpus { items      :: !Int -- ^ The total number of items in the Corpus
                     , agreement  :: !Int -- ^ The total number of items the two annotators agree upon
                     , categories :: !Category  -- ^ The observed categories and their annotation counts
                     }

-- | List statistics of a corpus.
instance Show Corpus where
        show (Corpus i a c) = "Agreement: " ++ show a ++ " of " ++ show i
                            ++ " items. (" ++ (show $ fromIntegral a / fromIntegral i) ++")\n" 
                            ++ "Categories #: " ++ (show $ M.size c) ++ "\n"
                            ++ M.foldWithKey (\k (c1,c2) s ->  L.unpack k ++ ": (" 
                                                           ++ show c1 ++ "," 
                                                           ++ show c2 ++ ")\n" ++ s) "" c
