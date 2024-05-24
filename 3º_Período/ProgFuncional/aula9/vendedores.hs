import System.IO 
import Debug.Trace
import Data.Ord
import Data.List

data Data = Data { ano :: Integer, mes :: Integer, dia :: Integer }
  deriving (Show, Read)

type Idade = Integer

type Venda = Integer

data Vendedor = Vendedor {
  nome :: [Char],
  cpf :: [Char],
  uf :: [Char],
  aniversario :: Data,
  dependentes :: [Idade],
  vendas :: [Venda]
}
  deriving (Show, Read)

processaVendedores :: [Char] -> [Vendedor]
processaVendedores l = map read $ lines l

main = do
  h <- openFile "vendedores.txt" ReadMode
  l <- hGetContents h
  let vendedores = processaVendedores l
  -- Nome de todos os vendedores
  putStrLn $ 
    show $ 
    map nome $
    vendedores
  -- Primeiro nome de todos os vendedores
  putStrLn $
    show $
    map head $
    map words $
    map nome $
    vendedores
  -- Primeiro nome de todos os vendedores
  putStrLn $
    show $
    map (head.words.nome) $
    vendedores
  -- Soma das vendas de SP
  putStrLn $
    show $
    sum $
    map (sum.vendas) $
    filter ((=="SP").uf) $
    vendedores
  -- Segundo nome dos vendedores de PR que tenham pelo menos dois dependentes
  putStrLn $
    show $
    map ((!!1).words.nome) $
    filter ((=="PR").uf) $
    filter ((>=2).length.dependentes) $
    vendedores
  -- Os 3 vendedores que menos venderam entre os 10 vendedores com menos dependentes no estado de SP
  putStrLn $
    show $
    map ((!!0).words.nome) $
    take 3 $
    sortBy (comparing (sum.vendas)) $
    -- sortBy (\v1 v2 -> if (sum $ vendas $ v1) < (sum $ vendas $ v2) then LT else if (sum $ vendas $ v1) == (sum $ vendas $ v2) then EQ else GT) $
    take 10 $
    sortBy (comparing (length.dependentes)) $
    -- sortBy (\v1 v2 -> if (length $ dependentes $ v1) < (length $ dependentes $ v2) then LT else if (length $ dependentes $ v1) == (length $ dependentes $ v2) then EQ else GT) $
    filter ((=="SP").uf) $
    vendedores
  -- Os 3 vendedores que menos venderam entre os 10 vendedores com mais dependentes no estado de SP
  putStrLn $
    show $
    map ((!!0).words.nome) $
    take 3 $
    sortBy (comparing (sum.vendas)) $
    take 10 $
    sortBy (flip (comparing (length.dependentes))) $
    -- sortBy (comparing ((0-).length.dependentes)) $
    filter ((=="SP").uf) $
    vendedores
  putStrLn $
    show $
    proc4 $
    vendedores
  putStrLn $
    show $
    somaVenda $
    vendedores
  hClose h
  putStrLn "Ok!"

f :: Maybe Integer -> Integer
f(Just a) = a
f Nothing = -1 --flag de que não achou nenhum vendedor

proc1 :: [Vendedor] -> Integer
proc1 l =
        sum $
    vendas $
    head $
    filter ((>20).length.dependentes) $
    l

proc2 :: [Vendedor] -> Integer --esse ja funciona, mas ta feio
proc2 l =
    case (filter((>20).length.dependentes)l) of
        [] -> 0
        (h:_) -> sum $ vendas h


proc3 :: [Vendedor] -> Integer 
proc3 l =
    case (find((>20).length.dependentes)l) of --filter filtra todos os true e o find acha o primeiro true e retorna ele
        Nothing -> 0                                --find retorna um maybe
        Just h -> sum $ vendas h

-- find :: (a-> Bool) -> [a] -> Maybe a
--data Maybe a = Nothing | Just a
--just é um construtor pra virar um maybe
--ainda nao resolvemos a ambiguidade de nao achei nenhum vendedor com achei um vendedor que nao vendeu nada

proc4 :: [Vendedor] -> Maybe Integer 
proc4 l = 
    case (find((>20).length.dependentes)l) of 
    Nothing -> Nothing                                
    Just h -> Just $ sum $ vendas h

somaVenda1 :: [Vendedor] -> Maybe Integer
somaVenda1 l = 
    case (find((=="SP").uf)l) of
        Nothing -> Nothing
        Just v1 -> case (find((=="AC").uf)l) of
            Nothing -> Nothing
            Just v2 -> Just $ (sum $ vendas v1) + (sum $ vendas v2)

--somaVenda 1 é igual a somaVenda 

somaVenda :: [Vendedor]-> Maybe Integer
somaVenda l = do             --se der um nothing no primeiro, ele ja para, pq nao faz sentido 
    v1 <-find((=="SP").uf) l --retorna um maybe vendedor e o v1 é o que achou 
    v2 <- find((=="AC").uf) l --procura um vendedor no acre e o v2 é o que achou
    let s = (sum $ vendas v1) + (sum $ vendas v2)
    Just s

