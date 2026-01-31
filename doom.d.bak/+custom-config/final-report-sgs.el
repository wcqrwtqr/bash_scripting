;;; +custom-config/final-report-sgs.el -*- lexical-binding: t; -*-


(defun replace-docx-variables-v2 (input-file output-file replacements)
  "Replace variables in DOCX file, including headers and footers.
This script takes a template word file I've made in dowloads folder
and replaces the tags with the data needed for the final report.
It unpack the docx to zip and then finds the tages {{text}} with
the data we need and then puts the docx file again
I've made a tempate files and added tags {{tag}} so this code
will open the word and find each tag and relace it so I don't
need to open the docx file and type each line in it."
  (let ((temp-dir (make-temp-file "docx" t)))
    (unwind-protect
        (progn
          ;; Extract the DOCX contents
          (shell-command (format "unzip -q %s -d %s" input-file temp-dir))
          ;; Define the list of XML files to process
          (let* ((word-dir (concat temp-dir "/word/"))
                 (files-to-process
                  (append
                   (list (concat word-dir "document.xml"))
                   (directory-files word-dir t "header[0-9]*\\.xml")
                   (directory-files word-dir t "footer[0-9]*\\.xml"))))
            ;; Process each XML file
            (dolist (file files-to-process)
              (when (file-exists-p file)
                (with-temp-buffer
                  (insert-file-contents file)
                  ;; Go over all variables and replace them
                  (dolist (pair replacements)
                    (goto-char (point-min))
                    (while (search-forward (car pair) nil t)
                      (replace-match (cdr pair) t t)))
                  ;; Save changes
                  (write-region (point-min) (point-max) file)))))
          ;; Repack the DOCX
          (let ((zip-command (format "cd %s && zip -r %s ." temp-dir output-file)))
            (shell-command zip-command))
          ;; Cleanup
          (delete-directory temp-dir t)))))


(defun create-sgs-folder-structure (base-folder)
  "Interactively select a BASE-FOLDER starting from the current directory
and create an SGS folder structure inside it, including a support/ folder
in Raw Data/."
  (interactive
   (list (read-directory-name "Select base folder: " default-directory)))
  (let* ((sgs-path (expand-file-name "SGS/" base-folder))
         (folders '("Final Report/" "Raw Data/" "SGS submission/"))
         (support-path (expand-file-name "support/" (expand-file-name "Raw Data/" sgs-path))))
    ;; Create the SGS folder
    (make-directory sgs-path t)
    ;; Create the subfolders inside SGS
    (dolist (folder folders)
      (make-directory (expand-file-name folder sgs-path) t))
    ;; Create the support folder inside Raw Data
    (make-directory support-path t)
    (message "SGS folder structure created at %s" sgs-path)))
