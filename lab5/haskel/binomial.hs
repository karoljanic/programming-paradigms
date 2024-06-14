binomial1 :: Integer -> Integer -> Integer
binomial1 n k
    | k > n     = 0
    | k == 0 || k == n  = 1
    | otherwise = binomial1 (n-1) (k-1) + binomial1 (n-1) k

pascalTriangleRow :: Integer -> [Integer]
pascalTriangleRow 0 = [1]
pascalTriangleRow n =
    let previousRow = pascalTriangleRow (n-1)
        
        nextRow [] = []
        nextRow [_] = [1]
        nextRow (x:y:rest) = (x+y) : nextRow (y:rest)
    in
        1 : nextRow previousRow

binomial2 :: Integer -> Integer -> Integer
binomial2 n k =
    let row = pascalTriangleRow n
    in  row !! fromInteger k
