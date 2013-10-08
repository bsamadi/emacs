(server-start)

; Maple editing mode
(autoload 'maplev-mode "maplev" "Maple editing mode" t)
(setq 
 auto-mode-alist (cons (cons (concat "\\." (regexp-opt '("mpl" "tst" "mm" "mi" "input") t)
				     "$")
			     'maplev-mode)
		       auto-mode-alist)

 maplev-copyright-owner "Behzad Samadi" ; this is for applying copyrights to Maple code you create
 maplev-default-release "17"
 maplev-executable-alist 
 '(
   ("17" . ("/home/bsamadi/maple17/bin/maple" nil "/home/bsamadi/maple17/bin/mint")))
 maplev-mint-query nil
 maplev-description-quote-char ?\"
 )

; Frame
(setq default-frame-alist (append (list                                                      
  '(width  . 100)  ; Width set to 100 characters
  '(height . 57)) ; Height set to 57 lines
  default-frame-alist)) 

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "white" :background "DarkSlateGray"))))
 '(font-lock-comment-face ((t (:foreground "green2"))))
 '(font-lock-doc-string-face ((t (:foreground "Coral"))) t)
 '(font-lock-function-name-face ((t (:foreground "yellow"))))
 '(font-lock-keyword-face ((t (:foreground "aquamarine"))))
 '(font-lock-preprocessor-face ((t (:italic nil :foreground "CornFlowerBlue"))))
 '(font-lock-reference-face ((t (:foreground "DodgerBlue"))))
 '(font-lock-string-face ((t (:foreground "Coral"))))
 '(font-lock-type-face ((t (:foreground "#9290ff"))))
 '(font-lock-variable-name-face ((t (:foreground "orange"))))
 '(isearch ((t (:foreground "black" :background "yellow"))))
 '(list-mode-item-selected ((t (:background "gray68"))) t)
 '(paren-match ((t (:background "darkseagreen4"))) t)
 '(show-paren-match-face ((((class color)) (:foreground "black" :background "yellow"))))
 '(show-paren-mismatch-face ((((class color)) (:foreground "white" :background "red"))))
 '(widget-field-face ((((class grayscale color) (background light)) (:background "DarkBlue"))) t))

;; to set the cursor color
(set-cursor-color "green")



; AUCTeX 
(package-initialize)
(require 'tex)

; Org Mode
(find-file "/host/Behzad/notes.org")
(setq-default TeX-master t)
(setq reftex-default-bibliography
      (quote
       ("/home/Y/maple/Honda/Honda.bib")))

;; Org Model and RefTeX
(defun na-org-mode-reftex-setup ()
  (interactive)
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all)))

(progn
	 ;enable auto-revert-mode to update reftex when bibtex file changes on disk
	 (global-auto-revert-mode t)
	 (reftex-parse-all)
	 ;add a custom reftex cite format to insert links
	 (reftex-set-cite-format
	  '((?b . "[[bib:%l][%l-bib]]")
	    (?n . "[[notes:%l][%l-notes]]")
	    (?p . "[[papers:%l][%l-paper]]")
	    (?t . "%t")
	    (?h . "** %t\n:PROPERTIES:\n:Custom_ID: %l\n:END:\n[[papers:%l][%l-paper]]")))))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search))
  
(add-hook 'org-mode-hook 'na-org-mode-reftex-setup)

;; Org Model and LaTeX
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))

;;; article
(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass{article}
               [NO-DEFAULT-PACKAGES]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
             )

;;; amsbook
(add-to-list 'org-latex-classes
             '("amsbook"
               "\\documentclass{amsbook}
               [NO-DEFAULT-PACKAGES]"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
             )

 (setq org-latex-pdf-process 
   '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f" 
     "bibtex   %b" 
     "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f" 
     "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode t)
 '(inhibit-startup-screen t)
 
