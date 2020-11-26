;;; org.el --- description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2020 John Doe
;;
;; Author: John Doe <http://github/dizzy>
;; Maintainer: John Doe <john@doe.com>
;; Created: 11月 24, 2020
;; Modified: 11月 24, 2020
;; Version: 0.0.1
;; Keywords:
;; Homepage: https://github.com/dizzy/org
;; Package-Requires: ((emacs 26.3) (cl-lib "0.5"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  description
;;
;;; Code:
     :PROPERTIES:
     :ID: o2b:fd64194e-4b0c-4b34-a15a-2d2ee5fe2aec
     :END:

(setq org-refile-targets '((nil :maxlevel . 3)
                           (org-agenda-files :maxlevel . 3))
      org-outline-path-complete-in-steps nil
      org-refile-use-outline-path t
      org-columns-default-format
      "%TODO %4Effort %1PRIORITY %50ITEM %14DEADLINE %TAGS"
      org-log-done 'time
      org-agenda-files '("~/Dropbox/organizer/agenda")
      org-expiry-inactive-timestamps t
      org-clock-idle-time nil
      org-log-done 'time
      org-clock-auto-clock-resolution nil
      org-clock-continuously nil
      org-clock-persist t
      org-clock-clocked-in-display 'mode-line
      org-clock-in-switch-to-state "STARTED"
      org-clock-in-resume nil
      org-show-notification-handler 'message
      org-clock-report-include-clocking-task t
      org-log-into-drawer "LOGBOOK"
      org-clock-into-drawer 1
      spaceline-org-clock-p t)
(org-clock-persistence-insinuate)

(add-to-list 'org-modules 'org-habit)
(require 'org-habit)
(require 'org-pomodoro)
(setq +org-habit-graph-padding 13
      +org-habit-graph-window-ratio 0.22
      +org-habit-min-width 20)

(setq org-agenda-block-separator ""
      org-agenda-window-setup (quote current-window)
      org-agenda-span 3
      org-agenda-start-with-clockreport-mode nil
      org-agenda-start-day "+0d"
      org-agenda-sticky nil
      org-agenda-inhibit-startup t
      org-agenda-use-tag-inheritance t
      org-agenda-show-log t
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled
      org-agenda-time-grid
      '((daily today require-timed remove-match)
        (800 1000 1200 1400 1600 1800 2000)
        "...... " "                       ")
      org-agenda-current-time-string "now = = = = = = = = = = = = = = = = ="
      )

(add-hook 'org-finalize-agenda-hook 'place-agenda-tags)
(defun place-agenda-tags ()
  "Put the agenda tags by the right border of the agenda window."
  (setq org-agenda-tags-column (- 4 (window-width)))
  (org-agenda-align-tags))

(defun my/org-agenda-done (&optional arg)
  "Mark current TODO as done.
This changes the line at point, all other lines in the agenda referring to
the same tree node, and the hepadline of the tree node in the Org-mode file."
  (interactive "P")
  (org-agenda-todo "DONE"))

(defun my/org-agenda-mark-done-and-add-followup ()
  "Mark the current TODO as done and add another task after it.
Creates it at the same level as the previous task, so it's better to use
this with to-do items than with projects or headings."
  (interactive)
  (org-agenda-todo "DONE")
  (org-agenda-switch-to)
  (org-capture 0 "t"))

(defun my/org-agenda-new ()
  "Create a new note or task at the current agenda item.
Creates it at the same level as the previous task, so it's better to use
this with to-do items than with projects or headings."
  (interactive)
  (org-agenda-switch-to)
  (org-capture 0))

(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map "x" 'my/org-agenda-done)
  (define-key org-agenda-mode-map "X" 'my/org-agenda-mark-done-and-add-followup)
  (define-key org-agenda-mode-map "N" 'my/org-agenda-new)
  )

(setq org-todo-keywords
      '((sequence "TODO(t)" "TOBLOG(b)" "STARTED(s)" "WAITING(w@/!)" "SOMEDAY(.)" "|" "DONE(x!)" "CANCELLED(c)")
        (sequence "LEARN(1)" "TRY(2)" "TEACH(3)" "|" "COMPLETE(x)")
        (sequence "TOANSWER" "ASKED" "|" "ANSWERED(x@/!)")
        (sequence "TOBUY" "|" "DONE(x)")
        (sequence "TODELEGATE(-)" "DELEGATED(d)" "|" "COMPLETE(x)")))

;; (setq org-todo-keyword-faces
;;       '(("WAITING" . (:foreground "red" :weight bold))
;;         ("SOMEDAY" . (:foreground "gray" :weight bold))))

(setq org-agenda-custom-commands
      '(("r" "Research agenda"
        (
         ;; One block for standard agenda view
         (agenda "")
         (todo "")
         ))))

