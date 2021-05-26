(defun assoc-recursive (alist &rest keys)
  "Recursively find KEYs in ALIST"
  (while keys
    (setq alist (cdr (assoc (pop keys) alist))))
  alist)

;; TODO get default value (base) if value
;; for key is nil
(defun config-get (&rest keys)
  "Get config entry for KEYs"
  (car (apply 'assoc-recursive config keys))
  )


(defun proxy-set (username password http &optional no-proxy)
  "Set proxy with credentials"
  (let ((proxy http)
        (credentials (concat username ":" password)))
    (setq url-proxy-services
          `(;; example ("no_proxy" . "^\\(localhost\\|10.*\\)")
            ("http" . ,proxy)
            ("https" . ,proxy)))

    (setq url-http-proxy-basic-auth-storage
          (list (list proxy
                      (cons username
                            (base64-encode-string credentials)))))))

(setq config
      '(
        ("base"
         ("shell-default-shell" ansi-term))
        ("linux-work-docker"
         ("shell-default-shell" ansi-term))
        ("mac"
         ("shell-default-shell" vterm))
        ))
