(progn
  (format t "~D~%" (+ 3 16))
  (let ((one_to_nine (+ 3 33)))
    (format t "~D~%" one_to_nine)
    (let ((one_to_ten (+ one_to_nine 3)))
      (let ((one_to_twenty (+ one_to_ten 73)))
        (let ((one_to_thirty (+ one_to_twenty (* 6 9) one_to_nine 6)))
          (let ((one_to_forty (+ one_to_thirty (* 6 9) one_to_nine 5)))
            (let ((one_to_fifty (+ one_to_forty (* 5 9) one_to_nine 5)))
              (let ((one_to_sixty (+ one_to_fifty (* 5 9) one_to_nine 5)))
                (let ((one_to_seventy (+ one_to_sixty (* 5 9) one_to_nine 7)))
                  (let ((one_to_eighty (+ one_to_seventy (* 7 9) one_to_nine 6)))
                    (let ((one_to_ninety (+ one_to_eighty (* 6 9) one_to_nine 6)))
                      (let ((one_to_ninety_nine (+ one_to_ninety (* 6 9) one_to_nine)))
                        (format t "~D~%~D~%" one_to_ninety_nine (+ (* 100 one_to_nine) (* one_to_ninety_nine 10) (* 10 9 99) (* 7 9) 11))
                      ))))))))))))