(defvar my/org-inbox-file "~/Dropbox/organizer/agenda/organizer.org")
(defvar my/org-people-file "~/Dropbox/organizer/agenda/people.org")
(defvar my/org-research-file "~/Dropbox/organizer/agenda/research.org")
(defvar my/org-routine-file "~/Dropbox/organizer/agenda/routines.org")
(defvar my/org-journal-file "~/Dropbox/organizer/journal.org")
(defvar my/org-basic-task-template "* TODO %^{Task}
:PROPERTIES:
:Effort: %^{effort|1:00|0:05|0:15|0:30|2:00|4:00h}
:END:
Captured %<%Y-%m-%d %H:%M>
%?

%i
" "Basic task data")
(setq org-capture-templates
      `(
        ("t" "Quick task" entry
         (file+headline, my/org-inbox-file "Tasks")
         "* TODO %^{Task}\n"
         :immediate-finish t)

        ("T" "Task" entry
         (file+headline, my/org-inbox-file "Tasks")
         "* TODO %^{Task}\n")

        ("." "Today" entry
         (file+headline, my/org-inbox-file "Tasks")
         "* TODO %^{Task}\nSCHEDULED: %t\n"
         :immediate-finish t)

        ("i" "Interrupting task" entry
         (file+headline ,my/org-inbox-file "Tasks")
         "* STARTED %^{Task}"
         :clock-in :clock-resume)

        ("p" "People task" entry
         (file+headline ,my/org-people-file "Tasks")
         ,my/org-basic-task-template)

        ("e" "Task from email" entry (file+headline ,my/org-inbox-file "Tasks")
         "* TODO %^{Task} \n From: %a \n"
         :immediate-finish t)

        ("j" "Journal entry" plain
         (file+datetree ,my/org-journal-file)
         "%K - %a\n%i\n%?\n"
         :unnarrowed t)

        ("J" "Journal entry with date" plain
         "%K - %a\n%i\n%?\n"
         :unnarrowed t)

        ("n" "Note" entry
         (file+headline ,my/org-inbox-file "Notes")
         "* %^{Note}\n"
         :immediate-finish t)

        ("q" "Quick note" item
         (file+headline ,my/org-inbox-file "Quick notes"))

        ("\"" "Quote" item
         (file+headline ,my/org-inbox-file "Quotes")
         "/%^{Quote}/ by *%^{By}*"
         :immediate-finish t)

        ("z" "Improvement tips" item
         (file+headline ,my/org-inbox-file "Improvement")
         "%^{What tips}"
         :immediate-finish t)

        ("c" "Clipboard" entry
         (file+headline ,my/org-inbox-file "Inbox")
         "* %^{What is this} \n %x"
         :immediate-finish t)

        ("R" "Read list" entry
         (file+headline ,my/org-inbox-file "Read list")
         "* %^{What is this} \n %x"
         :immediate-finish t)

        ("?" "Research question" entry
         (file+headline ,my/org-research-file "Questions")
         "* TOANSWER %^{Question}"
         :immediate-finish t)

        ("P" "Protocol" entry (file+headline ,my/org-inbox-file "Inbox")
         "* [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n#+BEGIN_QUOTE\n%i\n#+END_QUOTE\n"
         :immediate-finish t)

        ("L" "Protocol Link" entry (file+headline ,my/org-inbox-file "Inbox")
         "* [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]"
         :immediate-finish t)
        ))

(setq org-use-speed-commands t)
(with-eval-after-load 'org
  (add-to-list 'org-speed-commands-user '("x" org-todo "DONE"))
  (add-to-list 'org-speed-commands-user '("c" org-todo "CANCELLED"))
  (add-to-list 'org-speed-commands-user '("y" org-todo-yesterday "DONE"))
  (add-to-list 'org-speed-commands-user '("S" call-interactively 'org-schedule))
  (add-to-list 'org-speed-commands-user '("I" call-interactively 'org-clock-in))
  (add-to-list 'org-speed-commands-user '("O" call-interactively 'org-clock-out))
  (add-to-list 'org-speed-commands-user '("$" call-interactively 'org-archive-subtree)))

(setq org-superstar-headline-bullets-list '("=" "o" ">")
      org-ellipsis "..")

(setq org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+"))
      org-cycle-separator-lines 0)
(setq org-pretty-entities t
      org-startup-indented t
      org-hide-emphasis-markers t
      org-fontify-whole-heading-line t
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t
      org-tags-column 0)

(with-eval-after-load 'org-gcal
  (setq org-gcal-client-id "546005187226-902u5lv52fju17f6reulrqrjslrrj16f.apps.googleusercontent.com"
        org-gcal-client-secret "QkfvqOHv9fMpZvQfEyJiJ2ox"
        org-gcal-file-alist '(
                              ("thientquang@gmail.com" .  "~/Dropbox/organizer/agenda/s-gmail.org")
                              ("mdl.cs.tsukuba.ac.jp_i7hu9mdot5u2trmuorrhaf3p4g@group.calendar.google.com" . "~/Dropbox/organizer/agenda/s-mdl.org")
                              )
        ))

(require 'org2blog)
(setq org2blog/wp-blog-alist
      '(("myblog"
         :url "https://dizzytran.com/blog/xmlrpc.php"
         :username "thientquang")))
(add-to-list 'org-structure-template-alist '
             ("h" "+BEGIN_EXPORT html\n\n#+END_EXPORT"))

(provide 'org)
;;; org.el ends here
