;;;;(load "/home/joeo/tstart.cl")
;;;(require 'asdf)
;;;(push #p"/home/joeo/cl-ncurses_0.1.4/" asdf:*central-registry*)
;;;(push #p"/home/joeo/uffi-1.6.1/" asdf:*central-registry*)
(asdf:operate 'asdf:load-op 'uffi)
(asdf:oos 'asdf:load-op 'cl-ncurses)

	(load #p"/home/joeo/cl-ncurses_0.1.4/attr.lisp")

(in-package :cl-ncurses)

;;;(cl-ncurses:endwin)
(defun init-color-ncurses ()

  (start-color)
  (init-pair COLOR_BLACK   COLOR_BLACK   COLOR_BLACK)
  (init-pair COLOR_GREEN   COLOR_GREEN   COLOR_BLACK)
  (init-pair COLOR_RED     COLOR_RED     COLOR_BLACK)
  (init-pair COLOR_CYAN    COLOR_CYAN    COLOR_BLACK)
  (init-pair COLOR_WHITE   COLOR_WHITE   COLOR_BLACK)
  (init-pair COLOR_MAGENTA COLOR_MAGENTA COLOR_BLACK)
  (init-pair COLOR_BLUE    COLOR_BLUE    COLOR_BLACK)
  (init-pair COLOR_YELLOW  COLOR_YELLOW  COLOR_BLACK))

(defun g3 ()

    (let ((scr (initscr)))
;	  (erase)

      (let ((lastch ERR)
	    (ch     0))


	  (init-color-ncurses)
;(refresh)    
;	  (curs-set 0)


(let ((xtt 1))
	  (init-pair 1 COLOR_WHITE COLOR_BLACK)
;	  (init-pair 2 COLOR_WHITE COLOR_GREEN)
	  (init-pair 2 COLOR_RED COLOR_BLACK)
	  (init-pair 3 COLOR_RED COLOR_YELLOW)
	  (init-pair 4 COLOR_BLUE COLOR_BLACK)
	  (init-pair 5 COLOR_BLUE COLOR_YELLOW)
;	  (init-pair 3 COLOR_WHITE COLOR_RED)
;	  (init-pair 4 COLOR_WHITE COLOR_YELLOW)
;	  (init-pair 5 COLOR_BLUE COLOR_BLUE)


;(init_color 20, 

	  (bkgd (COLOR-PAIR 1))


;	  (refresh)


	  (let (
                (win1 (newwin 22 60 1 2))
		(win2 (newwin 3 25 28 2))
		(win3 (newwin 28 85 1 65))

)

	(scrollok win1 TRUE)

	(scrollok win2 TRUE)
	(scrollok win3 TRUE)


        (wsetscrreg win1 0 25)
        (wsetscrreg win2 0 5)

	
;	    (box win1 0 0)
	    (wbkgd win1 (COLOR-PAIR 1))


;	    (box win2 0 0)
	    (wbkgd win2 (COLOR-PAIR 1))

;	    (box win3 0 0)
	    (wbkgd win3 (COLOR-PAIR 2))


;	    (echo)

;	    (setf s "Welcome to Lisp-Fics-Ncurses, the finest chess interface on earth.")
	   ;(mvwaddstr win3 1 0 s)
	    (wrefresh win3)
	    (wrefresh win2)
	    (wrefresh win1)


(setf tn  (telnetlib:open-telnet-session "freechess.org" 5000))
;;use below to login automaticaly.
;   (telnetlib:read-until tn "ogin:")
 ;   (telnetlib:write-ln tn "putnamehere")
 ;   (telnetlib:read-until tn "assword:") 
  ; (telnetlib:write-ln tn "putpasswordhere") 
(setf a 0)
(setf b 1)

;;get output from fics and print it in right spot on screen. thread
(defun readinfics ()
(setf cc 0)
(setf dd 1)
(setf s (cl-ppcre:create-scanner " [0-9] " :CASE-INSENSITIVE-MODE t))
(loop until (eq cc dd) do
(setf inficsx (telnetlib:read-available-data tn t))
(wscrl win1 2)
(setf infics (substitute #\Space #\- inficsx)) 
(setf infics (substitute #\Space #\) inficsx)) 
(setf infics (substitute #\Space #\( inficsx)) 
;;if fics output is a chess board, put in in win3
(setf gs (search "<12>" infics))
(if (eq gs nil)
(progn
(mvwaddstr win1 12 2 infics)
(wrefresh win1)
)
(progn




;(mvwaddstr win1 12 2 infics)
;(wrefresh win1)

;;(attron (COLOR-PAIR 3))
;(wattron win3 WA_BOLD)
;;print b and w board
;(setf bst (search "8 |" infics))

;;;(wattron win3 (COLOR-PAIR 3))

;(wprintw win3 infics)
;;;(mvwaddstr win3 1 1 infics)
;;;(wattron win3 (COLOR-PAIR 2))
;;;(mvwaddstr win3 2 2 "xxxxxx")
;(setf board (str-tokenize infics))
(setf infics (substitute #\Space #\- infics)) 
(setf astp (position #\< infics))

(setf bstrx (subseq infics astp))
;(setf bstr (subseq inficds 4))
;(setf bstr (subseq infics bstr))
(setf bstr (subseq bstrx 4))

;extract clocks
(setf ns (cl-ppcre:scan s bstr))
(setf nst (str-tokenize (subseq bstr ns (- (length bstr) 24))))
;(setf nst (str-tokenize (subseq bstr ns (- (length bstr) 19))))
(setf clock1 (nth 13 nst))
(setf clock2 (nth 14 nst))
(setf player1 (nth 6 nst))
(setf player2 (nth 7 nst))
(setf time1 (nth 9 nst))
(setf time2 (nth 10 nst))

(loop
for i from 1 to 8 do
(progn
(if (evenp i) (wattron win3 (COLOR-PAIR 2)))
(if (oddp i) (wattron win3 (COLOR-PAIR 3)))

(if (and (oddp i) (lower-case-p (aref bstr i))) (wattron win3 (COLOR-PAIR 3)))
(if (and (oddp i) (upper-case-p (aref bstr i))) (wattron win3 (COLOR-PAIR 5)))


(if (and (evenp i) (lower-case-p (aref bstr i))) (wattron win3 (COLOR-PAIR 2)))
(if (and (evenp i) (upper-case-p (aref bstr i))) (wattron win3 (COLOR-PAIR 4)))





(mvwaddstr win3 1 (* i 3) (concatenate 'string " " (string (aref bstr i )) " "))
;(wprintw win3 (concatenate 'string " " (string (aref bstr i)) " "))
;(wprintw win3 1 1 "xxx")
;(wprintw win3 1 5 "xxx")
;(wprintw win3 1 10 "xxx")
)
)


(loop
for i from 1 to 8 do
(progn
(if (evenp i) (wattron win3 (COLOR-PAIR 3)))
(if (oddp i) (wattron win3 (COLOR-PAIR 2)))


(if (and (oddp i) (lower-case-p (aref bstr (+ i 9)))) (wattron win3 (COLOR-PAIR 2)))
(if (and (oddp i) (upper-case-p (aref bstr (+ i 9)))) (wattron win3 (COLOR-PAIR 4)))

(if (and (evenp i) (lower-case-p (aref bstr (+ i 9)))) (wattron win3 (COLOR-PAIR 3)))
(if (and (evenp i) (upper-case-p (aref bstr (+ i 9)))) (wattron win3 (COLOR-PAIR 5)))




;(mvwaddstr win3 2 ia " ")
;(wprintw win3 (concatenate 'string " " (string (aref bstr i)) " "))
;(mvwaddstr win3 2 i (concatenate 'string " " (string (aref bstr i)) " "))
(mvwaddstr win3 2 (* i 3) (concatenate 'string " " (string (aref bstr (+ i 9) )) " "))
;(wprintw win3 1 1 "xxx")
;(wprintw win3 1 5 "xxx")
;(wprintw win3 1 10 "xxx")
)
)



(loop
for i from 1 to 8 do
(progn
(if (oddp i) (wattron win3 (COLOR-PAIR 3)))
(if (evenp i) (wattron win3 (COLOR-PAIR 2)))


(if (and (oddp i) (lower-case-p (aref bstr (+ i 18)))) (wattron win3 (COLOR-PAIR 3)))
(if (and (oddp i) (upper-case-p (aref bstr (+ i 18)))) (wattron win3 (COLOR-PAIR 5)))


(if (and (evenp i) (lower-case-p (aref bstr (+ i 18)))) (wattron win3 (COLOR-PAIR 2)))
(if (and (evenp i) (upper-case-p (aref bstr (+ i 18)))) (wattron win3 (COLOR-PAIR 4)))


;(mvwaddstr win3 2 ia " ")
;(wprintw win3 (concatenate 'string " " (string (aref bstr i)) " "))
;(mvwaddstr win3 2 i (concatenate 'string " " (string (aref bstr i)) " "))
(mvwaddstr win3 3 (* i 3) (concatenate 'string " " (string (aref bstr (+ i 18) )) " "))
;(wprintw win3 1 1 "xxx")
;(wprintw win3 1 5 "xxx")
;(wprintw win3 1 10 "xxx")
)
)




(loop
for i from 1 to 8 do
(progn
(if (evenp i) (wattron win3 (COLOR-PAIR 3)))
(if (oddp i) (wattron win3 (COLOR-PAIR 2)))


(if (and (oddp i) (lower-case-p (aref bstr (+ i 27)))) (wattron win3 (COLOR-PAIR 2)))
(if (and (oddp i) (upper-case-p (aref bstr (+ i 27)))) (wattron win3 (COLOR-PAIR 4)))


(if (and (evenp i) (lower-case-p (aref bstr (+ i 27)))) (wattron win3 (COLOR-PAIR 3)))
(if (and (evenp i) (upper-case-p (aref bstr (+ i 27)))) (wattron win3 (COLOR-PAIR 5)))

;(mvwaddstr win3 2 ia " ")
;(wprintw win3 (concatenate 'string " " (string (aref bstr i)) " "))
;(mvwaddstr win3 2 i (concatenate 'string " " (string (aref bstr i)) " "))
(mvwaddstr win3 4 (* i 3) (concatenate 'string " " (string (aref bstr (+ i 27) )) " "))
;(wprintw win3 1 1 "xxx")
;(wprintw win3 1 5 "xxx")
;(wprintw win3 1 10 "xxx")
)
)



(loop
for i from 1 to 8 do
(progn
(if (oddp i) (wattron win3 (COLOR-PAIR 3)))
(if (evenp i) (wattron win3 (COLOR-PAIR 2)))




(if (and (oddp i) (lower-case-p (aref bstr (+ i 36)))) (wattron win3 (COLOR-PAIR 3)))
(if (and (oddp i) (upper-case-p (aref bstr (+ i 36)))) (wattron win3 (COLOR-PAIR 5)))


(if (and (evenp i) (lower-case-p (aref bstr (+ i 36)))) (wattron win3 (COLOR-PAIR 2)))
(if (and (evenp i) (upper-case-p (aref bstr (+ i 36)))) (wattron win3 (COLOR-PAIR 4)))

;(mvwaddstr win3 2 ia " ")
;(wprintw win3 (concatenate 'string " " (string (aref bstr i)) " "))
;(mvwaddstr win3 2 i (concatenate 'string " " (string (aref bstr i)) " "))
(mvwaddstr win3 5 (* i 3) (concatenate 'string " " (string (aref bstr (+ i 36) )) " "))
;(wprintw win3 1 1 "xxx")
;(wprintw win3 1 5 "xxx")
;(wprintw win3 1 10 "xxx")
)
)





(loop
for i from 1 to 8 do
(progn
(if (evenp i) (wattron win3 (COLOR-PAIR 3)))
(if (oddp i) (wattron win3 (COLOR-PAIR 2)))




(if (and (oddp i) (lower-case-p (aref bstr (+ i 45)))) (wattron win3 (COLOR-PAIR 2)))
(if (and (oddp i) (upper-case-p (aref bstr (+ i 45)))) (wattron win3 (COLOR-PAIR 4)))


(if (and (evenp i) (lower-case-p (aref bstr (+ i 45)))) (wattron win3 (COLOR-PAIR 3)))
(if (and (evenp i) (upper-case-p (aref bstr (+ i 45)))) (wattron win3 (COLOR-PAIR 5)))


;(mvwaddstr win3 2 ia " ")
;(wprintw win3 (concatenate 'string " " (string (aref bstr i)) " "))
;(mvwaddstr win3 2 i (concatenate 'string " " (string (aref bstr i)) " "))
(mvwaddstr win3 6 (* i 3) (concatenate 'string " " (string (aref bstr (+ i 45) )) " "))
;(wprintw win3 1 1 "xxx")
;(wprintw win3 1 5 "xxx")
;(wprintw win3 1 10 "xxx")
)
)




(loop
for i from 1 to 8 do
(progn
(if (evenp i) (wattron win3 (COLOR-PAIR 2)))
(if (oddp i) (wattron win3 (COLOR-PAIR 3)))

;(if (oddp i) (wattron win3 (COLOR-PAIR 4)))
;(if (evenp i) (wattron win3 (COLOR-PAIR 5)))


(if (and (oddp i) (lower-case-p (aref bstr (+ i 54)))) (wattron win3 (COLOR-PAIR 2)))
(if (and (oddp i) (upper-case-p (aref bstr (+ i 54)))) (wattron win3 (COLOR-PAIR 5)))


(if (and (evenp i) (lower-case-p (aref bstr (+ i 54)))) (wattron win3 (COLOR-PAIR 3)))
(if (and (evenp i) (upper-case-p (aref bstr (+ i 54)))) (wattron win3 (COLOR-PAIR 4)))



;(mvwaddstr win3 2 ia " ")
;(wprintw win3 (concatenate 'string " " (string (aref bstr i)) " "))
;(mvwaddstr win3 2 i (concatenate 'string " " (string (aref bstr i)) " "))
(mvwaddstr win3 7 (* i 3) (concatenate 'string " " (string (aref bstr (+ i 54) )) " "))
;(wprintw win3 1 1 "xxx")
;(wprintw win3 1 5 "xxx")
;(wprintw win3 1 10 "xxx")
)
)




(loop
for i from 1 to 8 do
(progn
;(if (evenp i) (wattron win3 (COLOR-PAIR 3)))
;(if (oddp i) (wattron win3 (COLOR-PAIR 2)))

(if (evenp i) (wattron win3 (COLOR-PAIR 5)))
(if (oddp i) (wattron win3 (COLOR-PAIR 4)))


(if (and (oddp i) (lower-case-p (aref bstr (+ i 63)))) (wattron win3 (COLOR-PAIR 3)))
(if (and (oddp i) (upper-case-p (aref bstr (+ i 63)))) (wattron win3 (COLOR-PAIR 4)))


(if (and (evenp i) (lower-case-p (aref bstr (+ i 63)))) (wattron win3 (COLOR-PAIR 2)))
(if (and (evenp i) (upper-case-p (aref bstr (+ i 63)))) (wattron win3 (COLOR-PAIR 5)))


;(mvwaddstr win3 2 ia " ")
;(wprintw win3 (concatenate 'string " " (string (aref bstr i)) " "))
;(mvwaddstr win3 2 i (concatenate 'string " " (string (aref bstr i)) " "))
(mvwaddstr win3 8 (* i 3) (concatenate 'string " " (string (aref bstr (+ i 63) )) " "))
;(wprintw win3 1 1 "xxx")
;(wprintw win3 1 5 "xxx")
;(wprintw win3 1 10 "xxx")
)
)


;(mvwaddstr win3 12 1 clock1)
;(mvwaddstr win3 13 1 clock2)
(mvwaddstr win3 14 1 (concatenate 'string clock1 " " player1))
(mvwaddstr win3 15 1 (concatenate 'string clock2 " " player2))
(mvwaddstr win3 16 1 (concatenate 'string  time1 " " time2))
;(mvwaddstr win3 15 1 player2)
;(mvwaddstr win3 16 1 time1)
;(mvwaddstr win3 17 1 time2)

(wrefresh win3))
)



;(wrefresh win1)

;;end program command-probably obsolete at this spot
(setf gs2 (search "exitln" infics))
(if (eq gs2 nil)
(setf bbb 0)
(progn
(setf a 0)
(setf b 0)
(setf cc 0)
(setf dd 0)

(cl-ncurses:endwin)
)
)
)
)


(setf ftt (sb-thread:make-thread 'readinfics :name "ficsreadthread"))
(setf a 0)
(setf b 1)
(setf uinstr "xxxxxxxxxxxxx")
;(mvwaddstr win2 3 1 "test")
;(wrefresh win2)

(loop until (eq  a b) do
;(setf uinstr (read-line))
;(setf uinstrx (mvwgetstr win2 1 2 uinstr))
(waddstr win2 " ")
(wrefresh win2)
(setf uinstrb " ")
;(setf uinstrx (wgetstr win2 uinstrb))
;(setf uinstrx (wscanw win2 uinstr))
;(setf uinstrx (getstr uinstr))
;(mvwaddstr win2 3 1 (string uinstr))
(setf yy "")    
 (do ((ch (wgetch win2) (wgetch win2)))
	((eq ch 10))
(setf yy (concatenate 'string yy (string (code-char ch)))))
(setf uinstr yy)

(setf exs (search "exitln" uinstr))

(if (eq exs nil)
(setf bbb 0)
(progn
(sb-thread:terminate-thread (first (sb-thread:list-all-threads)))
(cl-ncurses:endwin)
(setf a 0)
(setf b 0)
(setf cc 0)
(setf dd 0)

))


;(waddstr win2 uinstr)
;(wprintw win2 (string uinstr))
;(mvwaddstr win2 2 2 (write-to-string uinstrx))
;;;(mvwaddstr win2 2 2 uinstr)

(wrefresh win2)
   (telnetlib:write-ln tn uinstr) 
)



	
	    )        
       
	  )
	)
)

)


(g3)
;(readinfics)
(cl-ncurses:endwin)


(defun tokens (str test start)
  (let ((p1 (position-if test str :start start)))
    (if p1
        (let ((p2 (position-if #'(lambda (c)
                                   (not (funcall test c)))
                               str :start p1)))
          (cons (subseq str p1 p2)
                (if p2
                    (tokens str test p2)
                  nil)))
      nil)))

(defun str-exclude (x)

  (or (eq #\SPACE x)
      (eq #\" x)
      (eq #\, x)))

(defun str-tokenize (string)

(let ((nospc (lambda (x) (not (str-exclude x)))))
  (tokens string nospc 0)))