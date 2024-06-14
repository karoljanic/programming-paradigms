fun binomial1 n k = 
    if k > n then 0
    else if k = 0 orelse k = n then 1
    else binomial1(n-1) (k-1) + binomial1(n-1) k

fun pascalTriangleRow 0 = [1]
  | pascalTriangleRow n = 
    let
        val previousRow = pascalTriangleRow (n-1)

        fun nextRow [] = []
          | nextRow [_] = [1]
          | nextRow (x::y::rest) = (x+y) :: nextRow (y::rest)
    in
        1 :: nextRow previousRow
    end

fun binomial2 n k = 
    let
        val row = pascalTriangleRow n
    in
        List.nth (row, k)
    end
