(defun de (a b)
  (if (= b 0)                                       ;; Jeśli b jest równe 0
      (values 1 0 a)                                ;; Zwraca trzy wartości: 1, 0 oraz a
      
                                                    ;; W przeciwnym razie, gdy b nie jest równe 0
      (multiple-value-bind (x1 y1 gcd-ab)           ;; multiple-value-bind rozpakowuje wartości zwrócone przez rekurencyjne wywołanie de
          (de b (mod a b))                          ;; Wywołuje funkcję de rekurencyjnie, przekazując nowe wartości a i b
        
        (let ((x y1)
              (y (- x1 (* y1 (truncate a b)))))     ;; Oblicza nowe wartości x i y na podstawie wyników rekurencyjnego wywołania
          (values x y gcd-ab)))))                   ;; Zwraca trzy wartości: x, y oraz największy wspólny dzielnik a i b
