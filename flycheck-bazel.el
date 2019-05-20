;;; flycheck-bazel.el --- Support bazel in flycheck

;;; Commentary:

;; This package adds support for bazel to flycheck.  To use it, add
;; to your init.el:

;; (require 'flycheck-bazel)
;; (add-hook 'java-mode-hook 'flycheck-mode)

;;; License:

;; This file is not part of GNU Emacs.
;; However, it is distributed under the same license.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:
(require 'flycheck)

(defconst script-folder
  (file-name-directory (or load-file-name
			   (bound-and-true-p byte-compile-current-file)
			   (buffer-file-name))))
(flycheck-define-checker bazel
    "Bazel flychecker"
    :command ((eval (expand-file-name "bazel-flycheck-command" script-folder)) source-original)
    
    :error-patterns
    ((error line-start
	    (one-or-more not-newline) "/" (file-name) ":" line
	    ": error: "
	    (message (one-or-more not-newline) "\n"
		     (one-or-more not-newline) "\n"
		     (one-or-more not-newline) "\n"
		     (one-or-more not-newline) "\n"
		     (one-or-more not-newline)) line-end))
    :modes java-mode scala-mode python-mode)

(add-to-list 'flycheck-checkers 'bazel)

(provide 'flycheck-bazel)
;;; flycheck-bazel.el ends here
