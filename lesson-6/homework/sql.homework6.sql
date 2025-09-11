Puzzle.1
1)SELECT col1, col2
FROM (
    SELECT col1, col2 FROM InputTbl
    UNION
    SELECT col2, col1 FROM InputTbl
	) AS x
WHERE col1 < col2;

2)SELECT DISTINCT 
CASE 
	WHEN col1 < col2 THEN col1
	ELSE col2
	END AS col1,
CASE
	WHEN col2 > col1 THEN col2
	ELSE col1
	END AS col2
FROM InputTbl

3)SELECT DISTINCT col1, col2 FROM InputTbl
  WHERE col1 < col2

Puzzle.2
SELECT * FROM TestMultipleZero 
WHERE COALESCE(A,0) + COALESCE(B,0) + COALESCE(C,0) + COALESCE(D,0) != 0

Puzzle.3
SELECT * FROM section1 
WHERE ID % 2 = 1

Puzzle.4
SELECT TOP 1 * FROM section1
ORDER BY id ASC


Puzzle.5
SELECT TOP 1 * FROM section1
ORDER BY id DESC


Puzzle.6
SELECT * FROM section1
WHERE name LIKE 'B%'

Puzzle.7
SELECT * FROM ProductCodes
WHERE CODE LIKE '%\_%' ESCAPE '\'

