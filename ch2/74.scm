;;; EXERCISE 2.74

;;; a. get-record: We need to have type information on the type of
;;; personelle file we're handed and the type of record we get back

(define (get-record name personelle-file)
  (let ((proc-to-retrieve-record-from-particular-personelle-file
	 (get 'personelle-file-table (type personelle-file))))
    (if (null? proc-to-re)
	(error "We don't know how to handle this personelle file")
	(proc-to-retrieve-record-from-particular-personelle-file name
								 (contents
								  personelle-file)))))

;;; b.
;;; 
;;; The record should be structured as to have a type. We also need a
;;; two-dimensional table where the Y axis contains the types of
;;; records and the X axis contains the types of procedures the can be
;;; called on a record (e.g. `get-salary', `get-birthday')
(define (get-salary record)
  (let ((salary-proc (get 'get-salary (type record))))
    (if (null? salary-proc)
	(error "We don't know how to get the salary from this kind of record")
	(salary-proc record))))

;;; c.
;;;
;;; This procedure operates in the following way: If there are no
;;; files left to be checked, then the name is not found. Else, check
;;; to see if the record is name is in the first record with
;;; `get-record'. If it's in there, just return the record. If it's
;;; not, then check and see if the name is in the rest of the files.
;;;
;;; Yes, I know that `get-record' as implemented above does not return
;;; #f when the name is not found in the record. That George's problem ;)
(define (find-employee-record name files)
  (if (null? files)
      (message "The employee name was not found")
      (let ((record (get-record name (car files))))
	(if (eq (record #f))
	    (find-employee-record name (cdr files))
	    record))))

;;; d. Insatiable must tell all of the disparate divisions to tag
;;; their record and file constructors with type information and
;;; insert their selector procedures in their row of the master tables
;;; that hold selector functions for records and files
