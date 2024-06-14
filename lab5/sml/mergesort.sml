fun merge xs [] = xs
  | merge [] ys = ys
  | merge (x::xs) (y::ys) = 
    if x <= y then x :: merge xs (y::ys)
    else y :: merge (x::xs) ys

fun halve xs = 
    let 
        val len = length xs
        val mid = len div 2
    in
        (List.take(xs, mid), List.drop(xs, mid))
    end

fun mergesort [] = []
  | mergesort [x] = [x]
  | mergesort xs = 
    let
        val (left, right) = halve xs
    in
        merge (mergesort left) (mergesort right)
    end 