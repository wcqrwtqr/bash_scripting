;;; +custom-config/my-mailing-script.el -*- lexical-binding: t; -*-

(defun send-mail-with-mac-mail (to-list cc-list subject body)
  "Send an email using macOS Mail app.
TO-LIST is a list of recipient email addresses.
SUBJECT is the email subject.
BODY is the email content."
  (let ((to-recipients (mapconcat (lambda (email)
                                    (format "make new to recipient at end of to recipients with properties {address:\"%s\"}" email))
                                  to-list
                                  "\n"))
        (cc-recipients (mapconcat (lambda (email)
                                    (format "make new cc recipient at end of cc recipients with properties {address:\"%s\"}" email))
                                  cc-list
                                  "\n")))
    (let ((script (format "osascript -e 'tell application \"Mail\"
                        set newMessage to make new outgoing message with properties {subject:\"%s\", content:\"%s\", visible:true}
                        tell newMessage
                        %s
                        %s
                        activate
                        end tell
                        end tell'"
                          (replace-regexp-in-string "\"" "\\\\\"" subject)
                          (replace-regexp-in-string "\"" "\\\\\"" body)
                          to-recipients
                          cc-recipients)))
      (shell-command script))))


(defun send-mail-with-mac-mail-with-attachement (to-list cc-list subject body attachments)
  "Send an email using macOS Mail app.
TO-LIST is a list of recipient email addresses.
CC-LIST is a list of CC email addresses.
SUBJECT is the email subject.
BODY is the email content.
This scritp is used mainly for ROO Daily and SGS report
ATTACHMENTS is a list of file paths to attach."
  (let* ((to-recipients (mapconcat (lambda (email)
                                     (format "make new to recipient at end of to recipients with properties {address:\"%s\"}" email))
                                   to-list
                                   "\n"))
         (cc-recipients (mapconcat (lambda (email)
                                     (format "make new cc recipient at end of cc recipients with properties {address:\"%s\"}" email))
                                   cc-list
                                   "\n"))
         (attachment-script (mapconcat (lambda (file)
                                         (format "make new attachment with properties {file name:\"%s\"} at after the last paragraph" file))
                                       attachments
                                       "\n"))
         (script (format "osascript -e 'tell application \"Mail\"
                        set newMessage to make new outgoing message with properties {subject:\"%s\", content:\"%s\", visible:true}
                        tell newMessage
                        %s
                        %s
                        %s
                        activate
                        end tell
                        end tell'"
                         (replace-regexp-in-string "\"" "\\\\\"" subject)
                         (replace-regexp-in-string "\"" "\\\\\"" body)
                         to-recipients
                         cc-recipients
                         attachment-script)))
    (shell-command script)))


(map! :leader
      :after dired
      :map dired-mode-map
      :desc "Send Daily Report TEEPRH"
      "m t" (lambda ()
              (interactive)
              (let* ((files (dired-get-marked-files))
                     (my-title-mail (concat "NEOS Slickline " wellname " " activity " Report " day " " monthfull " " year))
                     (my-body-mail (concat "Hello team,\n\n"
                                           "Hope you are doing well.\n\n"
                                           "Please find the attached " activity " Report for " wellname
                                           " well which occurred on " day "-" month "-2025.")))
                (send-mail-with-mac-mail-with-attachement my-mail-to-teeprh-daily my-mail-cc-teeprh my-title-mail my-body-mail files)))
      :desc "Send Daily Report"
      "m n" (lambda ()
              (interactive)
              (let* ((files (dired-get-marked-files))
                     (my-title-mail (concat "NEOS Slickline " wellname " " activity " Report " day " " monthfull " " year))
                     (my-body-mail (concat "Hello team,\n\n"
                                           "Hope you are doing well.\n\n"
                                           "Please find the attached " activity " Report for " wellname
                                           " well which occurred on " day "-" month "-2025.")))
                (send-mail-with-mac-mail-with-attachement my-mail-to-daily my-mail-cc my-title-mail my-body-mail files)))
      :desc "Send SGS Report"
      "m b" (lambda ()
              (interactive)
              (let* ((files (dired-get-marked-files))
                     (my-title-mail (concat "NEOS Slickline " wellname " " activity-sgs " Report " day " " monthfull " " year))
                     (my-body-mail (concat "Hello team,\n\n"
                                           "Hope you are doing well.\n\n"
                                           "Please find the attached Slickline " activity-sgs " Results for "
                                           wellname " occurred on " day "-" month "-" year "\n\n"
                                           "The pdf file was uploaded to Aspera under the path (All/PRESSURE SURVEY/APPROVED/"
                                           wellname"_SGS_"year month day")")))
                (send-mail-with-mac-mail-with-attachement my-mail-to-sgs my-mail-cc my-title-mail my-body-mail files)))
      :desc "Send teeprh invoice"
      "m ]" (lambda ()
              (interactive)
              (let* ((files (dired-get-marked-files))
                     (my-title-mail (concat "Invoice - " invoice-num " NEOS Slickline Services " invoice-well-name " " invoice-month " 2025"))
                     (my-body-mail (concat "Dear Finance Team,\n\n"
                                           "Hope you are doing well.\n\n"
                                           "Kindly find attached the invoice \"Invoice - " invoice-num " NEOS Slickline Services " invoice-well-name " " invoice-month" 2025.pdf\" for our Slickline Unit executed on " invoice-well-name " in " invoice-month" 2025.\n\n"
                                           "Looking forward for your follow up and feedback")))
                (send-mail-with-mac-mail-with-attachement my-mail-teeprh-invoice my-mail-cc-invoice my-title-mail my-body-mail files)))
      :desc "Send Roo invoice"
      "m r" (lambda ()
              (interactive)
              (let* ((files (dired-get-marked-files))
                     (my-title-mail (concat "Invoice - " invoice-num " NEOS Slickline Services for call out" call-out-number " " inv-name-date " "))
                     (my-body-mail (concat "Dear BECL Finance Team,\n\n"
                                           "Hope you are doing well.\n\n"
                                           "Kindly find attached the invoice " invoice-num " for NEOS Slickline Services Call out " call-out-number " " inv-name-date".\n\n"
                                           "Looking forward for your follow up and feedback")))
                (send-mail-with-mac-mail-with-attachement my-mail-roo-invoice my-mail-roo-cc-invoice my-title-mail my-body-mail files)))
      :desc "Send Final Report"
      "m f" (lambda ()
              (interactive)
              (let* ((files (dired-get-marked-files))
                     (my-title-mail (concat "NEOS Slickline " wellname " " activity-sgs " Final Report " day " " monthfull " " year))
                     (my-body-mail (concat "Hello team,\n\n"
                                           "Hope you are doing well.\n\n"
                                           "Please find the attached slickline " activity-sgs " Final Report for "
                                           wellname " on " day "-" month "-" year "\n\n"
                                           "The pdf file was uploaded to Aspera under the path (All/PRESSURE SURVEY/APPROVED/"
                                           wellname"_SGS_"year month day")")))
                (send-mail-with-mac-mail-with-attachement my-mail-to-sgs my-mail-cc my-title-mail my-body-mail files))))


(defun open-mac-mail-with-attachments ()
  "Open the macOS Mail app with marked files attached in dired
This code is used for normal usage that I want to mark a file in
dired and send it by mail which is a very nice way"
  (interactive)
  (let ((files (dired-get-marked-files))
        (script "tell application \"Mail\"
                    set newMessage to make new outgoing message with properties {visible:true}
                    tell content of newMessage
                      %s
                activate
                    end tell
                  end tell"))
    (if files
        (let ((attachment-commands
               (mapconcat (lambda (file)
                            (format "make new attachment with properties {file name:\"%s\"} at after last paragraph"
                                    (expand-file-name file)))
                          files "\n")))
          (do-applescript (format script attachment-commands)))
      (message "No files marked!"))))

;; Keybinding for `SPC m e`
(map! :leader
      :prefix "m"
      :desc "Open Mail with Attachments" "e" #'open-mac-mail-with-attachments)

(defun extract-pdf-pages (page-range output-file-name)
  "Extract a PAGE-RANGE from the marked PDF file in Dired and save it
to OUTPUT-FILE-NAME.  PAGE-RANGE can be a single number (e.g., \"3\") or
a range of numbers (e.g., \"1-3\")."
  (interactive
   (let ((marked-files (dired-get-marked-files)))
     (if (not (= (length marked-files) 1))
         (error "Please mark exactly one PDF file")
       (let ((page-range (read-string "Enter page number or range (e.g., 3 or 1-3): "))
             (output-file (read-string "Enter output file name (with .pdf): " "extracted-file.pdf")))
         (list page-range output-file)))))
  (let ((input-file (car (dired-get-marked-files))))
    (unless (and (stringp input-file)
                 (string-match-p "\\.pdf\\'" input-file))
      (error "Marked file is not a valid PDF"))
    (if (not (executable-find "pdftk"))
        (error "pdftk is not installed or not in PATH"))
    ;; Run the pdftk command
    (let ((command (format "pdftk %s cat %s output %s"
                           (shell-quote-argument input-file)
                           page-range
                           (shell-quote-argument output-file-name))))
      (if (= (shell-command command) 0)
          (message "Pages %s extracted to %s" page-range output-file-name)
        (error "Failed to extract pages %s from %s" page-range input-file)))))

;; Maling list for ROO and TEEPRH jobs
;; ===========================================
(setq my-mail-to-sgs '("ROO Wells Services Coordinator 2 <ROOWSC2@roobasra.com>"
                       "ROO Wells Services Engineer 4 <ROOWSE4@roobasra.com>"
                       "Alkarar A. Saiwan <Alkarar.Saiwan@roobasra.com>"
                       "ROO Subsurface Surveillance Deputy Team Lead <ROOSSSTL@roobasra.com>"
                       "ROO Subsurface Surveillance Pressure Survey Sector <DROOSSSPSS@roobasra.com>"
                       "Hayder H. Alhaddad <Hayder.Alhaddad@roobasra.com>"
                       "Abeer Adnan <abeer.adnan@roobasra.com>"
                       "Noor M. Ali <Noor.Ali@roobasra.com>"
                       "ROO Subsurface Lead Surveillance Engineer <ROOSSSE@roobasra.com>"))
(setq my-mail-to-daily '("ROOWSC4@roobasra.com <ROOWSC4@roobasra.com>"
                         "ROO Wells Services Coordinator 2 <ROOWSC2@roobasra.com>"
                         "ROO Wells Services Engineer 2 <ROOWSE2@roobasra.com>"
                         "ROO Wells Services Team Lead 3 <ROOWellsServicesTL3@roobasra.com>"
                         "ROO Wells Services Coordinator 3 <ROOWSC3@roobasra.com>"
                         "ROO Wells Services Engineer 4 <ROOWSE4@roobasra.com>"))
(setq my-mail-to-teeprh-daily '("ep-iq-ratawi.dw-integrity@totalenergies.com"
                                "ep-iq-ratawi.dw-comp-spdt@totalenergies.com"
                                "ep-iq-ratawi.gsr-opsgeo-team1@totalenergies.com"
                                "ep-iq-ratawi-dw-interv-lead@totalenergies.com"))
(setq my-mail-cc-teeprh '("andri@neoilfield.com<andri@neoilfield.com>"
                          "mansour@neoilfield.com"
                          "ymhussien@neoilfield.com"
                          "hazrat@neoilfield.com"
                          "rajkumar@neoilfield.com"
                          "m.fadel@neoilfield.com"))
(setq my-mail-cc '("andri@neoilfield.com<andri@neoilfield.com>"
                   "mansour@neoilfield.com"
                   "ymhussien@neoilfield.com"
                   "hazrat@neoilfield.com"
                   "rajkumar@neoilfield.com"
                   "wl_sl.admin@neoilfield.com"
                   "roo-ne.unit2@neoilfield.com"
                   "roo-ne.unit1@neoilfield.com"))
(setq my-mail-gate-pass '("Gaod M. Abdlsalam <Gaod.Abdlsalam@roobasra.com>" "Muqdad AlKanaani <Muqdad.Alkanaani@roobasra.com>"))
(setq my-mail-teeprh-invoice '("ep.ratawi-finance@mail01.totalenergies.com"))
(setq my-mail-roo-invoice '("ROOFAPINTL@roobasra.com"))
(setq my-mail-roo-cc-invoice '("ROOFAPI2@roobasra.com"
                               "andri@neoilfield.com<andri@neoilfield.com>"
                               "anas.hindi@neoilfield.com"
                               "mansour@neoilfield.com"
                               "accounts@neoilfield.com"))
(setq my-mail-cc-invoice '("ep-iq-ratawi.dw-comp-head@totalenergies.com"
                           "ep-iq-ratawi-dw-interv-lead@totalenergies.com"
                           "andri@neoilfield.com<andri@neoilfield.com>"
                           "mansour@neoilfield.com"
                           "accounts@neoilfield.com"))

;; ===========================================
