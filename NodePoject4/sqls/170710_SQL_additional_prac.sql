use bookstore;

SELECT 
	bookid
FROM
	orders
GROUP BY
	bookid
;

SELECT * FROM orders;

SELECT
	MAX(saleprice) maximum,
	MIN(saleprice) minimum,
	SUM(saleprice) summnation,
	ROUND(AVG(saleprice)) average
FROM
	orders
;

show databases;
use scott;
show tables;

SELECT * FROM dept;

-- 1) group by 사용
SELECT
	deptno
FROM
	dept
GROUP BY
	deptno
;

-- 2) distinct 사용
SELECT
	DISTINCT deptno
FROM
	dept
;

SELECT * FROM emp;

SELECT
	ROUND(AVG(comm)) average, SUM(sal) sal_sum, 
	ROUND(AVG(sal)) sal_avg
FROM
	emp
GROUP BY
	deptno
HAVING
	deptno = 20
;

SELECT
	job
FROM
	emp
GROUP BY
	job
;


SELECT * FROM emp;

-- 7

SELECT
	ename, sal, comm, (sal * 12) + IFNULL(comm, 0) anual_sal
FROM
	emp
;



-- 8
SELECT
	deptno, COUNT(deptno) cnt_dept, MAX(sal) sal_max, MIN(sal) sal_min,
	SUM(sal) sal_sum, ROUND(AVG(sal)) sal_avrg
FROM
	emp
GROUP BY
	deptno
;


SELECT * FROM emp;

-- 9
SELECT
	job, COUNT(job) num, ROUND(AVG(sal)) avrg, 
	MAX(sal) max_sal, MIN(sal) min_sal, SUM(sal) summnation
FROM
	emp
GROUP BY
	job
;

SELECT * FROM emp;

-- 10

SELECT
	job, SUM(sal) summnation
FROM
	emp
WHERE
	job <> 'SALESMAN'
GROUP BY
	job
HAVING
	summnation > 5000
ORDER BY
	summnation DESC
;



