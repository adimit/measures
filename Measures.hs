module Measures where

import Corpus
import qualified Data.Map as M 

s :: Corpus -> Double 
s (Corpus _ _ c) = 1.0/(fromIntegral (M.size c))

pi :: Corpus -> Double 
pi (Corpus i _ c) = (1.0/(4.0*(fromIntegral (i*i)))) * (fromIntegral (M.fold (\(a,b) n -> ((a+b)^2)+n) 0 c))

kappa :: Corpus -> Double 
kappa (Corpus i _ c) = (1.0/(fromIntegral (i*i))) * (fromIntegral (M.fold (\(a,b) n -> (a*b)^2 +n) 0 c))

eval :: Corpus -> (Corpus -> Double) -> Double 
eval corpus@(Corpus i a _) m = (observed - expected) / (1 - expected)
                        where observed = (fromIntegral a)/(fromIntegral i)
                              expected = m corpus
