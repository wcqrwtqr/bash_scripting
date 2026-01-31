;;; +custom-config/bible-verses.el -*- lexical-binding: t; -*-

(require 'url-util)
(require 'url)
(defvar my-constructed-url nil
  "Variable to store the constucted url")

(defvar my-constructed-url-chapter nil
  "Variable to store the constucted url for chapter")

(defvar my-constructed-url-arbic nil
  "Variable for holding the url for arabic bible")

;; ============= Version 00
;; Good to keep this as I might use it in future to on how to
;; - navigate to to a file and read its content
;; (defun read-strings-from-file (file-path)
;;   "Read lines from FILE-PATH and return them as a list of strings"
;;   (with-temp-buffer
;;     (insert-file-contents file-path)
;;     (split-string (buffer-string) "\n" t)))
;; ============= Version 01
;; (defun read-strings-from-file ()
;;   "Read lines from FILE-PATH and return them as a list of strings"
;;   (with-temp-buffer
;;     (insert-file-contents "~/.myrepos/bash_scripting/bible parsing/bible_list.txt")
;;     (split-string (buffer-string) "\n" t)))
;; ============= Version 02

(defun read-strings-from-file (arg)
  "Read lines from files based on ARG (1 or 2) and return
them as a list of strings."
  (with-temp-buffer
    (let ((file-path
           (cond
            ((equal arg 1) "~/.myrepos/bash_scripting/bible parsing/bible_list.txt")
            ((equal arg 2) "~/.myrepos/bash_scripting/bible parsing/bible_list_for_chapter.txt")
            ((equal arg 3) "~/.myrepos/bash_scripting/bible parsing/bible_list_for_chapter_ar.txt")
            (t (error "Invalid argument for read-string-from-file: %s" arg)))))
      (insert-file-contents file-path)
      (mapcar (lambda (line)
                (let ((first-comma (string-match "," line)))
                  (cons line (if first-comma
                                 (replace-regexp-in-string "\\\\" "" (substring line 0
                                        first-comma))
                               line))))
      (split-string (buffer-string) "\n" t)))))


(defun my/get-bible-verse ()
  "Present the list of the bible chapter to select from and store it in
        a variable to be used in fetching the web content of the verse"
  (interactive)
  (let* ((default-directory "~/.myrepos/bash_scripting/bible parsing/")
         ;; I removed these two lines since I want to go to the file without navigating
         ;; (file-path (read-file-name "Select text file: " default-directory))
         ;; (strings (read-strings-from-file file-path)) ; Below call for the file
         (strings (read-strings-from-file 1)) ;; updated from the line above it
         (selected (completing-read "Select string: " strings)) ; read the lines of txt file
         (chapter (read-from-minibuffer "Enter Chapter No: "))
         (verse (read-from-minibuffer "Enter Verse No: ")))
    (setq my-constructed-url (concat selected chapter "-" verse ".htm"))
    (message "Constructed URL: %s" my-constructed-url)
    (my/fetch-webpage-content)))

(defun my/get-bible-chapter ()
  "Present the list of the bible chpates to select from and store it in
        a variable to be used in fetching the web content of the chapter"
  (interactive)
  (let* ((strings (read-strings-from-file 2)) ;; updated from the line above it
         (selected (completing-read "Select string: " strings)) ; read the lines of txt file
         (chapter (read-from-minibuffer "Enter Chapter No: ")))
    (setq my-constructed-url-chapter (concat selected chapter ".htm"))
    (message "Constructed URL: %s" my-constructed-url-chapter)
    (my/fetch-webpage-content-chapter)))


(defun my/get-bible-arabic-verse ()
  "Present the list of the bible arabic to select from and store it in
        a variable to be used in fetching the web content of the chapter"
  (interactive)
  (let* ((string-pairs (read-strings-from-file 3))
         (strings (mapcar #'car string-pairs))
         (selected-pair (assoc (completing-read "Select Chapter: " strings)
                               string-pairs))
         (selected-book (cdr selected-pair))
         (chapter (read-from-minibuffer "Enter Chapter No: ")))
         ;; (strings (read-strings-from-file 3)) ;; updated from the line above it
         ;; (selected (completing-read "Select string: " strings)) ; read the lines of txt file
         ;; (chapter (read-from-minibuffer "Enter Chapter No: ")))
    (setq my-constructed-url-arbic (concat
                        "https://st-takla.org/Bibles/BibleSearch/showChapter.php?"
                        ;; selected
                        selected-book
                        "&chapter="
                        chapter))
    (message "Constructed URL: %s" my-constructed-url-arbic)
    (my/fetch-webpage-content-arabic)
    ))

(defun my/fetch-webpage-content-arabic ()
  "Fetch the webpage content for the constructed URL and display the HTML"
  (interactive)
  (unless my-constructed-url-arbic
    (error "No Url constructed, Run `my/get-bible-verse`"))
  (url-retrieve my-constructed-url-arbic 'my/display-html-content-chapter-arbic))

(defun my/fetch-webpage-content ()
  "Fetch the webpage content for the constructed URL and display the HTML"
  (interactive)
  (unless my-constructed-url
    (error "No Url constructed, Run `my/get-bible-verse`"))
  (url-retrieve my-constructed-url 'my/display-html-content))

(defun my/fetch-webpage-content-chapter ()
  "Fetch the webpage content for the constructed URL and display the HTML
        for the bible chatper"
  (interactive)
  (unless my-constructed-url-chapter
    (error "No Url constructed, Run `my/get-bible-chapter`"))
  (url-retrieve my-constructed-url-chapter 'my/display-html-content-chapter))

(defun my/display-html-content (status)
  "Callback function to process the HTTP response and display the HTML content
And get the content of bible verse"
  (let ((header-end (search-forward "\n\n" nil t)))
    (when header-end
      (let ((html-content (buffer-substring-no-properties header-end (point-max))))
        (with-current-buffer (get-buffer-create "*Webpage Content*")
          (erase-buffer)
          (let ((start 0)
                (result '()))
            (while (string-match
                    "<span class=\"versiontext\"><a .*?>\\(.*?\\)</a></span><br />\\(.*?\\)<span"
                                 html-content
                                 start)
              (let ((version-content (match-string 1 html-content))
                    (text-content (my/remove-html-tags
                                   (my/decode-html-entities
                                    (match-string 2 html-content)))))
                (setq result (append result (list (concat "- ~" version-content "~: "
                                                          text-content "\n")))))
              (setq start (match-end 0)))
            (let ((final-result (mapconcat 'identity result )))
              (insert final-result))
            ;; Remove the unwanted lines
            (goto-char (point-min))
            (dotimes (_ 8)
              ;; Go to first line and move down n times
              (search-forward "\n" nil t))
            (delete-region (point) (point-max)))
          (goto-char (point-min))
          (org-mode)
          (pop-to-buffer (current-buffer)))))))


(defun my/display-html-content-chapter (status)
  "Callback function to process the HTTP response and display the HTML content
And get the content of bible chapter"
  (let ((header-end (search-forward "\n\n" nil t)))
    (when header-end
      (let ((html-content (buffer-substring-no-properties header-end (point-max))))
        (message "***Begin*** - %s" html-content)
        (with-current-buffer (get-buffer-create "*Webpage Chapter*")
          (erase-buffer)
          (let ((start 0)
                (result '()))
            (while (string-match
                    "<span class=\"reftext\">.*?<b>\\([0-9].*?\\)</b></a></span>\\(.*?\\)\n"
                                 html-content
                                 start)
              (let ((chapter-content (match-string 1 html-content))
                    (text-content (my/remove-html-tags
                                   (my/decode-html-entities
                                    (match-string 2 html-content)))))
                (setq result (append result (list (concat "- ~" chapter-content "~ "
                                                          text-content
                                                          "\n")))))
              (setq start (match-end 0)))
            (let ((final-result (mapconcat 'identity result )))
              (insert final-result))
          (goto-char (point-min))
          (org-mode)
          (pop-to-buffer (current-buffer))))))))


(defun my/display-html-content-chapter-arbic (status)
  "Callback function to process the HTTP response and display the HTML content
And get the content of bible chapter in arbaic"
  (let ((header-end (search-forward "\n\n" nil t)))
    (when header-end
      (let ((html-content (buffer-substring-no-properties header-end (point-max))))
        ;; (message "***Begin*** - %s" html-content)
        (with-current-buffer (get-buffer-create "*Webpage Arabic Chapter*")
          (erase-buffer)
          (let ((start 0)
                (result '()))
            (while (string-match
                    "<b><a class\=\"verse-num\".*?>\\([0-9]+\\)</a>.*?>\\(.*?\\)</div"
                                 html-content
                                 start)
              (let ((chapter-content (match-string 1 html-content))
                    (text-content (my/remove-html-tags
                                   (my/decode-html-entities
                                    (match-string 2 html-content)))))
                (setq result (append result (list (concat "- ~" chapter-content "~ "
                                                          text-content
                                                          "\n")))))
              (setq start (match-end 0)))
            (let ((final-result (mapconcat 'identity result )))
              (insert final-result)
              ;; This decode to be showing in arabic
              (set-buffer-multibyte t)
              (decode-coding-region (point-min) (point-max) 'utf-8))
          (goto-char (point-min))
          ;; (setq bidi-paragraph-direction 'right-to-left)
          (org-mode)
          (setq bidi-paragraph-direction 'right-to-left)
          (pop-to-buffer (current-buffer))))))))


(defun my/decode-html-entities (text)
  "Decode basic HTML entites in Text"
  (replace-regexp-in-string
   "&#[0-9]+;"
   (lambda (match)
     (char-to-string (string-to-number (substring match 2 -1))))
   text))

(defun my/remove-html-tags (text)
  "Remove the spans tags the show in the text"
  (replace-regexp-in-string "<[^>]+>" "" text))
