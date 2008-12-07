module Corpus where

-- | Data structures for corpora

import qualified Data.Map as M
import qualified Data.ByteString.Lazy.Char8 as L

type Category = M.Map L.ByteString (Int,Int)

-- | A strict data structure storing a corpus.
data Corpus = Corpus { items      :: !Int
                     , agreement  :: !Int
                     , categories :: !Category 
                     }

-- | List statistics of a corpus.
instance Show Corpus where
        show (Corpus i a c) = "Agreement: " ++ show a ++ " of " ++ show i
                            ++ " items.\n" ++ "Categories #: " ++ (show $ M.size c) ++ "\n"
                            ++ M.foldWithKey (\k (c1,c2) s ->  L.unpack k ++ ": (" 
                                                           ++ show c1 ++ "," 
                                                           ++ show c2 ++ ")\n" ++ s) "" c
