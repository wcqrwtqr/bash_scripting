;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;;(setq user-full-name "Mohammed S. Albatati"
;;      user-mail-address "mohalbatati@icloud.com")

;; (setq dirvish-subtree-listing-switches
;;       "-g --human-readable --group-directories-first --no-group")

;; Set dired and dirvish listing switches
(setq dired-listing-switches "-g --human-readable --group-directories-first --no-group")
(setq-default dired-listing-switches "-g --human-readable --group-directories-first --no-group")
(after! dirvish
  ;; Set multiple dirvish switches variables to ensure persistence
  (setq dirvish-ls-switches dired-listing-switches)
  (setq dirvish-subtree-listing-switches dired-listing-switches))
;; Disable spell-fu-mode in org-mode and other text modes
(remove-hook 'text-mode-hook #'spell-fu-mode)
(remove-hook 'org-mode-hook #'spell-fu-mode)
;; Hide the details of dired similar to ls instead of ls -l
;; In the scratch run the below code:
(remove-hook 'dired-mode-hook 'dired-hide-details-mode) ;;<- this will remove the hook


;; Also remove it from any existing hooks
(with-eval-after-load 'spell-fu
  (remove-hook 'text-mode-hook #'spell-fu-mode)
  (remove-hook 'org-mode-hook #'spell-fu-mode))
;; (remove-hook 'after-init-hook #'spell-fu-mode)

