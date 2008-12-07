module Corpus where

import qualified Data.Map as M
import qualified Data.ByteString.Lazy.Char8 as L

type Category = M.Map L.ByteString (Int,Int)

data Corpus = Corpus { items      :: !Int
                     , agreement  :: !Int
                     , categories :: !Category 
                     }

instance Show Corpus where
        show (Corpus i a c) = "Agreement: " ++ show a ++ " of " ++ show i
                            ++ " items.\n" ++ "Categories #: " ++ (show $ M.size c) ++ "\n"
                            ++ M.foldWithKey (\k (c1,c2) s ->  L.unpack k ++ ": (" 
                                                           ++ show c1 ++ "," 
                                                           ++ show c2 ++ ")\n" ++ s) "" c
