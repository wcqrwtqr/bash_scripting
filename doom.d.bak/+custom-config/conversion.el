;;; +custom-config/conversion.el -*- lexical-binding: t; -*-



(defun my/convert-to-bpd ()
  "A custom interactive function that prompts for a input flow rate value,
allows the user to choose a unit rate from a list, and displays the result
in bbl/d."
  (interactive)
  (let ((t-value (read-from-minibuffer "Enter flow rate: "))
        (condition (completing-read "Choose a condition (1, 2, 3, 4): "
                                    '("gpm" "L/min" "m3/h" "m3/d")))
        (factor 0))
    ;; Convert the entered value to a number (assuming it's a string)
    (setq t-value (string-to-number t-value))
    ;; Determine factor based on the selected condition
    (setq factor
          (cond
           ((string= condition "gpm") 34.285)
           ((string= condition "L/min") 9.043)
           ((string= condition "m3/h") 150.72)
           ((string= condition "m3/d") 6.28)
           (t 0))) ; Default factor if none of the conditions match
    ;; Perform multiplication
    (setq result (* t-value factor))
    ;; Display the result
    (let* ((buffer-name "my/conversion-bbl")
           (buffer (get-buffer-create buffer-name)))
      ;; Creates a new buffer
      (with-current-buffer buffer
        ;; Erase the buffer before adding any text to it
        (erase-buffer)
        (insert (format  "%s %s convert to %.1f BBL/d" t-value condition result))
        ;; Make the buffer at the bottom with a height of 10
        (display-buffer buffer '((display-buffer-reuse-window
                                  display-buffer-pop-up-window)
                                 (window-height . 10)))
        ;; Move the curser to the new window
        (select-window (get-buffer-window buffer))))))


(defun my/compute-gold-for-selling ()
  "A custom interactive function that takes the today gold price of an oz and
calcualte what will be the selling price at the local market
Taking into account the out put in both Dollar and IQR"
  (interactive)
  (let ((g-value (read-from-minibuffer "Enter the gold price today for oz: "))
        (grams-value (read-from-minibuffer "Enter the weight of gold to be sold: "))
        (k-value (read-from-minibuffer "Enter what is the gold karut \(24 or 21\): "))
        (d-value (read-from-minibuffer "Enter today dollar exchange rate to IQD: ")))
    (setq g-value (string-to-number g-value))
    (setq d-value (string-to-number d-value))
    (setq k-value (string-to-number k-value))
    (setq grams-value (string-to-number grams-value))
    ;; compute the selling of gold price
    (setq result-price-dollar (* k-value (/ (* grams-value (/ g-value 31.1)) 24) ))
    ;; converting to IQD instead of dollar
    (setq result-price-iqd (* d-value result-price-dollar))
    ;; Add the results to the kill wirng for easy pasting later on
    (kill-new (message "Selling %d grams of %s karats will be at %d dollars and %d IQD"
                       grams-value k-value result-price-dollar result-price-iqd ))
    ;; Make a small buffer and put the results there
    (let* ((buffer-name "my/gold-calculation-result-page")
           (buffer (get-buffer-create buffer-name)))
      (with-current-buffer buffer
        (erase-buffer)
        (insert (format  "Selling %d grams of %s karats will be at %d dollars and %d IQD"
                         grams-value k-value result-price-dollar result-price-iqd ))
        (display-buffer buffer '((display-buffer-reuse-window
                                  display-buffer-pop-up-window)
                                 (window-height . 5)))  ;; Make the height
        (select-window (get-buffer-window buffer))))))


(defun my/convert-bbl-to-other-units-b ()
  "A function asks for input flow rate value in bbl/d and it will convert it to
gpm, l/min, m3/h, m3/d"
  (interactive)
  (let ((t-value (read-from-minibuffer "Enter flow rate in BBL/day: ")))
    (setq t-value (string-to-number t-value))
    (setq result-gpm (/ t-value 34.285))
    (setq result-lpm (/ t-value 9.043))
    (setq result-m3h (/ t-value 150.72))
    (setq result-m3d (/ t-value 6.28))
    (let* ((buffer-name "my/conversion-results")
           (buffer (get-buffer-create buffer-name)))
      (with-current-buffer buffer
        (erase-buffer)
        ;; Compose the results in a multiline results
        (insert (format "%s bbl/d equals: \n- %.0f gpm or\n- %.0f l/min or\n- %.1f m3/h or\n- %.0f m3/d"
                        t-value result-gpm result-lpm result-m3h result-m3d))
        ;; Create a small window with height of 10
        (display-buffer buffer '((display-buffer-reuse-window
                                  display-buffer-pop-up-window)
                                 (window-height . 10)))
        ;; Move the curser to the new buffer with results
        (select-window (get-buffer-window buffer))))))



