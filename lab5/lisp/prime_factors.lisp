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
