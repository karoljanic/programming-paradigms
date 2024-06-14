fun factorize 1 _ = []
  | factorize n divisor = 
    if n mod divisor = 0 then divisor :: factorize (n div divisor) divisor
    else factorize n (divisor + 1)

fun primeFactors n =
    if n <= 1 then []
    else factorize n 2
