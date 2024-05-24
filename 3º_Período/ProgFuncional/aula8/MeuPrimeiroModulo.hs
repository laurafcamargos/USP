-- Criando um módulo

-- Cria um módulo exportando todas as funções
-- module MeuPrimeiroModulo where

-- Cria um módulo exportando apenas o nub
-- module MeuPrimeiroModulo (nub) where

-- Cria um módulo exportando apenas o nub e o inits de outro módulo
module MeuPrimeiroModulo (nub, inits) where
import Data.List hiding (nub)

nub :: Integer -> Integer
nub x = 42 + x

sort :: [Integer] -> [Char]
sort _ = "Não Deu!!"