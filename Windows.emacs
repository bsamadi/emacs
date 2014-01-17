(server-start)

(load "dlgopen")
(global-set-key "\C-o" 'dlgopen-open-files)

(recentf-mode) 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aldor-interactive-echo-phrase t)
 '(aldor-toplevel-startup-code (quote ("#include \"basicmath\"")))
 '(case-fold-search t)
 '(cua-mode t nil (cua-base))
 '(current-language-environment "Latin-9")
 '(default-input-method "latin-9-prefix")
 '(global-font-lock-mode t nil (font-lock))
 '(transient-mark-mode t))
(custom-set-faces


;; Emacs Theme
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
 '(show-paren-match ((((class color)) (:foreground "black" :background "yellow"))))
 '(show-paren-mismatch ((((class color)) (:foreground "white" :background "red"))))
 '(widget-field ((((class grayscale color) (background light)) (:background "DarkBlue")))))

(setq default-frame-alist (append (list                                                      
  '(width  . 100)  ; Width set to 100 characters
  '(height . 60)) ; Height set to 60 lines
  default-frame-alist)) 

(setq initial-frame-alist '((top . 5) (left . 5)))
(set-cursor-color "green") ;to set the cursor color
(set-scroll-bar-mode 'right)

;; Maple
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
   ("17" . ("cmaple" nil "mint")))
 maplev-mint-query nil
 maplev-description-quote-char ?\"
 )

;; TeX
 '(TeX-PDF-mode t)
 '(TeX-bar-LaTeX-buttons (quote (new-file open-file dired kill-buffer save-buffer undo cut copy paste search-forward [separator nil] latex next-error view bibtex clean nil)))
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-view-program-list (quote (("Sumatra PDF" ("\"C:/Program Files (x86)/GNU Emacs 24.3/bin/SumatraPDF.exe\" -reuse-instance" (mode-io-correlate " -forward-search %b %n") " %o")))))
 '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and start") (output-dvi "Yap") (output-pdf "Sumatra PDF") (output-html "start"))))

;; AUCTeX 
(package-initialize)
(require 'tex)
'(bib-file "C:/Users/bsamadi/projects.bib")

;; Org Mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq-default TeX-master t)
(setq reftex-default-bibliography
      (quote
       ("Y:/projects.bib")))

(defun na-org-mode-reftex-setup ()
  (interactive)
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all)))

(add-hook 'org-mode-hook 'na-org-mode-reftex-setup)

(require 'org-latex)
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
(add-to-list 'org-latex-classes
               '("article"
                 "\\documentclass{article}
                 [NO-DEFAULT-PACKAGES]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
               '("report"
                 "\\documentclass{report}
                 [NO-DEFAULT-PACKAGES]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
             '("amsbook"
               "\\documentclass{amsbook}
               [NO-DEFAULT-PACKAGES]"
;               ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
             )

'(org-latex-pdf-process (quote ("pdflatex -interaction nonstopmode -output-directory %o %f" 
                                "bibtex %b" 
                                "pdflatex -interaction nonstopmode -output-directory %o %f" 
                                "pdflatex -interaction nonstopmode -output-directory %o %f")))

'(org-latex-to-pdf-process (quote ("pdflatex -interaction nonstopmode -output-directory %o %f" 
                                "bibtex %b" 
                                "pdflatex -interaction nonstopmode -output-directory %o %f" 
                                "pdflatex -interaction nonstopmode -output-directory %o %f")))

(defun org-latex-no-toc (depth)  
    (when depth
      (format "%% Org-mode is exporting headings to %s levels.\n"
              depth)))
  (setq org-latex-format-toc-function 'org-latex-no-toc)
