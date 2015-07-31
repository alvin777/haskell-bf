module Main where

import qualified BF



main = do
    let memLeft = [] 
    --let mem = replicate 100 0
    let memRight = take 100 [1,2..]

    --(memLeft, memRight) <- exec '.' memLeft memRight
    --print (memLeft, memRight)
    
    --(memLeft, memRight) <- exec ',' memLeft memRight
    --print (memLeft, memRight)
    input <- getLine
    BF.eval input memLeft memRight
