fun de (a, 0) = (1, 0, a)
  | de (a, b) =
    let
        val (x', y', gcd) = de (b, (a mod b))
        val (x, y) = (y', x' - y' * (a div b))
    in
        (x, y, gcd)
    end

    