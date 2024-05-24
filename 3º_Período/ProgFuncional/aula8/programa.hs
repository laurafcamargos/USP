-- Usando módulos em haskell

--  Importa tudo de Data.List
-- import Data.List

-- Importa apenas o sort de Data.List
-- import Data.List (sort)

-- Importa tudo menos o nub de Data.List
-- import Data.List hiding (nub)

-- Importa de maneira qualificada, para assim não gerar confiltos entre módulos
-- import qualified Data.List

-- Importa de maneira qualificada, para assim não gerar confiltos entre módulos,
-- e ainda cria um alias para o nome do módulo
import qualified Data.List as DL

import MeuPrimeiroModulo

main = do
    let a = [2, 4, 1, 2, 4, 5, 6, 0]
    let b = DL.sort a
    let c = inits b
    putStrLn $
        show $
        --map nub $
        b

-- Criar uma função com o nome ja usado no módulo irá dar problema se for usado
-- com um import simples de todo o módulo Data.List
-- nub :: Integer -> Integer
-- nub x = 42 + x