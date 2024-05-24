main = do
    putStrLn "Hello World"
    putStrLn (show(soma 5 7))
    s <- soma2 15 17
    putStrLn (show(s))

soma :: Integer -> Integer -> Integer
soma x y = x + y

soma2 :: Integer -> Integer -> IO Integer
soma2 x y = do
    putStrLn "Gimme Manei"//acontece na linha 5
    return (x+y)