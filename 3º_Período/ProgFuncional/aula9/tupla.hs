avaliarTupla :: (Int, String) -> String
avaliarTupla tupla = case tupla of
  (0, str) -> "Primeiro elemento é zero: " ++ str
  (num, str) -> "Primeiro elemento é diferente de zero: " ++ str


main :: IO ()
main = do
  let n = (0, "oi")
  putStrLn $ avaliarTupla n
