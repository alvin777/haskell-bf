module BF where

import Data.Char
import Debug.Trace

--  >   - ++ptr
--  <   - --ptr
--  +   - ++*ptr
--  -   - --*ptr
--  .   - putchar(*ptr)
--  ,   - *ptr = getchar()
--  [   - while (*ptr) {
--  ]   - }

-- left right
data Memory = Memory [Int] [Int] deriving (Show)

-- program stack mem input
data State = State String [String] Memory String deriving (Show)


mapFirst :: (a -> a) -> [a] -> [a]
mapFirst f list = (f x):xs where (x:xs) = list

inc :: Memory -> Memory
inc (Memory left right) = Memory left $ mapFirst (+1) right

dec :: Memory -> Memory
dec (Memory left right) = Memory left $ mapFirst (\x -> x - 1) right

shiftLeft :: Memory -> Memory
shiftLeft (Memory left right) = Memory ((head right):left) $ tail right

shiftRight :: Memory -> Memory
shiftRight (Memory left right) = Memory (tail left) $ ((head left):right)

load :: Memory -> Int
load (Memory _ right) = head right

store :: Memory -> Int -> Memory
store (Memory left right) value = Memory left $ value:(tail right)

exec :: State -> (State, String)

exec (State ('+':rest) stack memory input) = 
    (State rest stack (inc memory) input, "")

exec (State ('-':rest) stack memory input) = 
    (State rest stack (dec memory) input, "")

exec (State ('>':rest) stack memory input) = 
    (State rest stack (shiftLeft memory) input, "")

exec (State ('<':rest) stack memory input) = 
    (State rest stack (shiftRight memory) input, "")

exec (State ('.':rest) stack memory input) = 
    (State rest stack memory input, [chr $ load memory])

exec (State (',':rest) stack memory (inputHead:inputTail)) = 
    (State rest stack (store memory $ ord inputHead) inputTail, "")

-- 0  – jump to next command after ']'
-- !0 - push, continue
exec (State ('[':rest) stack memory input) = 
    case load memory of
        0 -> (State programAfterClosingBracket (rest:stack) memory input, "")
              where programAfterClosingBracket = (tail $ dropWhile (/=']') rest)
        _ -> (State rest (rest:stack) memory input, "")

exec (State (']':rest) stack memory input) = 
    case load memory of
        0 -> (State rest (tail stack) memory input, "")
        _ -> (State (head stack) stack memory input, "")


pureEval' :: State -> String
pureEval' (State [] _ _ _ ) = []
pureEval' aState = do
    let (state, output) = exec aState
    trace (show (state, output)) $ output ++ pureEval' state


pureEval :: String -> String -> String
--pureEval program input = pureEval' $ State program [] (Memory [] $ repeat 0) input
pureEval program input = pureEval' $ State program [] (Memory [] $ replicate 10 0) input


prefetchInput :: State -> IO State
prefetchInput (State program@(',':rest) stack memory input) = do 
    c <- getChar
    return(State program stack memory $ input ++ [c]) 

prefetchInput state = return(state)

eval' :: State -> IO State
eval' state@(State [] _ _ _ ) = return state
eval' aState = do 
    prefetchedState <- prefetchInput aState
    let (state, output) = exec prefetchedState
    putStr output
    eval' state

eval :: String -> IO ()
eval program = do 
    --_ <- eval' $ State program [] (Memory [] $ repeat 0) []
    _ <- eval' $ State program [] (Memory [] $ replicate 10 0) []
    return()
