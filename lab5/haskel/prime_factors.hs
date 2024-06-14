factorize :: Int -> Int -> [Int]
factorize 1 _ = []
factorize n divisor
    | n `mod` divisor == 0 = divisor : factorize (n `div` divisor) divisor
    | otherwise            = factorize n (divisor + 1)

prime_factors :: Int -> [Int]
prime_factors n
    | n <= 1    = []
    | otherwise = factorize n 2