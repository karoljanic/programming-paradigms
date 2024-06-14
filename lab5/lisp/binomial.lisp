(defun binomial1 (n k)  
  (cond ((> k n) 0)                                         ;; Jeśli k jest większe niż n, zwróć 0
        ((or (= k 0) (= k n)) 1)                            ;; Jeśli k równa się 0 lub k równa się n, zwróć 1
        (t (+ (binomial1 (- n 1) k)                         ;; W przeciwnym razie
              (binomial1 (- n 1) (- k 1))))))               ;; Oblicz rekurencyjnie binomial1 dla n-1, k oraz n-1, k-1 i zsumuj wyniki

(defun addElementWise (l1 l2)  
  (cond ((and (null l1) (null l2)) nil)                     ;; Jeśli obie listy są puste, zwróć nil
        ((null l1) l2)                                      ;; Jeśli l1 jest pusta, zwróć l2
        ((null l2) l1)                                      ;; Jeśli l2 jest pusta, zwróć l1
        (t (cons (+ (car l1) (car l2))                      ;; W przeciwnym razie
                 (addElementWise (cdr l1) (cdr l2))))))     ;; Dodaj pierwsze elementy l1 i l2, a następnie rekurencyjnie dodaj resztę

(defun pascalTriangle (n)  
  (if (= n 0)
      '(1)                                                  ;; Jeśli n równa się 0, zwróć listę z jednym elementem: 1
      (let ((prev-row (pascalTriangle (- n 1))))            ;; W przeciwnym razie
        (addElementWise (cons 0 prev-row)                   ;; Dodaj element 0 na początek poprzedniego wiersza
                          (append prev-row '(0))))))        ;; i dodaj wiersz z poprzedniego wywołania z elementem 0 na końcu

(defun binomial2 (n k)
  (nth k (pascalTriangle n)))                               ;; Zwróć k-ty element n-tego wiersza trójkąta Pascala.
