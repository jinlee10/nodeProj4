show databases;
show tables;

CREATE TABLE IF NOT EXISTS hello(
	a Integer(10) NOT NULL,
	id varChar(20) NOT NULL DEFAULT 'guest',
	ipaddrs varChar(16) NOT NULL DEFAULT '192.180.0.1'
);

-- //////// 문자열처리나 함 해보자구!/////////////

-- CONCAT (a, b)
SELECT
	CONCAT('h', 'i') concat  -- alias죠?
;

-- SIBSTRING(ori, from#, length2print)
SELECT
	SUBSTRING('kimchijoa', '1', '2') substring
;

use bookstore;

SELECT * FROM orders;
SELECT SUBSTRING(orderdate, '1', '4') substring
FROM orders;

SELECT DATE_FORMAT(orderdate, '%Y') date_format FROM orders;

-- trim()
SELECT TRIM('           ni hao          ') nihao
	, CONCAT('*****', '     hell yeah    ', '*****') concat1
	, CONCAT('*****', TRIM('           ni hao          '), '*****') conc2
;

SELECT
	LENGTH('pneumonoultramicroscopicsilicovolcanoconiosis') length
	, LENGTH('진폐증') korlength -- (유니코드 한글은 3이야)
	, CHARACTER_LENGTH('pneumonoultramicroscopicsilicovolcanoconiosis') charlength
	, IFNULL(LENGTH(NULL), 0)
;

use sample;

SELECT * FROM sample21;
SELECT * FROM sample21
WHERE	birthday >= STR_TO_DATE('1970-01-01', '%Y-%m-%d')
;

-- CASE문


