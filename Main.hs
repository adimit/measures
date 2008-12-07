module Main where

import Prelude hiding (pi)
import System.Environment (getArgs)
import Data.List (foldl')
import qualified Data.Map as M
import qualified Data.ByteString.Lazy.Char8 as C
import Corpus
import Measures

gatherData :: Corpus -> C.ByteString -> Corpus
gatherData (Corpus i a c) line = Corpus (i+1)  a' c'
            where (_:ac1:ac2:_)        = C.split '\t' line
                  (c',a') | ac1 == ac2 = (M.insertWith' (<+>) ac1 (1,1) c,a+1)
                          | otherwise  = (M.insertWith' (<+>) ac1 (1,0) $ M.insertWith' (<+>) ac2 (0,1) c,a)
                  (<+>) (v,w) (x,y)    = (w+y) `seq` (v+x) `seq` (,) (v+x) (w+y)

main :: IO ()
main = do args  <- getArgs
          case args of
               []    -> putStrLn "Please provide a file name." 
               (x:_) -> do input <- C.readFile x 
                           let corpus = foldl' gatherData (Corpus 0 0 M.empty) $ C.lines input
                           putStrLn $ show corpus
                           let s' = eval corpus s
                           putStrLn $ "S-Measure: " ++ show s'
                           let a = eval corpus pi
                           putStrLn $ "Alpha-Measure: " ++ show a
                           let k = eval corpus kappa
                           putStrLn $ "Kappa-Measure: " ++ show k

