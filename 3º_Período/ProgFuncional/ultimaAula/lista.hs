function' :: (Num b) => [a] -> b
function' [] = 0
function' (_:xs) = 1 + function' xs

main :: IO ()
main = do
  let myList = ["a","b"]
  let result = function' myList
  putStrLn ("Número de elementos na lista: " ++ show result)
