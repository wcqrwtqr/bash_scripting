;;; +custom-config/my-bash-scripts.el -*- lexical-binding: t; -*

(defun my/get-gold-price ()
  "Bash script call to get the gold price of an oz"
  (interactive)
  (message "%s"(shell-command-to-string "/usr/local/bin/get_gold")))

(defun my/get-oil-prices ()
  "Rust script call to get the oil price of an brent and WTI"
  (interactive)
  (message "%s"(shell-command-to-string "/usr/local/bin/my_oil_price_rs")))
