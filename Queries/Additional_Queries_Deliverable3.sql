SELECT COUNT(title), title
FROM mentorship_eligibility
GROUP BY title
ORDER BY count;

SELECT COUNT(title), title
INTO active_titles
FROM titles
WHERE to_date = '9999-01-01'
GROUP BY title
ORDER BY title DESC;

SELECT COUNT(title), title
INTO mentorship_candidates
FROM titles
WHERE (from_date NOT BETWEEN '2000-01-01' AND '2020-12-06')
	AND to_date = '9999-01-01'
GROUP BY title
ORDER BY title DESC;

SELECT * FROM mentorship_candidates

SELECT DISTINCT ON (e.emp_no) e.emp_no, 
e.first_name,
e.last_name,
e.birth_date,
de.dept_no,
de.from_date,
de.to_date,
t.title
INTO mentorship_dept
FROM employees as e
INNER JOIN dept_employees as de
ON e.emp_no = de.emp_no
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01'
ORDER BY e.emp_no ASC, de.to_date DESC, t.to_date DESC;

SELECT COUNT(title), dept_no, title
FROM mentorship_dept
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (title = 'Senior Staff' OR title = 'Manager' OR title = 'Senior Engineer' OR title = 'Technique Leader')
GROUP BY title, dept_no
ORDER BY dept_no;