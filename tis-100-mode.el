;;; tis-100-mode.el --- Syntax highlighting for TIS-100 assembly

;; Copyright (C) 2020 Robin Schroer

;; Author: Robin Schroer <sulami@peerwire.org>
;; Maintainer: Robin Schroer <sulami@peerwire.org>
;; Version: 1.0
;; Homepage: https://github.com/sulami/tis-100-mode.el
;; Keywords: languages, games

;; This file is not part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This major mode provides syntax highlighting for TIS-100 assembly.
;; It conforms to the publicly released manual and does not include
;; support for custom or classified extensions.

;; Note that `BAK' is not highlighted, as it is not useful in code.

;;; Code:

(defvar tis-100-font-lock-defaults nil "Font locks for tis-100-mode.")

(setq tis-100-font-lock-defaults
      (let* ((x-registers '("ACC" "NIL" "LEFT" "RIGHT" "UP" "DOWN" "ANY" "LAST"))
             (x-registers-regexp (regexp-opt x-registers 'words))
             (x-instructions '("NOP" "MOV" "SWP" "SAV" "ADD" "SUB" "NEG"
                               "JMP" "JEZ" "JNZ" "JGZ" "JLZ" "JRO"))
             (x-instructions-regexp (regexp-opt x-instructions 'words))
             (x-numbers-regex (rx (optional "-") (1+ digit)))
             (x-labels-regexp (rx line-start (1+ (not blank)) ":" line-end))
             (x-title-regexp (rx line-start "##" (0+ any) line-end))
             (x-comments-regexp (rx line-start "#" (0+ any) line-end)))
        `((,x-registers-regexp . font-lock-builtin-face)
          (,x-instructions-regexp . font-lock-function-name-face)
          (,x-numbers-regex . font-lock-constant-face)
          (,x-labels-regexp . font-lock-preprocessor-face)
          (,x-title-regexp . font-lock-doc-face)
          (,x-comments-regexp . font-lock-comment-face))))

;;;###autoload
(define-derived-mode tis-100-mode prog-mode "TIS-100"
  "Major mode for editing TIS-100 Assembly."
  (setq font-lock-defaults '((tis-100-font-lock-defaults))))

(provide 'tis-100-mode)
;;; tis-100-mode.el ends here
