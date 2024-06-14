fun generateList m n =
    if m > n then []
    else m :: generateList (m + 1) n

fun sieve [] _  = []
  | sieve (x::xs) n =
    if x * x > n then x :: xs
    else x :: sieve (List.filter (fn y => y mod x <> 0) xs) n

fun primes n =
    if n < 2 then []
    else sieve (generateList 2 n) n