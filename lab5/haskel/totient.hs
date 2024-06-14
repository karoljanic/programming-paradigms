import Data.List (nub)

factorize :: Int -> Int -> [Int]
factorize 1 _ = []
factorize n divisor
    | n `mod` divisor == 0 = divisor : factorize (n `div` divisor) divisor
    | otherwise            = factorize n (divisor + 1)

prime_factors :: Int -> [Int]
prime_factors n
    | n <= 1    = []
    | otherwise = factorize n 2

coprime :: Int -> [Int]
coprime n = [k | k <- [1..n], gcd n k == 1]

totient1 :: Int -> Int
totient1 n = length $ coprime n

totient2 :: Int -> Int
totient2 n =
    let factors = prime_factors n
        uniqueFactors = nub factors  -- removeDuplicates
    in 
        foldl (\acc p -> acc `div` p * (p - 1)) n uniqueFactors
