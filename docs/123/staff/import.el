(defun latex-to-rst 
        () 
        "convert some included latex to restructured text"
        (let ()
	  (item-to-bullet)
	  (fix-em)
	  (fix-display-math)
	  (fix-inline-math)
	  (fix-vector-abbreviations)
	  ))

(defun item-to-bullet () "convert \\items to bullets"
  (replace-regexp "\\\\item\n?" "* "))


(defun fix-em () "convert {\em ... } to *...*"
  (replace-regexp "{\\\\em \\([^}]*\\)\\(\\\\/\\)}" "*\\1*"))


(defun fix-display-math
  ()
  "convert displayed math to the latex directive"
  (replace-regexp "\\$\\$\n?\\([^$]+\\)\n\\$\\$"
		  "\n.. latex::\n\n   \\1\n"
		  ))

(defun fix-inline-math
  ()
  "convert inline math to the latex role"
  (replace-regexp "\\([^`]\\)\\$\\([^$]\\)\\$"
		  "\\1:latex:`$\\2$`"))


(defun fix-vector-abbreviations
  ()
  "undo some of Tom's macros"
  (let ()
    (replace-regexp "\\\\bf\\([rijk]\\)" "\\\\mathbf{\\1}")
    (replace-regexp "\\\\v\\([rijkabcFS]\\)" "\\\\mathbf{\\1}")))
  

