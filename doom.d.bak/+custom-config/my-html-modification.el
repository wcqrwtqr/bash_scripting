;;; +custom-config/my-html-modification.el -*- lexical-binding: t; -*-

(defun renumber-html-table-rows ()
  "Renumber <th scope=\"row\"> elements sequentially in an HTML table."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((counter 1))
      (while (re-search-forward "<th scope=\"row\">\\([0-9]+\\)</th>" nil t)
        (replace-match (format "<th scope=\"row\">%d</th>" counter))
        (setq counter (1+ counter))))))


(defun update-nav-tags-in-html-files_modifed ()
  "Update <nav> tags in all HTML files in the current directory based on the
<nav> tag from index.html."
  (interactive)
  ;; Load the updated <nav> content from index.html
  (let ((nav-content nil))
    (with-temp-buffer
      (insert-file-contents "index.html")
      (goto-char (point-min))
      (when (re-search-forward "<nav\\(.\\|\n\\)*?</nav>" nil t)
        (setq nav-content (match-string 0))))
    ;; Check if <nav> content was found
    (if (not nav-content)
        (message "No <nav> tag found in index.html")
      (progn
        (message "Nav tag found, updating HTML files in the current directory...")
        ;; Process each HTML file in the current directory only
        (dolist (file (directory-files "." t "\\.html$"))
          (when (not (file-directory-p file)) ;; Ensure it's not a directory
            (with-temp-buffer
              (insert-file-contents file)
              (goto-char (point-min))
              ;; Replace the existing <nav> tag with the updated one
              (if (re-search-forward "<nav\\(.\\|\n\\)*?</nav>" nil t)
                  (progn
                    (replace-match nav-content)
                    (write-region (point-min) (point-max) file)
                    (message "Updated <nav> in %s" file))
                (message "No <nav> tag found in %s" file)))))
        (message "All <nav> tags updated successfully.")))))


(defun update-all-tbody-in-html-files ()
  "Update <tbody> tags in multiple target HTML files based on corresponding
source HTML files."
  (interactive)
  ;; Define pairs of source and target files
  (let ((file-pairs '(("~/Desktop/html_generator/html_sls/output_sls.html" . "/Volumes/WL-SL/Webpage/sls.html")
                      ("~/Desktop/html_generator/html_trucks/output_trucks_maintenace.html" . "/Volumes/WL-SL/Webpage/maintenance/trucks_maintenance.html")
                      ("~/Desktop/html_generator/html_oem/output_oem.html" . "/Volumes/WL-SL/Webpage/equipment/sls_OEM.html")
                      ("~/Desktop/html_generator/html_sls_ims/output_ims_sls.html" . "/Volumes/WL-SL/Webpage/IMS.html")
                      ("~/Desktop/html_generator/roo_sqb/output_roo_sqb.html" . "/Volumes/WL-SL/Webpage/ROO-SQB.html")
                      ("~/Desktop/html_generator/html_roo_final_report/output_roo_final_report.html" . "/Volumes/WL-SL/Webpage/ROO-Final_Report.html")
                      )))
    ;; Loop through each pair
    (dolist (pair file-pairs)
      (let ((source-file (car pair))
            (target-file (cdr pair))
            (tbody-content nil))
        ;; Load the updated <tbody> content from the source file
        (with-temp-buffer
          (insert-file-contents source-file)
          (goto-char (point-min))
          (when (re-search-forward "<tbody\\(.\\|\n\\)*?</tbody>" nil t)
            (setq tbody-content (match-string 0))))
        ;; Check if <tbody> content was found
        (if (not tbody-content)
            (message "No <tbody> tag found in %s" source-file)
          (progn
            (message "Tbody tag found in %s, updating %s..." source-file target-file)
            ;; Update the target file with the <tbody> content
            (with-temp-buffer
              (insert-file-contents target-file)
              (goto-char (point-min))
              ;; Replace the existing <tbody> tag with the updated one
              (if (re-search-forward "<tbody\\(.\\|\n\\)*?</tbody>" nil t)
                  (progn
                    (replace-match tbody-content)
                    (write-region (point-min) (point-max) target-file)
                    (message "Updated <tbody> in %s" target-file))
                (message "No <tbody> tag found in %s" target-file)))))))))



