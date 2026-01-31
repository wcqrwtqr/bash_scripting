;;; calc-date-time.el calculate the date difference  -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Mohammed Albatati
;;
;; Author: Mohammed Albatati <mohalbatati@gmail.com>
;; Maintainer: Mohammed Albatati <mohalbatati@gmail.com>
;; Created: December 25, 2025
;; Modified: December 25, 2025
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/mohammedalbatati/calc-date-time
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;; the code need to paste the from the csv file and it will calcualte the diff time
;;; Code:

;; This code is the version 00
;; Does work fine but I need to clean up the inut datas and put them myslef
;;
(let* ((s1 "02/11/2025 16:02:45")
       (s2 "08/11/2025 20:33:00")
       (time1 (apply #'encode-time
                     (parse-time-string (format-time-string "%Y-%m-%d %H:%M:%S"
                                                            (encode-time
                                                             0
                                                             (string-to-number (substring s1 14 16))
                                                             (string-to-number (substring s1 11 13))
                                                             (string-to-number (substring s1 3 5))
                                                             (string-to-number (substring s1 0 2))
                                                             (string-to-number (substring s1 6 10)))))))
       (time2 (apply #'encode-time
                     (parse-time-string (format-time-string "%Y-%m-%d %H:%M:%S"
                                                            (encode-time
                                                             19
                                                             (string-to-number (substring s2 14 16))
                                                             (string-to-number (substring s2 11 13))
                                                             (string-to-number (substring s2 3 5))
                                                             (string-to-number (substring s2 0 2))
                                                             (string-to-number (substring s2 6 10)))))))
       (diff (float-time (time-subtract time2 time1)))
       (hours (/ diff 3600.0)))
  (kill-new (format "Time diff is %.2f hours" hours))
  (message "Difference: %.3f hours" hours))


;; Version01 Better code below, but I need to remove the spaces
;; This code is better in code but the same thing, I need to
;; put the variables then remove the spaces
(let* ((s1 "02/11/2025 16:02:45")
       (s2 "02/11/2025 20:33:01")
       (parse-fn
        (lambda (s)
          (let* ((date-part (split-string (car (split-string s " ")) "/"))
                 (time-part (split-string (cadr (split-string s " ")) ":"))
                 (day (string-to-number (nth 1 date-part)))
                 (mon (string-to-number (nth 0 date-part)))
                 (year (string-to-number (nth 2 date-part)))
                 (hour (string-to-number (nth 0 time-part)))
                 (min (string-to-number (nth 1 time-part)))
                 (sec (string-to-number (nth 2 time-part))))
            (encode-time sec min hour day mon year))))
       (time1 (funcall parse-fn s1))
       (time2 (funcall parse-fn s2))
       (diff-secs (float-time (time-subtract time2 time1)))
       (hours (/ diff-secs 3600.0)))
  (kill-new (format "Time diff is %.2f hours" hours))
  (message "Difference: %.3f hours" hours))

;; Version3 which is better for me
(let* ((s1 "02/11/2025     16:02:45")
       (s2 "08/11/2025     20:33:01")
       (parse-fn
        (lambda (s)
          (let* ((parts (split-string s " " t))     ;; ignore empty fields
                 (date-part (split-string (nth 0 parts) "/"))
                 (time-part (split-string (nth 1 parts) ":"))
                 (day (string-to-number (nth 1 date-part)))
                 (mon (string-to-number (nth 0 date-part)))
                 (year (string-to-number (nth 2 date-part)))
                 (hour (string-to-number (nth 0 time-part)))
                 (min (string-to-number (nth 1 time-part)))
                 (sec (string-to-number (nth 2 time-part))))
            (encode-time sec min hour day mon year))))
       (time1 (funcall parse-fn s1))
       (time2 (funcall parse-fn s2))
       (diff-secs (float-time (time-subtract time2 time1)))
       (hours (/ diff-secs 3600.0)))
  (kill-new (format "Time diff is %.2f hours" hours))
  (message "Difference: %.3f hours" hours))


