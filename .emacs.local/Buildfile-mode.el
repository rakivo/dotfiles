;;; Buildfile-mode.el --- Major Mode for editing Buildfile build recipes -*- lexical-binding: t -*-

;; Copyright (C) 2024 Mark Tyrkba <marktyrkba456@gmail.com>

;; Author: Mark Tyrkba <marktyrkba456@gmail.com>
;; URL: http://github.com/rakivo/Buildfile

;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Commentary:

;;; Buildfile-mode.el --- Major Mode for editing Buildfile build recipes -*- lexical-binding: t -*-

(defconst Buildfile-mode-syntax-table
  (with-syntax-table (copy-syntax-table)
    (modify-syntax-entry ?\; "<")
    (modify-syntax-entry ?\n ">")
    (modify-syntax-entry ?\' "\"")
    (syntax-table))
  "Syntax table for `Buildfile-mode'.")

(eval-and-compile
  (defconst Buildfile-instructions
     '("ifdef" "ifndef" "ifeq" "ifneq" "endif" "shell")))

(defconst Buildfile-highlights
  `((,(regexp-opt Buildfile-instructions 'symbols) . font-lock-keyword-face)
    ("\\<shell\\>" . font-lock-keyword-face)
    ("#[[:word:]_]+" . font-lock-preprocessor-face)
    ("@[[:word:]_]+" . font-lock-builtin-face)
    ("[[:word:]_]+:" . font-lock-constant-face)
    ("[[:word:]_]+=[^#]*" . font-lock-variable-name-face)))

;;;###autoload
(define-derived-mode Buildfile-mode prog-mode "Buildfile"
  "Major Mode for editing Buildfile build recipes"
  (setq font-lock-defaults '(Buildfile-highlights))
  (set-syntax-table Buildfile-mode-syntax-table)
  (setq-local comment-start ";")
  (setq-local comment-end ""))

;;;###autoload
(add-to-list 'auto-mode-alist '("Buildfile" . Buildfile-mode))

(provide 'Buildfile-mode)

;;; Buildfile-mode.el ends here
