;; back-up files to ~/.mg.d
make-backup-files
backup-to-home-directory

;; maintain indentation automatically
set-default-mode indent

;; start c-mode for C source and header files
auto-execute *.c c-mode
auto-execute *.h c-mode

;; Set case-insensitive search and case-preserving replace
set-case-fold-search
set-case-replace

;; Place a newline at end of file if none exists, without asking
require-final-newline T
