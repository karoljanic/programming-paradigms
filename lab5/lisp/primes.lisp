(defun numberSequence (start end)
  (if (> start end)                                             ;; Jeśli start jest większy niż end, zwracamy nil, ponieważ lista jest pusta
      nil
                                                                ;; W przeciwnym razie, gdy start nie jest większy niż end
      (cons start                                               ;; Dodajemy start do początku listy
            (numberSequence                                     ;; Rekurencyjnie wywołujemy numberSequence dla start zwiększonego o 1 i end
             (1+ start) end))))

(defun primes (n)
  (labels ((sieve (lst)                                         ;; Funkcja wewnętrzna sieve do filtrowania liczb pierwszych z listy lst
             (cond ((null lst) nil)                             ;; Jeśli lst jest puste, zwracamy nil
                   ((> (* (car lst) (car lst)) n) lst)          ;; Jeśli kwadrat pierwszego elementu w lst jest większy niż n, zwracamy lst
                   (t (cons (car lst)                           ;; W przeciwnym razie
                            (sieve (remove-if (lambda (x) (zerop (mod x (car lst))))
                                              (cdr lst))))))))

    (if (< n 2)                                                 ;; Jeśli n jest mniejsze niż 2, zwracamy nil
        nil
                                                                ;; W przeciwnym razie, gdy n jest większe lub równe 2
        (sieve (numberSequence 2 n)))))                         ;; Wywołujemy sieve z listą liczb od 2 do n
