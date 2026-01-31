;;; +custom-config/org-present.el -*- lexical-binding: t; -*-

(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                 ;; (org-present-small)
                 (olivetti-mode 1)
                 (setq-local display-line-numbers nil)
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (setq header-line-format "  ")
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 ;; (org-present-small)
                 (olivetti-mode -1)
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (setq-local display-line-numbers 'relative)
                 (setq header-line-format nil)
                 (org-present-read-write)))))

(global-set-key (kbd "C-c <f12>") 'org-present)
(global-set-key (kbd "C-c <f2>") 'org-present-quit)


;; Now I knew about the best presentaiton ever org-tree-slide
;;
(global-set-key (kbd "<f8>") 'org-tree-slide-mode)
(global-set-key (kbd "S-<f8>") 'org-tree-slide-skip-done-toggle)
