de :: (Int, Int) -> (Int, Int, Int)
de (a, 0) = (1, 0, a)
de (a, b) =
    let (x', y', gcd) = de (b, (a `mod` b))
        (x, y) = (y', x' - y' * (a `div` b))
    in 
        (x, y, gcd)