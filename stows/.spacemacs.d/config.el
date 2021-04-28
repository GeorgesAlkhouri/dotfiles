(defun assoc-recursive (alist &rest keys)
  "Recursively find KEYs in ALIST"
  (while keys
    (setq alist (cdr (assoc (pop keys) alist))))
  alist)

(defun config-get (&rest keys)
  "Get config entry for KEYs"
  (car (apply 'assoc-recursive config keys))
  )

(setq config
      '(
        (darwin
         ("shell-default-shell" vterm))

        (gnu/linux
         ("shell-default-shell" ansi-term))
        ))
