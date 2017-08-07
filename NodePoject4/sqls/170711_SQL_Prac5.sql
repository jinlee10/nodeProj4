use scott;

SELECT * FROM dept;
SELECT * FROM emp;

-- 1.dept 테이블과 emp 테이블을 조인하여 사원번호, 
-- 사원이름, 부서명, 부서위치를 반환하라 쿼리문 구현

SELECT
	ename, dname, loc
FROM
	emp INNER JOIN dept
	on emp.DEPTNO = dept.DEPTNO
;
-- inline view 써야함

-- 2. 부서별로 가장 급여를 많이 받는 사원의 정보를 출력하는 예제
SELECT
	ename, job, max(sal) sal_max, dname, emp.deptno
FROM
	emp INNER JOIN dept
	on emp.deptno = dept.DEPTNO

GROUP BY
	dname
HAVING
	sal_max
;

-- 3. emp 테이블에서 MGR(매니저)의 이름이 king인 
-- 사람의 사원번호와 이름과  업무(Job)을 출력하세요
SELECT
	ename, empno, job
FROM
	emp
WHERE
	mgr = (SELECT empno FROM emp WHERE ename = 'king')
;


-- 5. 근무 장소가 NEW YORK인 사람들의 정보를 출력하라 
-- (사원번호, 이름, 부서코드, 부서명)

SELECT
	empno, ename, d.DEPTNO, dname
FROM
	emp e, dept d
WHERE
	e.DEPTNO = d.DEPTNO AND d.LOC = 'NEW YORK'
;




-- 6. SCOTT과 같이 장소에서 근무하는 사람들의 정보를추력하라
--   (사원번호, 이름, 부서코드, 부서명)

SELECT
	e.empno, e.ename, d.deptno, d.dname
FROM
	emp e INNER JOIN dept d
on e.deptno = d.deptno
WHERE
	e.deptno = (SELECT emp.DEPTNO FROM emp WHERE ename = 'SCOTT')
;




-- 7. 커미션을 받는 사원의 이름과 그가 속한 부서명을 출력하시오.

SELECT
	ename, dname, comm
FROM
	emp INNER JOIN dept
	on emp.DEPTNO = dept.DEPTNO
WHERE
	comm <> 0
;

SELECT * FROM emp;



-- 8. 급여가 3000에서 5000사이인 
-- 직원의 이름과 소속 부서명을 출력하시오

SELECT
	ename, dname
FROM
	emp INNER JOIN dept
	ON emp.DEPTNO = dept.DEPTNO
WHERE
	sal BETWEEN 3000 AND 5000
;



-- 9. 부서별 급여가 최저인 사람들의 정보를 출력하세요
--  (in 연산자 활용)
use scott;
SELECT
	ename, job, sal, deptno
FROM
	emp
WHERE
	sal IN (SELECT MIN(sal) min_sal FROM emp 
			  GROUP BY deptno HAVING min_sal)
;


SELECT
	salinfo.*, dept.DNAME
FROM
	(SELECT ename, job, MIN(sal) salmin, dname
	FROM emp
	GROUP BY deptno) salinfo INNER JOIN dept
	
	ON salinfo.deptno = dept.deptno
;



-- 11. 부서별 평균급여와 최대급여, 최소급여 및 부서의 
-- 이름과 부서위치를 반환하라

SELECT
	ROUND(AVG(sal)) avrg_sal, MAX(sal) max_sal, MIN(sal) min_sal,
	dname, loc
FROM
	emp INNER JOIN dept
	on emp.DEPTNO = dept.DEPTNO
GROUP BY
	emp.deptno
;


-- 12. orders 목록에서 실제 구매자(Customer)의 
--   정보(이름과 주소와 전화번호)를 출력하라?
use bookstore;
SELECT * FROM orders;
SELECT name, adderss, phone
FROM
	orders INNER JOIN customer
	on orders.custid = customer.custid
WHERE
	orders.custid IN (SELECT custid FROM orders)
GROUP BY
	orders.custid
;


SELECT * FROM orders;
SELECT * FROM BOOK;


-- 13. 박지성이 주문한 책 목록을 반환해서 출력하라

SELECT
	bookid, bookname, publisher
FROM
	book
WHERE
	bookid IN 
	(SELECT bookid
		FROM orders INNER JOIN customer
			on orders.custid = customer.custid
		WHERE orders.custid = 
						(SELECT custid 
						FROM customer 
						WHERE name = '박지성'))
;



-- 14.야구를 부탁해를 주문한 사람의 정보를 출력하라
SELECT
	custid, name, phone
FROM
	customer
WHERE custid IN 
	(
	SELECT 
		orders.custid
	FROM orders INNER JOIN customer
	WHERE
		orders.bookid = 
			(
			SELECT 
				bookid
			FROM 
				book
			WHERE 
				bookname = '야구를 부탁해'
			)
	)
ORDER BY
	custid	
