module Main where

fatorial :: Integer -> Integer
fatorial 0 = 1
fatorial n = n * fatorial (n - 1)

main :: IO ()
main = do
  putStrLn "Digite um número para calcular o fatorial:"
  input <- getLine
  let numero = read input :: Integer
  putStrLn ("O fatorial de " ++ input ++ " é " ++ show (fatorial numero))