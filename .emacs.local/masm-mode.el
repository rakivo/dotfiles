;;; masm-mode.el --- Major Mode for editing MASM Assembly Code -*- lexical-binding: t -*-

;; Copyright (C) 2024 Mark Tyrkba <marktyrkba456@gmail.com>

;; Author: Mark Tyrkba <marktyrkba456@gmail.com>
;; URL: http://github.com/rakivo/mm

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
;;
;; Major Mode for editing MASM Assembly Code. The language for a
;; simple Virtual Machine.

;;; masm-mode.el --- Major Mode for editing MASM Assembly Code -*- lexical-binding: t -*-

(defconst masm-mode-syntax-table
  (with-syntax-table (copy-syntax-table)
    (modify-syntax-entry ?\; "<")
    (modify-syntax-entry ?\n ">")
    (modify-syntax-entry ?\" "\"")
    (modify-syntax-entry ?\' "\"")
    (modify-syntax-entry ?{ "(}")
    (modify-syntax-entry ?} "){")
    (syntax-table))
  "Syntax table for `masm-mode'.")

(eval-and-compile
  (defconst masm-instructions
     '("push" "pop" "fadd" "fdiv" "fsub" "fmul" "iadd" "idiv" "isub" "imul" "inc" "dec" "jmp" "je" "jne" "jg" "jl" "jle" "jge" "swap" "dup" "cmp" "dmp" "nop" "label" "native" "alloc" "call" "ret" "spush" "spop" "read" "halt" "fread" "eread" "pushmp" "pushsp" "dmpln" "fwrite" "write" "jmp_if" "not" "sizeof" "jz" "jnz")))

(defconst masm-highlights
  `((,(regexp-opt masm-instructions 'symbols) . font-lock-keyword-face)
    ("#[[:word:]_]+" . font-lock-preprocessor-face)
    ("@[[:word:]_]+" . font-lock-preprocessor-face)
    ("[[:word:]_]+:" . font-lock-constant-face)))

;;;###autoload
(define-derived-mode masm-mode prog-mode "masm"
  "Major Mode for editing MASM Assembly Code."
  (setq font-lock-defaults '(masm-highlights))
  (set-syntax-table masm-mode-syntax-table)
  (setq-local comment-start ";")
  (setq-local comment-end ""))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.\\(b\\|h\\)asm\\'" . masm-mode))

(provide 'masm-mode)

;;; masm-mode.el ends here
