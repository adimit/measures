module Main where

-- | This module provides implementation-specific details. In particular
--   it reads in the data format and turns the relevant data in the corpus
--   into a 'Corpus' data structure.

import Prelude hiding (pi)
import System.Environment (getArgs)
import Data.List (foldl')
import qualified Data.Map as M
import qualified Data.ByteString.Lazy.Char8 as C
import Corpus
import Measures

-- | Recursive fold accumulator. Reads per-line data into the 'Corpus' data
--   structure.
gatherData :: Corpus -> C.ByteString -> Corpus
gatherData (Corpus i a c) line = Corpus (i+1)  a' c'
            where (_:ac1:ac2:_)        = C.split '\t' line -- second and third column
                  (c',a') | ac1 == ac2 = (M.insertWith' (<+>) ac1 (1,1) c,a+1) -- if they are the same, 
                                                                               -- perform only one lookup
                          | otherwise  = (M.insertWith' (<+>) ac1 (1,0) $ M.insertWith' (<+>) ac2 (0,1) c,a)
                  (<+>) (v,w) (x,y)    = (w+y) `seq` (v+x) `seq` (,) (v+x) (w+y) -- add Int pairs strictly

main :: IO ()
main = do args  <- getArgs
          case args of
               []    -> putStrLn "Please provide a file name." 
               (x:_) -> do input <- C.readFile x 
                           let corpus = foldl' gatherData (Corpus 0 0 M.empty) $ C.lines input
                           putStrLn $ show corpus
                           let s' = eval corpus s
                           putStrLn $ "S-Measure: " ++ show s'
                           let p = eval corpus pi
                           putStrLn $ "pi-Measure: " ++ show p
                           let k = eval corpus kappa
                           putStrLn $ "Kappa-Measure: " ++ show k

