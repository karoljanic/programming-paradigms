fun generateList m n =
    if m > n then []
    else m :: generateList (m + 1) n

fun gcd (a, 0) = a
  | gcd (a, b) = gcd (b, a mod b)

fun factorize 1 _ = []
  | factorize n divisor = 
    if n mod divisor = 0 then divisor :: factorize (n div divisor) divisor
    else factorize n (divisor + 1)

fun primeFactors n =
    if n <= 1 then []
    else factorize n 2

fun removeDuplicates [] = []
  | removeDuplicates (x::xs) =
    if List.exists (fn y => y=x) xs then removeDuplicates xs
    else x :: removeDuplicates xs

fun coprime n =
    let
        fun isCoprime k = gcd (n, k) = 1
    in
        List.filter isCoprime (generateList 1 n)
    end

fun totient1 n = List.length (coprime n)

fun totient2 n = 
    let
        val factors = primeFactors n
        val uniqueFactors = removeDuplicates factors
    in
        List.foldl (fn(p, acc) => acc div p * (p-1)) n uniqueFactors
    end
