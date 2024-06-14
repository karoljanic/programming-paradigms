(defun mergeLists (left right)
    (cond
        ((null left) right)                             ;; Jeśli lewa lista jest pusta, zwróć prawą listę
        ((null right) left)                             ;; Jeśli prawa lista jest pusta, zwróć lewą listę
        ((<= (car left) (car right))                    ;; Jeśli pierwszy element lewej listy jest mniejszy lub równy pierwszemu elementowi prawej listy
        (cons (car left) (mergeLists (cdr left) right)))     ;; Dodaj pierwszy element lewej listy do scalonej listy i wywołaj merge
        (t                                              ;; Jeśli pierwszy element prawej listy jest mniejszy od pierwszego elementu lewej listy
        (cons (car right) (mergeLists left (cdr right))))))  ;; Dodaj pierwszy element prawej listy do scalonej listy i wywołaj merge

(defun mergesort (lst)
    (if (or (null lst) (null (cdr lst)))                ;; Jeśli lista jest pusta lub zawiera tylko jeden element, zwróć ją jako już posortowaną
        lst
                                                        ;; W przeciwnym razie
        (let* ((middle (/ (length lst) 2))              ;; Znajdź środek listy
            (left (subseq lst 0 middle))                ;; Podziel listę na lewą połowę
            (right (subseq lst middle)))                ;; Podziel listę na prawą połowę
        (mergeLists (mergesort left) (mergesort right)))))   ;; Zastosuj mergesort na obu połowach i scal je