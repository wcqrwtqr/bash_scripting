;;; +custom-config/my-local-abbrev.el -*- lexical-binding: t; -*-

(define-abbrev-table 'global-abbrev-table '(
    ("btw" "by the way")
    ("omw" "on my way")
    ("bam" "bambang")
    ("ptp" "Pressure Test Pump")
    ("afaik" "as far as I know")
    ("idk" "I don't know")
    ("inci" "incident")
    ("_hotm" "mohalbatati@hotmail.com")
    ("_icloud" "mohalbatati@icloud.com")
    ("_neos" "mohalbatati@neoilfield.com")
))

(setq-default abbrev-mode t) ;; Enable abbrev-mode globally
