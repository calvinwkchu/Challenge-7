-- Create retirement_titles table

SELECT e.emp_no,
e.first_name,
e.last_name,
t.title,
t.from_date,
t.to_date
INTO retirement_titles
from employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows, create new unique table
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY emp_no ASC, rt.to_date DESC;

-- Create summary count table of retiring titles
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

-- Create mentorship table
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_employees as de
ON e.emp_no = de.emp_no
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND de.to_date = '9999-01-01'
ORDER BY e.emp_no ASC, de.to_date DESC, t.to_date DESC;

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



