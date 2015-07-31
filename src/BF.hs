module BF where

--  >   - ++ptr
--  <   - --ptr
--  +   - ++*ptr
--  -   - --*ptr
--  .   - putchar(*ptr)
--  ,   - *ptr = getchar()
--  [   - while (*ptr) {
--  ]   - }

exec :: Char -> [Int] -> [Int] -> IO ([Int], [Int])

exec '+' memLeft memRight = do
    let e:es = memRight
    return (memLeft, (e+1):es)

exec '-' memLeft memRight = do
    let e:es = memRight
    return (memLeft, (e-1):es)

exec '>' memLeft memRight = do
    let e:es = memRight
    return (e:memLeft, es)

exec '<' memLeft memRight = do
    let e:es = memLeft
    return (es, e:memRight)

exec '.' memLeft memRight = do
    print $ head memRight
    --putChar $ Chr $ head memRight
    return (memLeft, memRight)

exec ',' memLeft memRight = do 
    num_str <- getLine
    let num = read num_str :: Int
    --print num
    let e:es = memRight
    return (memLeft, num:es)


eval :: String -> [Int] -> [Int] -> IO ()

eval [] _ _ = return ()

eval (x:xs) memLeft memRight = do
    --print x
    (memLeft, memRight) <- exec x memLeft memRight
    eval xs memLeft memRight
