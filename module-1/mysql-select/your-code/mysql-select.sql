--Challenge 1 - Who Have Published What At Where?
SELECT 
au.au_id AS "AUTHOR ID",
au.au_lname AS "LAST NAME",
au.au_fname AS "FIRST NAME",
ttl.title AS "TITLE",
p.pub_name AS "PUBLISHER"
FROM 
authors AS au
INNER JOIN titleauthor AS ta ON au.au_id = ta.au_id 
INNER JOIN titles AS ttl ON ttl.title_id = ta.title_id 
INNER JOIN publishers AS p ON p.pub_id = ttl.pub_id
ORDER BY 2 DESC;  

--Challenge 2 - Who Have Published How Many At Where?
SELECT 
au.au_id AS "AUTHOR ID",
au.au_lname AS "LAST NAME",
au.au_fname AS "FIRST NAME",
p.pub_name AS "PUBLISHER",
COUNT(ttl.title) AS "TITLE COUNT"
FROM 
authors AS au
INNER JOIN titleauthor AS ta ON au.au_id = ta.au_id 
INNER JOIN titles AS ttl ON ttl.title_id = ta.title_id 
INNER JOIN publishers AS p ON p.pub_id = ttl.pub_id 
GROUP BY au.au_id, au.au_lname, au.au_fname, p.pub_name
ORDER BY 5 DESC, 2, 3, 4;  

--Challenge 3 - Best Selling Authors
SELECT 
au.au_id AS "AUTHOR ID",
au.au_lname AS "LAST NAME",
au.au_fname AS "FIRST NAME",
SUM(sl.qty) AS "TOTAL"
FROM 
authors AS au
INNER JOIN titleauthor AS ta ON au.au_id = ta.au_id 
INNER JOIN sales AS sl ON ta.title_id = sl.title_id  
GROUP BY au.au_id
ORDER BY 4 DESC 
LIMIT 3;

--Challenge 4 - Best Selling Authors Ranking
SELECT 
au.au_id AS "AUTHOR ID",
au.au_lname AS "LAST NAME",
au.au_fname AS "FIRST NAME",
IFNULL(SUM(sl.qty), 0) AS "TOTAL"
FROM 
authors AS au
LEFT JOIN titleauthor AS ta ON au.au_id = ta.au_id 
LEFT JOIN sales AS sl ON ta.title_id = sl.title_id  
GROUP BY au.au_id
ORDER BY 4 DESC, 2, 3;