sinal :: (Ord a, Num a) => a -> Int
sinal x
  | x > 0     = 1
  | x == 0    = 0
  | otherwise = -1 

main :: IO ()
main = do
  let x = -655
  putStrLn $ "O sinal de " ++ show x ++ " é: " ++ show (sinal x)

