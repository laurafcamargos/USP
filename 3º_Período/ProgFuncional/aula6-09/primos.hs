import Control.Monad (guard)

primos :: [Int]
primos = p [2..]
  where
    p (h:t) = h : p [x | x <- t, x `mod` h /= 0]

main :: IO ()
main = do
  let n = 20  -- Altere o valor de 'n' conforme necessário
  let resultado = take n primos
  putStrLn $ "Os primeiros " ++ show n ++ " números primos são: "
  putStrLn $ show resultado
