
main = do
    putStrLn "Ok!!"
    putStrLn(show(idade a2))
    putStrLn(show(map nome alunos)) --lista de strings  e retorna uma string
    putStrLn $ show $ map nome $ filter((>8.0).nota) $ alunos
    putStrLn $ show $ idade a2 --identicas mas sem parenteses
    putStrLn $ show $ filter((<=5).length) $ map nome $ alunos --alunos que tem nome menor ou igual a 5 Char
    putStrLn $ show $ map nome $ filter((<=5).length.nome) $ filter((>8.0).nota) $ alunos 
    putStrLn $ show $ filter((<=5).length) $ map nome $ filter((>8.0).nota) $ alunos --faz a mesma coisa q o de cima (lazy computation)
    putStrLn $ show $ map curso $ alunos
    putStrLn $ show $ sum $ map nota $ filter ((== show BSI).show.curso) $ alunos
    putStrLn $ show $ alunos

infAlunos :: Integer-> [Char] -> [Aluno]
infAlunos i n = Aluno {nusp = i, nome = n}: infAlunos(i+1) n

--(.) :: (a ->b) -> (c -> a) -> (c->b)
--(>8.0) :: Float -> Bool
--((>8.0).nota) :: Float(a) -> Bool(b) -> Aluno(c) -> Float(a) = Aluno -> Bool


data Curso = BCC | BSI 
    deriving (Show, Eq)

data Aluno = Aluno {
    nusp :: Integer
    , nome :: [Char]
    , idade :: Integer --dado um aluno retorna um inteiro
    , nota :: Float
    , curso :: Curso
    }   
    deriving (Show,Eq)

a1 = Aluno{ nusp = 123, nome = "Adenilso", idade = 47, nota = 10.0, curso = BCC}
a2 = Aluno{ nusp = 456, nome = "Laura", idade = 19, nota = 10.0, curso = BSI}
--a3 = Aluno{ nusp = 12}
alunos = [
    a1
   ,a2
   --,a3
   ,Aluno{nusp = 123, nome = "Luana Bullo", idade = 47, nota = 8.0, curso = BCC}
   ,a2 {nusp = 789, nome = "Joao", idade = 17, nota = 0.0, curso = BCC}
   ,Aluno{nusp = 890, nome = "lucas", idade = 7, nota = 5.0, curso = BSI}
        ]   