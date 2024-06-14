merge :: [Int] -> [Int] -> [Int]
merge [] [] = []
merge x [] = x
merge [] y = y
merge (x:xs) (y:ys)
    | x <= y    = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys

halve :: [Int] -> ([Int], [Int])
halve [] = ([], [])
halve [x] = ([x], [])
halve (x1:x2:xs) = ((x1 : left), (x2 : right))
    where (left, right) = halve xs

mergesort :: [Int] -> [Int]
mergesort [] = []
mergesort [x] = [x]
mergesort xs = merge (mergesort left) (mergesort right)
    where (left, right) = halve xs