(defun my-time-diff-from-strings (s1 s2)
  "Compute the time difference in hours between two date-time strings.
Accepts format like `DD/MM/YYYY     HH:MM:SS` with variable spacing.
Prompts interactively, defaults to latest `kill-ring entries"
  (interactive
   (let* ((k1 (car kill-ring))
          (k2 (cadr kill-ring)))
     (list
      (read-string (format "First timestamp [%s]: " (or k1 "")) nil nil k1)
      (read-string (format "Second timestamp [%s]: " (or k2 "")) nil nil k2))))
  (let* ((parse-fn
          (lambda (s)
            (let* ((parts (split-string s " " t)) ;; ignore extra spaces
                   (date-part (split-string (nth 0 parts) "/"))
                   (time-part (split-string (nth 1 parts) ":"))
                   (day (string-to-number (nth 1 date-part)))
                   (mon (string-to-number (nth 0 date-part)))
                   (year (string-to-number (nth 2 date-part)))
                   (hour (string-to-number (nth 0 time-part)))
                   (min (string-to-number (nth 1 time-part)))
                   (sec (string-to-number (nth 2 time-part))))
              (encode-time sec min hour day mon year))))
         (time1 (funcall parse-fn s1))
         (time2 (funcall parse-fn s2))
         (diff-secs (float-time (time-subtract time2 time1)))
         (hours (/ diff-secs 3600.0))
         (result (format "Time diff is %.2f hours" hours)))
    (kill-new result)
    (message "%s" result)))


(defun my-dired-extract-two-columns-sgs-data ()
  "In Dired, visit marked file and yank two space-separated columns
from line 20 and from 5 lines before the end.

Rough Vim analogy:
- Enter file from Dired.
- gg20j
- 2yE  (yank first two space-separated fields)
- Gk5
- 2yE  (same yank again)."
  (interactive)
  (unless (derived-mode-p 'dired-mode)
    (user-error "Run this command from Dired"))
  ;; Get first marked file, or file at point if none marked
  (let* ((files (dired-get-marked-files))
         (file  (car files)))
    (unless file
      (user-error "No file selected"))
    ;; Visit file in current window
    (find-file file)
    ;; Ensure we work with whole buffer
    (goto-char (point-min))
    ;; Go down 20 lines (like gg20j)
    (forward-line 20)
    ;; Function to yank first two ‘columns’ (space-separated fields)
    (let ((yank-two-columns
           (lambda ()
             (beginning-of-line)
             ;; Move over two fields separated by spaces
             (let ((start (point)))
               ;; Skip leading spaces
               (skip-chars-forward " ")
               ;; First field
               (skip-chars-forward "^ ")
               ;; Skip spaces between fields
               (skip-chars-forward " ")
               ;; Second field
               (skip-chars-forward "^ ")
               (kill-ring-save start (point))))))
      ;; First yank (line ~21)
      (funcall yank-two-columns)
      ;; Now go to end and up 5 lines (like Gk5)
      (goto-char (point-max))
      (forward-line -5)
      ;; Second yank
      (funcall yank-two-columns))))


(defun my-dired-get-two-points ()
  "From Dired, extract first two space-separated columns from line 21
and 5 lines before end of marked file. Each as separate kill-new."
  (interactive)
  (unless (derived-mode-p 'dired-mode)
    (user-error "Run this command from Dired"))
  (let* ((files (dired-get-marked-files))
         (file  (car files)))
    (unless file
      (user-error "No file selected"))
    (with-temp-buffer
      (insert-file-contents file)
      (let* ((lines (split-string (buffer-string) "\n" t))
             (target1 (nth 20 lines))                    ; line 21 (0-indexed)
             (target2 (nth (- (length lines) 6) lines))  ; 5 lines from bottom
             (extract-columns
              (lambda (line)
                (when line
                  (let ((fields (split-string line "[ \t]+" t)))
                    (mapconcat #'identity (cl-subseq fields 0 2) " "))))))
        ;; First kill-new: top point (line 21, first two columns)
        (let ((top-point (funcall extract-columns target1)))
          (kill-new top-point))
        ;; Second kill-new: bottom point (5th from end, first two columns)
        (let ((bottom-point (funcall extract-columns target2)))
          (kill-new bottom-point))
        (message "Kill ring: 1st=%s  2nd=%s" target1 target2)))))

(defun my-dired-get-two-points ()
  "From Dired, read marked file and:
- Yank the first two fields from line 21 (top region), kill-new #1
- Then yank the first two fields from 5 lines before the end, kill-new #2."
  (interactive)
  (unless (derived-mode-p 'dired-mode)
    (user-error "Run this command from Dired"))
  (let* ((files (dired-get-marked-files))
         (file  (car files)))
    (unless file
      (user-error "No file selected"))
    ;; Process file silently
    (with-temp-buffer
      (insert-file-contents file)
      (let* ((lines (split-string (buffer-string) "\n" t))
             (extract-columns
              (lambda (line)
                (when line
                  (let ((fields (split-string line "[ \t]+" t)))
                    (mapconcat #'identity (cl-subseq fields 0 2) " "))))))
        ;; === First kill (top, 21st line) ===
        (let ((line1 (nth 20 lines))) ;; 0-index
          (when line1
            (let ((val1 (funcall extract-columns line1)))
              (kill-new val1)
              (message "Top value copied: %s" val1))))
        ;; === Second kill (bottom, 5 lines from end) ===
        (let ((line2 (nth (- (length lines) 6) lines)))
          (when line2
            (let ((val2 (funcall extract-columns line2)))
              (kill-new val2)
              (message "Bottom value copied: %s" val2))))))))



(provide 'calc-date-time)
;;; calc-date-time.el ends here
