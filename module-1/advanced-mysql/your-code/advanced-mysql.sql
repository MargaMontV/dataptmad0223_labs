-- Challenge 1 - Most Profiting Authors
-- 1. Calculate the royalty of each sale for each author and the advance for each author and publication.
SELECT 
ttl.title_id AS "TITLE_ID",
ta.au_id AS "AUTHOR_ID",
(ttl.price * sl.qty * ttl.royalty / 100 * ta.royaltyper / 100) AS "SALES_ROYALTY"
FROM
titles AS ttl
JOIN titleauthor AS ta ON ttl.title_id = ta.title_id
JOIN sales AS sl ON sl.title_id = ttl.title_id;

-- 2. Using the output from Step 1 as a subquery, aggregate the total royalties for each title and author.
WITH 
a AS
(
SELECT 
ttl.title_id AS "TITLE_ID",
ta.au_id AS "AUTHOR_ID",
(ttl.price * sl.qty * ttl.royalty / 100 * ta.royaltyper / 100) AS "SALES_ROYALTY"
FROM
titles AS ttl
JOIN titleauthor AS ta ON ttl.title_id = ta.title_id
JOIN sales AS sl ON sl.title_id = ttl.title_id
)
SELECT 
a.TITLE_ID,
a.AUTHOR_ID,
SUM(a.SALES_ROYALTY) AS "SALES_ROYALTY_TOTAL"
FROM
a
GROUP BY
a.AUTHOR_ID,
a.TITLE_ID;

-- 3. Using the output from Step 2 as a subquery, calculate the total profits of each author 
-- by aggregating the advances and total royalties of each title.
WITH
b AS 
(
WITH
a AS
(
SELECT 
ttl.title_id AS "TITLE_ID",
ta.au_id AS "AUTHOR_ID",
(ttl.price * sl.qty * ttl.royalty / 100 * ta.royaltyper / 100) AS "SALES_ROYALTY"
FROM
titles AS ttl
JOIN titleauthor AS ta ON ttl.title_id = ta.title_id
JOIN sales AS sl ON sl.title_id = ttl.title_id
)
SELECT 
a.TITLE_ID,
a.AUTHOR_ID,
SUM(a.SALES_ROYALTY) AS "SALES_ROYALTY_SUM"
FROM
a
GROUP BY
a.AUTHOR_ID,
a.TITLE_ID
)
SELECT
b.AUTHOR_ID,
SUM(b.SALES_ROYALTY_SUM + ttl.advance * ta.royaltyper / 100) AS "TOTAL_ROYALTIES"
FROM
b
JOIN titles AS ttl ON ttl.title_id = b.TITLE_ID
JOIN titleauthor AS ta ON ta.title_id = b.TITLE_ID
GROUP BY
b.AUTHOR_ID
ORDER BY
TOTAL_ROYALTIES DESC
LIMIT 3;

-- Challenge 2 - Alternative Solution
CREATE TEMPORARY TABLE tta AS
SELECT 
ttl.title_id AS 'TITLE_ID',
ta.au_id AS 'AUTHOR_ID',
(ttl.price * sl.qty * ttl.royalty / 100 * ta.royaltyper / 100) AS 'SALES_ROYALTY'
FROM
titles AS ttl
JOIN titleauthor AS ta ON ttl.title_id = ta.title_id
JOIN sales AS sl ON sl.title_id = ttl.title_id;

CREATE TEMPORARY TABLE ttb AS
SELECT
tta.TITLE_ID AS 'TITLE_ID',
tta.AUTHOR_ID AS 'AUTHOR_ID',
SUM(tta.SALES_ROYALTY) AS 'SALES_ROYALY_SUM'
FROM
tta
GROUP BY
tta.AUTHOR_ID,
tta.TITLE_ID;

CREATE TEMPORARY TABLE ttc AS
SELECT
ttb.AUTHOR_ID,
SUM(b.SALES_ROYALY_SUM + (ttl.advance * ta.royaltyper / 100)) AS 'TOTAL_ROYALTIES'
FROM
ttb
JOIN titles AS ttl ON ttl.title_id = ttb.TITLE_ID
JOIN titleauthor AS ta ON ta.title_id = ttb.TITLE_ID
GROUP BY
ttb.AUTHOR_ID
ORDER BY
TOTAL_ROYALTIES DESC
LIMIT 3;

SELECT * FROM ttc;

-- Challenge 3
CREATE TABLE most_profiting_authors AS
WITH 
b AS 
(
WITH
a AS
(
SELECT 
ttl.title_id AS "TITLE_ID",
ta.au_id AS "AUTHOR_ID",
(ttl.price * sl.qty * ttl.royalty / 100 * ta.royaltyper / 100) AS 'SALES_ROYALTY'
FROM
titles AS ttl
JOIN titleauthor AS ta ON ttl.title_id = ta.title_id
JOIN sales AS sl ON sl.title_id = ttl.title_id
)
SELECT
a.TITLE_ID,
a.AUTHOR_ID,
SUM(a.SALES_ROYALTY) AS 'SALES_ROYALTY_SUM'
FROM
a
GROUP BY
a.AUTHOR_ID,
a.TITLE_ID
)
SELECT
b.AUTHOR_ID,
SUM(b.SALES_ROYALTY_SUM + (ttl.advance * ta.royaltyper / 100)) AS "TOTAL_ROYALTIES"
FROM
b
JOIN titles AS ttl ON ttl.title_id = b.TITLE_ID
JOIN titleauthor AS ta ON ta.title_id = b.TITLE_ID
GROUP BY
b.AUTHOR_ID
ORDER BY
TOTAL_ROYALTIES DESC
LIMIT 3;

SELECT * FROM most_profiting_authors