module BF where

--  >   - ++ptr
--  <   - --ptr
--  +   - ++*ptr
--  -   - --*ptr
--  .   - putchar(*ptr)
--  ,   - *ptr = getchar()
--  [   - while (*ptr) {
--  ]   - }

exec :: String -> [String] -> [Int] -> [Int] -> IO (String, [String], [Int], [Int])

exec ('+':rest) stack memLeft memRight = do
    let e:es = memRight
    return (rest, stack, memLeft, (e+1):es)

exec ('-':rest) stack memLeft memRight = do
    let e:es = memRight
    return (rest, stack, memLeft, (e-1):es)

exec ('>':rest) stack memLeft memRight = do
    let e:es = memRight
    return (rest, stack, e:memLeft, es)

exec ('<':rest) stack memLeft memRight = do
    let e:es = memLeft
    return (rest, stack, es, e:memRight)

exec ('.':rest) stack memLeft memRight = do
    print $ head memRight
    --putChar $ Chr $ head memRight
    return (rest, stack, memLeft, memRight)

exec (',':rest) stack memLeft memRight = do 
    num_str <- getLine
    let num = read num_str :: Int
    --print num
    let e:es = memRight
    return (rest, stack, memLeft, num:es)

exec ('[':rest) stack memLeft memRight
    | cur == 0 = do
        return (tail (dropWhile (/=']') rest), rest:stack, memLeft, memRight)
    | cur /= 0 = 
        return (rest, rest:stack, memLeft, memRight)
    where cur = head memRight

exec (']':rest) stack memLeft memRight
    | cur == 0 = do
        return (rest, tail stack, memLeft, memRight)
    | cur /= 0 = 
        return (head stack, stack, memLeft, memRight)
    where cur = head memRight


eval :: String -> [String] -> [Int] -> [Int] -> IO ()

eval [] _ _ _ = return ()

eval expr stack memLeft memRight = do
    --print x
    (expr, stack, memLeft, memRight) <- exec expr stack memLeft memRight
    eval expr stack memLeft memRight
