module Main where

import System.Environment   

import qualified BF

main = do
    args <- getArgs

    BF.eval $ head args
