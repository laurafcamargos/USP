filtro :: (a -> Bool) -> [a] -> [a]
filtro teste [] = []
filtro teste (h:t)
  | teste h   = h : filtro teste t
  | otherwise = filtro teste t

main :: IO ()
main = do
  let numeros = [-3,-2,-1,0,1,2,3]
  putStrLn $ "Lista original: " ++ show numeros
  putStrLn $ "Lista filtrada: " ++ show (filtro maiorQueZero numeros)
