-- |
-- Module      : Measures
-- Copyright   : 2008 Aleksandar Dimitrov
-- License     : BSD3
--
-- Maintainer  : Aleksandar Dimitrov <aleks.dimitrov@gmail.com>
-- Stability   : stable
-- Portability : portable
--
-- A module for performing arithmetic on annotated corpora.

module Measures where

import Measures.Corpus
import qualified Data.Map as M 

-- | S-Measure
s :: Corpus -> Double 
s (Corpus _ _ c) = 1.0/(fromIntegral (M.size c))

-- | Pi-Measure
pi :: Corpus -> Double 
pi (Corpus i _ c) = (1.0/(4.0*(fromIntegral (i*i)))) * (fromIntegral (M.fold (\(a,b) n -> ((a+b)^2)+n) 0 c))

-- | Kappa-Measure
kappa :: Corpus -> Double 
kappa (Corpus i _ c) = (1.0/(fromIntegral (i*i))) * (fromIntegral (M.fold (\(a,b) n -> (a*b)^2 +n) 0 c))

-- | Evaluate a corpus according to a corpus evaluation function (pi, kappa, s…)
eval :: Corpus -> (Corpus -> Double) -> Double 
eval corpus@(Corpus i a _) m = (observed - expected) / (1 - expected)
                        where observed = (fromIntegral a)/(fromIntegral i)
                              expected = m corpus
