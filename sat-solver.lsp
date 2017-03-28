;HW 4

(defun split-line (line)
  (if (equal line :eof)
      :eof
      (with-input-from-string (s line) (loop for x = (read s nil) while x collect x))))

(defun read-cnf (filename)
  (with-open-file (in filename)
    (loop for line = (split-line (read-line in nil :eof)) until (equal line :eof)
      if (equal 'p (first line)) collect (third line)      ; var count
      if (integerp (first line)) collect (butlast line)))) ; clause

(defun parse-cnf (filename)
  (let ((cnf (read-cnf filename))) (list (car cnf) (cdr cnf))))

; Following is a helper function that combines parse-cnf and sat?
(defun solve-cnf (filename)
  (let ((cnf (parse-cnf filename))) (sat? (first cnf) (second cnf))))

(defun valid_args (assignment)
	(cond   ((null assignment) nil)
	      	((< (first assignment) 0) (cons (- 0 (first assignment)) (valid_args (rest assignment))))
		(t (cons (first assignment) (valid_args (rest assignment))))))

(defun assign_vars (vars val)
	(cond   ((null vars) nil)
		((= val (first vars)) t)
		((= (+ val (first vars)) 0) nil)
		(t (assign_vars (rest vars) val))))		

(defun valid_clause (vars clause)
	(cond	((null clause) nil)
		((assign_vars vars (first clause)) t)
		(t (valid_clause vars (rest clause)))))

(defun valid_cnf (vars cnf)
	(if (null cnf) t
		(and (valid_clause vars (first cnf)) (valid_cnf vars (rest cnf)))))

(defun backtracking (assignment)
	(cond   ((null assignment) 0)
		((> (first assignment) 0) 0)
		(t (+ (backtracking (rest assignment)) 1))))

(defun try-assignment (assignment idx)
	(cond	((null assignment) nil)
		((= 1 idx) (cons (- 0 (first assignment)) (valid_args (rest assignment))))
		(t (cons (first assignment) (try-assignment (rest assignment) (- idx 1)))
)))		

(defun dfs (n cnf assignment assignment_length)
	(let* ((position (backtracking (reverse assignment))))
	(if (= assignment_length n)
		(if (valid_cnf assignment cnf) assignment
			(if (= position n) nil			
			(dfs n cnf (try-assignment assignment (- n position)) (- n position))))
	 (dfs n cnf assignment (+ 1 assignment_length))
	 )))

(defun default-assignment (n)
	(cond   ((= n 0) nil)
		(t (append (default-assignment (- n 1)) (list n)))))

(defun sat? (n delta)
	(dfs n delta (default-assignment n) 0))
