;;; +custom-config/keybindings-personnel.el -*- lexical-binding: t; -*-

;; Map the keys to activate peep and narrow
;; Dired configurations
(map! :leader
      :after dired
      :map dired-mode-map
      :desc "copy file here" "d c" #'copy-file-to-current-directory
      :desc "open ooffice" "d f" #'dired-open-in-onlyoffice
      ;; :desc "Copy to download" "d p" #'dired-copy-to-downloads
      :desc "copy to clipp" "d p" #'my-dired-copy-to-clippy
      :desc "combine pdfs" "d j" #'dired-combine-pdfs
      :desc "create SGS folders" "d g" #'create-sgs-folder-structure
      :desc "split pdfs" "d s" #'dired-split-pdf
      :desc "check pdf" "d k" #'check-pdf-with-cpdf
      :desc "pdftk flatten" "d K" #'my-pdftk-pdf-flatten
      :desc "dirvish ls" "d o" #'my-dirvish-menu-quickselect
      :desc "denote open" "d n" #'denote-open-or-create
      :desc "denote create" "d m" #'denote-create-note
      :desc "open libreoffice" "d l" #'dired-open-in-libreoffice
      :desc "Duplicate" "d d" #'dired-copy-with-suffix
      :desc "extract pdf page" "d e" #'extract-pdf-pages
      :desc "rename daily" "r d" #'rename-daily-report-file
      :desc "rename sgs" "r g" #'rename-sgs-data-file
      :desc "rename roo inv" "r i" #'rename-roo-invoice-file
      :desc "Print" "r p" #'my-dired-print-marked-pdfs
      :desc "dirvish fd " "r f" #'dirvish-fd
      :desc "neos window" "r r" #'my-setup-windows-neos
      :desc "download below" "r b" #'open-downloads-in-bottom-window-with-dirvish
      :desc "dated folder" "+" #'my-create-dated-folder)

(map! :leader
      :desc "trucate lines" "t t" #'toggle-truncate-lines
      :desc "bible chapter" "r c" #'my/get-bible-chapter
      :desc "bible verse" "r v" #'my/get-bible-verse
      ;; Copu lines with Avy
      :desc "eww" "e w" #'eww
      :desc "eww copy" "e c" #'eww-copy-page-url
      :desc "avy copy line" "y y" #'avy-copy-line
      :desc "avy copy region" "y r" #'avy-copy-region
      :desc "rotat image" "i r" #'image-rotate
      ;; dictionary
      :desc "my/lookup" "s t" #'dictionary-lookup-definition
      ;; GPTEL AI
      :desc "GPTEL" "z g" #'gptel
      :desc "GPTEL-send" "z y" #'gptel-send
      :desc "GPTEL-menu" "z x" #'gptel-menu
      ;; Zoom windows
      :desc "Zoom window" "z z" #'zoom-window-zoom
      :desc "Zoom window" "z n" #'zoom-window-next)

(setq key-chord-two-keys-delay 0.25)
;; All below usefu for emacs in evil mode
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-insert-state-map "jd" 'evil-delete-backward-word)
(key-chord-define evil-insert-state-map "ja" 'evil-end-of-line-or-visual-line)
(key-chord-define evil-insert-state-map "ji" 'evil-beginning-of-line)
(key-chord-define evil-insert-state-map "jw" 'evil-forward-word-end)
(key-chord-define evil-insert-state-map "jt" 'org-time-stamp)
(key-chord-mode 1)

;; This code is to increase the numbers in org mode
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "s-<up>") 'evil-numbers/inc-at-pt-incremental)
  (define-key org-mode-map (kbd "s-<down>") 'evil-numbers/dec-at-pt-incremental))


;; Use arabic kyeboard to navigate similar to vim
(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map "ت" 'evil-next-line)
  (define-key evil-normal-state-map "ن" 'evil-previous-line)
  (define-key evil-normal-state-map "ا" 'evil-backward-char)
  (define-key evil-normal-state-map "م" 'evil-forward-char)
  (define-key evil-normal-state-map "ص" 'evil-forward-word-begin)
  (define-key evil-normal-state-map "ز" 'evil-backward-word-begin)
  (define-key evil-normal-state-map "ه" 'evil-insert))

;; this makes me use pdf while the keyboard is in arabic layout
;; Making the scroll down using the arabic keyboard
(defun setup-pdf-view-mode-keys ()
  (define-key pdf-view-mode-map (kbd "C-ي") 'pdf-view-scroll-up-or-next-page)
  (define-key pdf-view-mode-map (kbd "ت") 'pdf-view-next-line-or-next-page)
  (define-key pdf-view-mode-map (kbd "ن") 'pdf-view-previous-line-or-previous-page)
  (define-key pdf-view-mode-map (kbd "ض") 'kill-current-buffer)
  (define-key pdf-view-mode-map (kbd "C-ع") 'pdf-view-scroll-down-or-previous-page))


;; Make the dired open in the default application
(setq dired-guess-shell-alist-user
      '(("\\.pdf\\'" "open")
        ("\\.png\\'" "open")
        ("\\.docx\\'" "open")
        ("\\.odt\\'" "open")
        ("\\.ods\\'" "open")
        ("\\.drawio\\'" "open -a /Applications/draw.io.app")
        ("\\.xlsx\\'" "open")))


(defun dired-open-in-libreoffice ()
  "Open the file at point or the marked files in Dired with Libreoffice."
  (interactive)
  (let ((files (dired-get-marked-files))) ; Get marked files
    (if files
        (dolist (file files)
          ;; Use `open -a` to open each file with ONLYOFFICE
          (start-process "Libreoffice" nil "open" "-a" "/Applications/libreoffice.app" file))
      ;; If no files are marked, open the file at point
      (let ((file (dired-get-file-for-visit)))
        (if file
            (start-process "OnlyOffice" nil "open" "-a" "/Applications/libreoffice.app" file)
          (message "No file selected."))))))

(defun dired-open-in-onlyoffice ()
  "Open the file at point or the marked files in Dired with OnlyOffice."
  (interactive)
  (let ((files (dired-get-marked-files))) ; Get marked files
    (if files
        (dolist (file files)
          ;; Use `open -a` to open each file with ONLYOFFICE
          (start-process "OnlyOffice" nil "open" "-a" "/Applications/ONLYOFFICE.app" file))
      ;; If no files are marked, open the file at point
      (let ((file (dired-get-file-for-visit)))
        (if file
            (start-process "OnlyOffice" nil "open" "-a" "/Applications/ONLYOFFICE.app" file)
          (message "No file selected."))))))


(defun copy-file-to-current-directory (default-dir)
  "Open a file from DEFAULT-DIR (e.g., Downloads), and copy it to the
current directory in Dired."
  (interactive
   (list (read-directory-name "Select default directory: " "~/Downloads/")))
  (let* ((file-to-copy (read-file-name "Select file to copy: " default-dir))
         (current-dir (or (dired-current-directory)
                          default-directory))
         (file-name (file-name-nondirectory file-to-copy))
         (destination (expand-file-name file-name current-dir)))
    (copy-file file-to-copy destination)
    (message "Copied %s to %s" file-to-copy destination)))


(defun dired-combine-pdfs (output-file)
  "Combine marked PDF files in dired into a single PDF with OUTPUT-FILE as
the name."
  (interactive "FOutput PDF file: ")
  (let* ((files (dired-get-marked-files)) ;; Get the marked files
         (quoted-files (mapconcat #'shell-quote-argument files " ")))
    (if (not (cl-every (lambda (file) (string-suffix-p ".pdf" file t)) files))
        (error "All marked files must be PDF files")
      (if (executable-find "pdfunite")
          (progn
            (call-process-shell-command
             (format "pdfunite %s %s" quoted-files (shell-quote-argument output-file)))
            (message "PDFs combined into %s" output-file))
        (if (executable-find "pdftk")
            (progn
              (call-process-shell-command
               (format "pdftk %s cat output %s" quoted-files (shell-quote-argument output-file)))
              (message "PDFs combined into %s" output-file))
          (error "Neither `pdfunite` nor `pdftk` is available on your system!"))))))


(defun dired-split-pdf (output-name-prefix)
  "Split the selected PDF file in dired into individual pages, numbering
them sequentially.
OUTPUT-NAME-PREFIX will be used as the base for the output file names."
  (interactive "sOutput name prefix (e.g., 'page'): ")
  (let ((file (dired-get-file-for-visit))) ;; Get the selected file
    (if (not (string-suffix-p ".pdf" file t))
        (error "Selected file is not a PDF")
      (if (executable-find "pdfseparate")
          (let* ((output-pattern (format "%s%%d.pdf" (shell-quote-argument output-name-prefix))))
            ;; Run pdfseparate
            (call-process-shell-command
             (format "pdfseparate %s %s"
                     (shell-quote-argument file)
                     output-pattern))
            (message "PDF split into individual pages with prefix: %s" output-name-prefix))
        (error "`pdfseparate` is not available on your system!")))))


(defun dired-copy-with-suffix (suffix)
  "Dublicate the marked file in Dired, appending SUFFIX to its name."
  (interactive "sEnter suffix (e.g., -1, 01): ")
  (let ((file (dired-get-file-for-visit))) ;; Get the marked file
    (if file
        (let* ((dir (file-name-directory file))
               (name (file-name-base file))
               (ext (file-name-extension file))
               (new-name (concat name suffix (if ext (concat "." ext) "")))
               (new-path (expand-file-name new-name dir)))
          (copy-file file new-path)
          (message "Copied to %s" new-path))
      (message "No file selected."))))


(defun rename-roo-invoice-file ()
  "Rename the file under cursor in Dired/Dirvish
to match specific naming conventions for ROO invcoice."
  (interactive)
  (let* ((file-type (completing-read
                     "Select file type: "
                     '("unit-1" "unit-2")))
         (extension (file-name-extension (dired-get-file-for-visit)))
         (base-name
          (concat "Invoice "
                  invoice-num " for Call Out "
                  call-out-number
                  (cond ((string= file-type "unit-1") " SL Unit-1 ")
                        ((string= file-type "unit-2") " SL Unit-2 "))
                  inv-name-date
                  "." extension))
         (current-file (dired-get-file-for-visit)))
    (rename-file current-file base-name)
    (revert-buffer) ;; Refresh Dired buffer to show the new name
    (message "Renamed to: %s" base-name)))

(defun rename-daily-report-file ()
  "Rename the file under cursor in Dired/Dirvish
to match specific naming conventions."
  (interactive)
  (let* ((file-type (completing-read
                     "Select file type: "
                     '("Daily" "Pre" "Post")))
         (extension (file-name-extension (dired-get-file-for-visit)))
         (base-name
          (concat wellname
                  "_NOES_"
                  (cond ((string= file-type "Pre") "DR_Pre Job WSD_")
                        ((string= file-type "Daily") (concat activity-dr "_Daily Report_" ))
                        ((string= file-type "Post") "DR_Post Job WSD_"))
                  year month day
                  "." extension))
         (current-file (dired-get-file-for-visit)))
    (rename-file current-file base-name)
    (revert-buffer) ;; Refresh Dired buffer to show the new name
    (message "Renamed to: %s" base-name)))


(defun rename-sgs-data-file ()
  "Rename the file under cursor in Dired/Dirvish
to match specific naming conventions."
  (interactive)
  (let* ((file-type (completing-read
                     "Select file type: "
                     '("1-Top" "1-Bottom" "2-Top" "2-Bottom" "t-Top" "t-Bottom")))
         (extension (file-name-extension (dired-get-file-for-visit)))
         (base-name
          (concat wellname
                  "_NEOS_SGS Data_"
                  (cond ((string= file-type "1-Top") "8701_Top_") ;; Unit-1
                        ((string= file-type "1-Bottom") "8700_Bot_") ;; Unit-1
                        ((string= file-type "2-Top") "8698_Top_") ;; Unit-2
                        ((string= file-type "2-Bottom") "8699_Bot_") ;; Unit-2
                        ((string= file-type "t-Top") "E1734_Top_") ;; TEEPRH
                        ((string= file-type "t-Bottom") "E1733_Bot_") ;; TEEPRH
                        ) ;; Adjust field prefix as needed
                  year month day
                  "." extension))
         (current-file (dired-get-file-for-visit)))
    (rename-file current-file base-name)
    (revert-buffer) ;; Refresh Dired buffer to show the new name
    (message "Renamed to: %s" base-name)))

;; This code to make the files in dired go to downlaod
;; so I can use it in the mail or whatsapp easlity
(defun dired-copy-to-downloads ()
  "this code used to highlight a file and copy it to downloads folder"
  (interactive)
  (let ((files (if (eq last-command 'dired-next-line)
                   (list (dired-get-filename))
                 (dired-get-marked-files))))
    (dolist (file files)
      (let ((target (expand-file-name (file-name-nondirectory file)  "~/Downloads/")))
        (copy-file file target t))))
  (message "copied to Downloads"))

;; (defun my-dired-copy-to-clippy ()
;;   "This close will use clippy to copy files to clipboard"
;;   (interactive)
;;   (let ((clippy-filename (dired-get-filename)))
;;     (shell-command (format "clippy %s" (shell-quote-argument clippy-filename))))
;;   (message "Clippy Copy"))
(defun my-dired-copy-to-clippy ()
  "Use `clippy` to copy all marked files in Dired to the clipboard."
  (interactive)
  (let* ((files (dired-get-marked-files))     ;; list of paths [web:16]
         (args  (mapconcat #'shell-quote-argument files " ")))
    (shell-command (format "clippy %s" args))
    (message "Clippy: copied %d files" (length files))))


;; Insert date time while typing in insert mode
;; I use this for renmaing the folder and files
(defun insert-today-date-and-filename ()
  "Insert date in yymmdd format while in insert mode"
  (interactive)
  (insert (format-time-string "%Y%m%d")))
(evil-define-key 'insert 'global (kbd "C-;") 'insert-today-date-and-filename)
(evil-define-key 'insert minibuffer-local-filename-completion-map (kbd "C-;") 'insert-today-date-and-filename)

;; Create a folder witht he datetime
(defun my-create-dated-folder ()
  "Create a folder and insert the date as prefix"
  (interactive)
  (let* ((date-prefix (format-time-string "%Y%m%d_"))
         (folder-name (read-string "Folder name: " date-prefix)))
    (dired-create-directory folder-name)))


;; Print the files in the printer
(defun my-dired-print-marked-pdfs ()
  "Print marked PDF files in Dired."
  (interactive)
  (let ((files (dired-get-marked-files)))
    (dolist (file files)
      (start-process "print-pdf" nil "lp" file))
    (message "Printing marked PDFs...")))


(defun my-dirvish-menu-quickselect ()
  "Open Dirvish ls switches menu and automatically select options."
  (interactive)
  (call-interactively 'dirvish-ls-switches-menu)
  (execute-kbd-macro (kbd "O H G <M-return>")))


(defun check-pdf-with-cpdf ()
  "In a Dired buffer, run cpdf -check on the PDF file at point.
Output is shown in the *cpdf-output* buffer."
  (interactive)
  (unless (derived-mode-p 'dired-mode)
    (error "This command must be run from a Dired buffer"))
  (let (filename
        output-buffer-name
        output-buffer)
    (setq filename (dired-get-filename))
    (setq output-buffer-name "*cpdf-output*")
    (if (and filename (string-match-p "\\.pdf\\'" filename))
        (progn
          (setq output-buffer (if (get-buffer output-buffer-name)
                                   (progn
                                     (kill-buffer output-buffer-name)
                                     (get-buffer-create output-buffer-name))
                                 (get-buffer-create output-buffer-name)))

          (with-current-buffer output-buffer
            (erase-buffer))
          (display-buffer output-buffer)
          (shell-command
           (format "gs -o /dev/null -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress %s" (shell-quote-argument filename))
                         output-buffer))
      (message "Point is not on a PDF file."))))


(defun neos-read-assets-lisp ()
  "Opens NEOS asset file and read it, TODO: make it select several lines instead of one line"
  (interactive)
  (let ((assets-file "~/org/Exported_database_20251110.csv"))
    (unless (file-exists-p assets-file)
      (message "File not available at temp directory. Creating a new csv file."))

    (let* ((command (format "awk -F, '{printf \"%%-8s %%-12s %%-20s %%-20s %%-5s %%-10s %%-5s %%-5s %%-5s %%-5s %%-5s %%-5s %%-5s\\n\", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13}' %s" assets-file))
           (assets-list (split-string (shell-command-to-string command) "\n" t)))

      (let ((selected-asset (completing-read "Select Asset: " assets-list nil t)))
        (with-current-buffer (get-buffer-create "*completing-read-assets-result*")
          (erase-buffer)
          (insert selected-asset)
          (pop-to-buffer (current-buffer)))))))



(defun my/arabic-text-direction-right ()
  "Change the text direction for arabic readers"
  (interactive)
  (setq bidi-paragraph-direction 'right-to-left))

(defun my/arabic-text-direction-left ()
  "Change the text direction for english readers"
  (interactive)
  (setq bidi-paragraph-direction 'left-to-right))


(defun my-pdftk-pdf-flatten ()
  "Run `pdftk ... flatten` on the file at point or all marked PDFs.
Each INPUT.pdf produces INPUT__flatten.pdf in the same directory."
  (interactive)
  (let* ((files (dired-get-marked-files))
         (pdfs  (seq-filter (lambda (f)
                              (string-match-p "\\.pdf\\'" f))
                            files)))
    (unless pdfs
      (user-error "No PDF files selected"))
    (dolist (input pdfs)
      (let* ((base   (file-name-sans-extension input))
             (output (concat base "__flatten.pdf"))
             (cmd    (format "pdftk %s output %s flatten"
                             (shell-quote-argument input)
                             (shell-quote-argument output))))
        (message "Flattening %s -> %s" input output)
        (let ((exit (shell-command cmd
                                   "*pdftk-flatten*"
                                   "*pdftk-flatten-errors*")))
          (if (zerop exit)
              (message "Created %s" output)
            (message "pdftk failed on %s (see *pdftk-flatten-errors*)" input)))))))
