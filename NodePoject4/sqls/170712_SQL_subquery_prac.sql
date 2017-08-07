-- 0712 sql subquery and join prac

use scott;

-- 실습문제
-- 1) 모든 사원의 사원번호, 이름, 부서명, 위치를 출력하시오

SELECT
	e.empno, e.ename, d.dname, d.loc
FROM
	emp e INNER JOIN dept d
	ON e.deptno = d.deptno
;

-- 2) 직원의 이름, 업무, 부서코드, 부서명, 급여, 호봉을 출력하시오.
--  단, 업무가 'SALESMAN'이 아닌경우만 급여에따라 내림차순으로
SELECT
	salinfo.*, dept.dname
FROM
	(
	SELECT
		emp.ename, emp.job, emp.deptno, emp.sal, salgrade.grade
	FROM
		emp INNER JOIN salgrade
	ON emp.sal BETWEEN losal AND hisal
	) salinfo INNER JOIN dept
ON	
	salinfo.deptno = dept.deptno	
WHERE
	salinfo.job <> 'SALESMAN'
ORDER BY
	salinfo.sal DESC
;



-- 3) 부서별 인원 및 급여의 평균, 급여의 합을 출력하시오.
--   단, 부서번호가 10번인 것은 제외

SELECT * FROM emp;

SELECT
	em.*
FROM
	(SELECT
	 	COUNT(deptno) deptcount, ROUND(AVG(sal)) salavrg, SUM(sal) salsum
	 FROM
	 	emp
	 WHERE
	 	deptno <> 10
	 GROUP BY
	 	deptno
	 ) em
;

-- 4) 업무가 CLERK인 사람의 부서의 부서코드, 부서명, 부서위치를 출력하시오.

SELECT
	
FROM
	
WHERE
	
;


-- 5) KING에게 보고하는 모든 사원의 이름과 급여를 출력하시오. 

SELECT
	ename, sal
FROM
	emp
WHERE
	mgr =
	(
	SELECT
		empno
	FROM
		emp
	WHERE
		ename = 'KING' 
	)
;




-- 6) 자신의 급여가 평균급여보다 많고 이름에 'S'가 들어가는 직원과 동일한 부서에서 근무하는 모든 직원의
-- 사원번호, 이름, 급여를 출력하시오.
SELECT * FROM emp;
SELECT AVG(sal) FROM emp;

SELECT
	empno, ename, sal
FROM
	emp
WHERE
--	sal > (SELECT ROUND(AVG(sal)) FROM emp ) AND
--	deptno IN (SELECT deptno FROM emp WHERE ename LIKE '%s')
	deptno IN (SELECT deptno
					FROM emp
					WHERE sal > (SELECT AVG(sal) 
									FROM emp) 
										AND ename LIKE '%s%')
;


-- 7) MARTIN과 업무와 부서코드가 같은 사람들의 이름과 업무, 급여를 출력하시오.
SELECT
	ename, job, sal
FROM
	emp
WHERE
	deptno = (SELECT deptno FROM emp WHERE ename = 'MARTIN') AND
	job = (SELECT job FROM emp WHERE ename = 'MARTIN') AND
	ename <> 'MARTIN'
;

-- 8) 부서코드 30번이고 , comm이 NULL이 아닌 사람들의 급여와 부서코드가 
-- 같은 사람들의 사원s번호, 급여,
--   부서코드를 출력하시오.

-- 급여같은거 못했어

SELECT
	emp.empno, emp.sal, dept.deptno
FROM
	emp INNER JOIN dept
ON	emp.deptno = dept.deptno
WHERE
	emp.deptno = 30 AND emp.comm <> 0
--	AND sal NOT IN ()
;
