;;; +custom-config/org-agenda.el -*- lexical-binding: t; -*-

;; ==================== Org mode ====================================
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(after! org
  (setq org-log-into-drawer t
        org-log-done 'time
        org-ellipsis " ↴↴↴"
        org-log-done 'note
        org-hide-emphasis-markers t
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-timestamp-if-done t
        org-agenda-skip-deadline-if-done t))

;; Configuring the journalling table
(setq org-journal-date-prefix "#+TITLE:"
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org")

;; Adding pretty org-bullets as per the link
;; http://mpas.github.io/posts/2020/10/16/20201016-org-bullets-doom-emacs/
;; (setq
;;     org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿"))

(setq org-agenda-block-separator 8411)
(setq org-agenda-custom-commands
      '(("v" "A better agenda view"
         ((tags "today"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Today")))
          (alltodo "")))))


(add-hook 'org-agenda-mode-hook
          (lambda ()
            (setq bidi-display-reordering 'bidi-paragraph-direction)))


(defface my-org-todo-yellow-face
  '((t (:foreground "yellow" :weight bold)))
  "Face for yellow TODO items."
  :group 'org-faces)
(defface my-org-todo-purple-face
  '((t (:foreground "purple" :weight bold)))
  "Face for purple TODO items."
  :group 'org-faces)
(defface my-org-todo-red-face
  '((t (:foreground "red" :weight bold)))
  "Face for red TODO items."
  :group 'org-faces)
(defface my-org-todo-blue-face
  '((t (:foreground "blue" :weight bold)))
  "Face for blue TODO items."
  :group 'org-faces)
(defface my-org-todo-orange-face
  '((t (:foreground "orange" :weight bold)))
  "Face for orange TODO items."
  :group 'org-faces)

(setq org-todo-keywords
      '((sequence
         "TODO(t)"  ; A task that needs doing & is ready to do
         "PROJ(p)"  ; A project, which usually contains other tasks
         "PRPO(r)"  ; A recurring task
         "FOLW(f)"  ; Follow up taks
         "STRT(s)"  ; A task that is in progress
         "ORDR(w)"  ; Something external is holding up this task
         "INVC(i)"  ; Invoice
         "HOLD(h)"  ; This task is paused/on hold because of me
         "CARA(c)"  ; An unconfirmed and unapproved task or notion
         "|"
         "DONE(d)"  ; Task successfully completed
         "KILL(k)") ; Task was cancelled, aborted, or is no longer applicable
        (sequence
         "[ ](T)"   ; A task that needs doing
         "[-](S)"   ; Task is in progress
         "[?](W)"   ; Task is being held up or paused
         "|"
         "[X](D)")  ; Task was completed
        (sequence
         "|"
         "OKAY(o)"
         "YES(y)"
         "NO(n)"))
      org-todo-keyword-faces
      '(("[-]"  . +org-todo-active)
        ("STRT" . +org-todo-active)
        ("FOLW" . +org-todo-active)
        ("[?]"  . +org-todo-onhold)
        ("ORDR" . my-org-todo-yellow-face)
        ("PRPO" . my-org-todo-purple-face)
        ("CARA" . my-org-todo-red-face)
        ("WAIT" . +org-todo-onhold)
        ("INVC" . +org-todo-onhold)
        ("HOLD" . +org-todo-onhold)
        ("PROJ" . my-org-todo-orange-face)
        ;; ("PROJ" . +org-todo-project)
        ("NO"   . +org-todo-cancel)
        ("KILL" . +org-todo-cancel)))