;; Configure dirvish properly after it loads
(after! dirvish
  ;; Set multiple dirvish switches variables to ensure persistence
  (setq dirvish-ls-switches dired-listing-switches)
  (setq dirvish-subtree-listing-switches dired-listing-switches)
  ;; Use a simpler header line format without problematic functions
  (setq dirvish-header-line-format '(:left (path) :right (free-space)))
  (setq dirvish-use-header-line t)
  (setq dirvish-icons t)
  (setq dirvish-default-layout '(0 0.4 0.6)))

;; Also set it as a hook to ensure it applies when dirvish starts
(add-hook 'dirvish-setup-hook
          (lambda ()
            (setq dirvish-ls-switches "-g --human-readable --group-directories-first --no-group")
            (setq dirvish-subtree-listing-switches "-g --human-readable --group-directories-first --no-group")))

(setq org-mobile-directory "~/Library/Mobile Documents/iCloud~com~mobileorg~mobileorg/Documents")


;; Set frame transparency
(set-frame-parameter (selected-frame) 'alpha '(98 98)) ;; Adjust 85 to your desired transparency (0-100)
;; (add-to-list 'default-frame-alist '(alpha . (95 95))) ;; Apply to new frames
(add-to-list 'default-frame-alist '(alpha-background . 95 )) ;; Apply to new frames
;; (beacon-mode 1)

;; (setq doom-theme 'catppuccin)
(setq doom-theme 'kaolin-ocean) ;; my new best theme
;; (setq doom-font (font-spec :family "JetBrains Mono" :size 14))
(setq display-line-numbers-type 'relative)
                                        ; Add a fallback font for Unicode characters
(setq doom-font (font-spec :family "JetBrains Mono" :size 16 :weight 'normal :width 'normal))
;; (setq doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 15 :weight 'normal :width 'normal))


(remove-hook 'org-mode-hook 'org-modern-mode)
(require 'org-superstar)
;; (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(add-hook 'org-mode-hook 'org-superstar-mode)
(setq
 org-superstar-headline-bullets-list '("⁖" "◉" "○" "*" "✿"))

;; PDF Tools configuration - ensure it loads properly
;; (use-package pdf-tools
;;   :commands (pdf-view-mode pdf-tools-install)
;;   :mode ("\\.[pP][dD][fF]\\'" . pdf-view-mode)
;;   :magic ("%PDF" . pdf-view-mode)
;;   :config
;;   (pdf-tools-install :no-query)
;;   ;; Enable hiDPI support on macOS
;;   (setq pdf-view-use-scaling t
;;         pdf-view-use-imagemagick nil)

;;   ;; Ensure pdf-view functions are properly available
;;   (with-eval-after-load 'pdf-view
;;     (require 'pdf-view)
;;     (require 'pdf-tools))

;;   ;; Add custom hook if needed
;;   (when (fboundp 'setup-pdf-view-mode-keys)
;;     (add-hook 'pdf-view-mode-hook 'setup-pdf-view-mode-keys)))

;; Org-noter configuration
;; (use-package org-noter
;;   :after (:any org pdf-view)
;;   :config
;;   ;; Ensure pdf-tools is loaded before org-noter
;;   (require 'pdf-tools)

;;   ;; Basic org-noter settings
;;   (setq org-noter-notes-window-location 'horizontal-split
;;         org-noter-always-create-frame nil
;;         org-noter-hide-other nil
;;         org-noter-notes-window-behavior 'start)

;;   ;; Fix for the overlay function error
;;   (with-eval-after-load 'pdf-view
;;     ;; Define the missing function if it doesn't exist
;;     (unless (fboundp 'pdf-view-current-overlay)
;;       (defun pdf-view-current-overlay ()
;;         "Return the current overlay in pdf-view-mode."
;;         (when (pdf-view-current-page)
;;           (car (pdf-view-active-region-p)))))))

;; Ensure the timer function doesn't fail
;; (defadvice org-noter--show-arrow (around safe-show-arrow activate)
;;   "Safely show arrow, catching any pdf-view errors."
;;   (condition-case err
;;       ad-do-it
;;     (error
;;      (message "org-noter arrow display error: %s" err)))))


;; (use-package highlight-symbol
;;   ;; :ensure t
;;   :init
;;   (add-hook 'prog-mode-hook 'highlight-symbol-mode))

(setq large-file-warning-threshold nil)

;; This is the best code ever in dired to avoid
;; navigating to the required folder
;; ivy makes it available after hitting SPC f d
;; ivy-dired-history
(with-eval-after-load 'dired
  (require 'ivy-dired-history)
  (define-key dired-mode-map "," 'dired))

(use-package marginalia
  ;; :ensure t
  :config
  (marginalia-mode))

;; (require 'zoom-window)
(custom-set-variables
 '(zoom-window-mode-line-color "LightGreen"))


;; Make emacs full screen on start up
(add-hook 'window-setup-hook #'toggle-frame-maximized)

(setq denote-known-keywords '("Operation" "NPT" "Tasks" "Issue" "Delay" "Daily" "Incident"))

;; Load functions I used for converting flow rate untis
(load! "+custom-config/conversion.el")
;; (load! "+custom-config/gptel-ai.el")
(load! "+custom-config/keybindings-personnel.el")
(load! "+custom-config/org-agenda.el")
;; (load! "+custom-config/org-present.el")
(load! "+custom-config/bible-verses.el")
(load! "+custom-config/my-bash-scripts.el")
(load! "+custom-config/my-html-modification.el")
(load! "+custom-config/my-mailing-script.el")
(load! "+custom-config/final-report-sgs.el")
(load! "+custom-config/window-setup.el")
(load! "+custom-config/mu4e-config.el")
(load! "+custom-config/my-local-abbrev.el")


;; Below are the code for company setup
(after! company
  (setq company-backends '((company-capf company-files company-dabbrev)))
  (setq company-idle-delay 0     ;; Adjust delay before suggestions pop up (0 for instant)
        company-minimum-prefix-length 2  ;; Only start after typing 2 characters
        company-echo-delay 0
        company-tooltip-limit 8    ;; Limit the number of suggestions shown
        company-selection-wrap-around t))

;; (setq gc-cons-threshold 100000000) ; Increase threshold to 100 MB
(setq gc-cons-threshold 100000000  ;; Increase memory limit before triggering garbage collection
      read-process-output-max (* 1024 1024))  ;; Increase for LSP performance
;; (add-to-list 'load-path "+custom-config/gcmh.el")
;; (gcmh-mode 0)
;; (setq gcmh-high-cons-threshold (* 500 1024 1024))
;; (setq gcmh-auto-idle-delay-factor 10)


;; Read-player config
(when (memq system-type '(darwin))
  (set-fontset-font t nil "SF Pro Display" nil 'append))

(global-set-key (kbd "M-o") 'ace-window)
(setq aw-keys '(?o ?i ?u ?y ?t ?h ?j ?k ?l))

(use-package org-roam
  :custom
  (org-roam-directory (file-truename "/Users/mohammedalbatati/org/org-roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:30}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))


(defun my-org-roam-go-back ()
  "Jump back to the previous location in Org mode using the mark ring.
This is used for the org-roam when I go from one node to another."
  (interactive)
  (org-mark-ring-goto))

(setq org-roam-db-gc-threshold most-positive-fixnum)

(use-package org
  :after org-roam  ; Important to load after org-roam
  :config
  (define-key org-mode-map (kbd "C-c n b") 'my-org-roam-go-back))


;; (global-set-key (kbd "C-)") 'ace-mc-add-multiple-cursors)
;; (global-set-key (kbd "C-M-)") 'ace-mc-add-single-cursor)

;; =================================================================
;; =========================End of config.el file===================
;; =================================================================

;; تغيير الخط المسؤول عن عرض النصوص العربية فقط
;; (set-fontset-font "fontset-default"
;;          'arabic
;;          (font-spec :family "Kawkab Mono" :size 30))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; (setq ispell-aspell-dict-dir "/usr/local/bin/ispell")
;; (setq ispell-dictionary "english")

;; (setq ispell-program-name "aspell")
;; (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"))
;; (setq ispell-program-name "/usr/local/bin/ispell")

(after! ispell
  (setq ispell-program-name "hunspell")
  (setq ispell-dictionary "en_US")
  (setq ispell-personal-dictionary nil)
  (setq ispell-local-dictionary-alist
        '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US")
           nil utf-8))))

(setq-default ispell-program-name "hunspell"
              ispell-local-dictionary "en_US"
              ispell-hunspell-dictionary-alist
              '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)))

;; Fix spell-fu to use the same dictionary configuration
(after! spell-fu
  (setq spell-fu-faces-exclude '(org-meta-line
                                 org-link
                                 org-code
                                 org-verbatim
                                 org-block
                                 org-block-begin-line
                                 org-block-end-line
                                 org-document-info-keyword
                                 org-special-keyword))
  ;; Ensure spell-fu uses the correct dictionary
  (setq spell-fu-directory (expand-file-name "spell-fu" doom-cache-dir)))

(map! :leader
      :desc "Spell check"
      "t s" #'ispell-word)

;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 16 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 18))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; I want to delay the popup window that shows while I type so it becomes less annyoing
;; (setq completion-delay 200)
;; Here If I want to disaple the completion for writing
;; (setq completion-styles nil)

;; (require 'olivetti)
;; (setq olivetti-body-width .67)

(setq alert-default-style 'libnotify)


(defun my-open-mac-mail-from-org-subject ()
  "Open a mail with the subject found on the current Org mode line.
It will copy the mail subject in the org file line and activate
the mail app"
  (interactive)
  (let* ((line-text (thing-at-point 'line))
         (subject (when line-text
                    (string-match "refer to mail (\\(.*?\\))" line-text)
                    ;; (string-match "\\((.*?)\\)" line-text)
                    (match-string 1 line-text))))
    (if subject
        (progn
         (kill-new subject)
         (shell-command "open -a Mail"))
      ;; (my-open-mac-mail-by-subject subject) ; Use the previous function
      (message "No subject found in parentheses on this line."))))

(global-set-key (kbd "C-c m o") 'my-open-mac-mail-from-org-subject)


(require 'sqlite)
(require 'org)
(defun my/sqlite-query-org-table ()
  "Query SQLite database and display results as an Org mode table."
  (interactive)
  (let* ((db-file "/Users/mohammedalbatati/org/neosdatabase.db")
         (db (sqlite-open db-file))
         (results (sqlite-execute db "SELECT * FROM sl_equipment;")))
    (with-current-buffer (get-buffer-create "*SQLite Results*")
      (erase-buffer)
      ;; Insert header row
      (insert "| " (mapconcat (lambda (col) (format "%s" col)) (car results) " | ") " |\n")
      ;; Insert separator row
      (insert "|-" (mapconcat (lambda (_) "---") (car results) "-+-") "-|\n")
      ;; Insert each data row
      (dolist (row (cdr results))
        (insert "| " (mapconcat (lambda (col) (format "%s" col)) row " | ") " |\n"))
      ;; Enable Org mode for table formatting and navigation
      (org-mode)
      (goto-char (point-min))
      (pop-to-buffer (current-buffer)))
    (sqlite-close db)))

;; Adding more quick links to the quick access
(after! dirvish
  (setq! dirvish-quick-access-entries
         '(("i" "~/Desktop/National Energy/03 Slickine/Invoices/" "Invoices")
           ("d" "~/Downloads/"                                     "Downloads")
           ("w" "~/Downloads/well/"                                     "Well")
           ("v" "/Volumes/WL-SL/"                                  "WL-SL")
           ("g" "/Volumes/WL-SL/05 WORK APPROVAL/Work forms/"       "Wrok Approval")
           ("n" "/Volumes/WL-SL/02 Slickline/02 Maintenance/"      "Maintenacne")
           ("t" "/Volumes/WL-SL/02 Slickline/02 Maintenance/TRUCK UNIT/"      "Truck")
           ("1" "/Volumes/WL-SL/02 Slickline/01 Jobs/BECL BP/Unit1/Daily Report/2026/"      "Daily-1")
           ("2" "/Volumes/WL-SL/02 Slickline/01 Jobs/BECL BP/Unit2/Daily Report/2026/"      "Daily-2")
           ("f" "/Volumes/WL-SL/02 Slickline/01 Jobs/UEFL/FAO-1/"      "FAO")
           ("s" "~/Desktop/"                                      "Desktop"))))


;; ~/.doom.d/config.el
(use-package! org-transclusion
  :after org
  :init
  (map!
   :map global-map "<f12>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))


