;;; +custom-config/window-setup.el -*- lexical-binding: t; -*-

;; Check this code
(defun my-setup-windows-neos ()
  "Open a specific window layout based on user selection."
  (interactive)
  (let* ((choices '(("roo-1" . ("/Volumes/WL-SL/02 Slickline/01 Jobs/BECL BP/Unit1/Daily Report/2025"
                                "~/org/send-mail.org"
                                "/Volumes/WL-SL/02 Slickline/01 Jobs/BECL BP/Unit1/Next well Mail Communication"))
                    ("roo-2" . ("/Volumes/WL-SL/02 Slickline/01 Jobs/BECL BP/Unit2/Daily Report/2025"
                                "~/org/send-mail.org"
                                "/Volumes/WL-SL/02 Slickline/01 Jobs/BECL BP/Unit1/Next well Mail Communication"))
                    ("teeprh" . ("/Volumes/WL-SL/02 Slickline/01 Jobs/TEEPRH/Operation/Daily Report"
                                "~/org/send-mail.org"
                                "/Volumes/WL-SL/02 Slickline/01 Jobs/TEEPRH/Operation/Well Intervention Program"))))
         (selection (completing-read "Choose layout: " (mapcar #'car choices) nil t))
         (dirs (cdr (assoc selection choices))))
    (when dirs
      (delete-other-windows)
      (let ((w1 (selected-window)))     ;; Main window
        (dired (nth 0 dirs))            ;; Open first folder
        (split-window-below)
        (other-window 1)
        (find-file (nth 1 dirs))        ;; Open second folder
        (split-window-right)
        (other-window 1)
        (dired (nth 2 dirs))            ;; Open third folder
        (other-window 1)))))


(defun open-downloads-in-bottom-window-with-dirvish ()
  "Split window horizontally, open ~/Downloads in Dirvish,
sort by time, and go to last row."
  (interactive)
  (let ((downloads-dir "~/Downloads"))
    ;; Split the window and move to the new one
    (split-window-below)
    (other-window 1)
    ;; Open Dirvish in Downloads
    ;; (dirvish downloads-dir)
    (dired downloads-dir)
    ;; Set sorting to time descending
    (call-interactively 'dirvish-quicksort)
    ;; Move to the bottom of the buffer
    (evil-goto-line (point-max))
    (dired-previous-line 1)))
