(defun factorize (n divisor)
  (if (= n 1)                                               ;; Jeśli n jest równe 1, to zwracamy pustą listę jako wynik faktoryzacji
      (list)
                                                            ;; W przeciwnym razie, gdy n nie jest równe 1
      (if (= (mod n divisor) 0)                             ;; Jeśli n dzieli się bez reszty przez divisor
          (cons divisor                                     ;; Dodaj divisor do wyniku faktoryzacji
                (factorize (/ n divisor)                    ;; Rekurencyjnie wywołaj factorize dla n podzielonego przez divisor
                           divisor))                        ;; Przekazując divisor jako drugi argument
                                                            ;; Jeśli n nie dzieli się bez reszty przez divisor
          (factorize n (1+ divisor)))))                     ;; Rekurencyjnie wywołaj factorize dla tego samego n i zwiększonego divisor o 1

(defun primeFactors (n)
  (if (<= n 1)                                              ;; Jeśli n jest mniejsze lub równe 1, zwracamy pustą listę
      (list)
                                                            ;; W przeciwnym razie, gdy n jest większe od 1
      (factorize n 2)))                                     ;; Wywołaj funkcję factorize z n i 2

(defun coprime (n k)
  (cond ((= k 1) 1)                                         ;; Gdy k jest równe 1, zwróć 1 (są względnie pierwsze)
        ((= (gcd n k) 1)                                    ;; Gdy gcd(n, k) jest równe 1 (są względnie pierwsze)
         (+ 1 (coprime n (- k 1))))                         ;; Dodaj 1 do wyniku i rekurencyjnie sprawdź dla kolejnych wartości k-1
        (t (coprime n (- k 1)))))                           ;; W przeciwnym razie rekurencyjnie sprawdź dla kolejnych wartości k-1

(defun totient1 (n)
  (coprime n (- n 1)))                                      ;; Wywołuje funkcję coprime dla n i n-1 (liczby od 1 do n-1)


(defun totient2 (n)
  (let* ((factors (primeFactors n))                         ;; Obliczanie wszystkich czynników pierwszych liczby n
         (unique-factors (remove-duplicates factors)))      ;; Usuwanie zduplikowanych czynników
    
    (reduce (lambda (acc p)                                 ;; Użycie funkcji reduce do obliczenia wartości totient
              (floor (* acc (- p 1)) p))
            unique-factors 
            :initial-value n)))               
