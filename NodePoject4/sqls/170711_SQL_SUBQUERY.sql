--	제약조건 배웠죠?
	-- unique: 특정 column에 값들이 다 틀려야한다
	-- 			얘는 null을 허용하는바람에 null이 중복될수있다
	-- code: 상품의 특성을 대변하는 일련번호...구분해야겠지?
-- 임의적인 컬럼 하나를 갖고 구분하고싶다... --> primary key
-- primary key: record 구분하려고..
--		얘는 두개이상도 묶을수있었다
-- 		업무적으로 으외로 많이사용한댜 (고객과 상품정보 등)

-- orders테이블 --> orderid로 잡았지만 보통
-- customerid랑 단발성 서비스(vip이용권 등)을 묶어서 같이 쓴다

-- 백업까지 따지면 엄청난 데이터 나갈수있는바람에 pri key는 죽였다 다시 데려온다


-- record삭제 - DELETE, UPDATE ---> FLAG 주고 실삭제 안하고 where로 
-- 			구분해서 crud. 나중에는  delete update안하고 삭제테이블
--				따로 만들것. (지우진 않되 정보표시만 따로)
-- 탈퇴 후 재가입 처리 등.


-- group by절과 집단함수(COUNT SUM MIN MAX AVG)



-- 170711 SUBQUERY

-- UPDATE SELECT DELETE INSERT 안에
-- 또다른 SELECT문이 오는것을보고 subquery라 한다

-- 두 개 이상의 sql문실행시 필요
-- 따로따로 써도 되나 연속성 존재할 경우 사용(하나에서 얻어진 값을
--	둘째 sql문에서 쓴다) --> 하나로 실행되게 된다

-- 끼 / 워 / 넣 / 기

-- 얘 뺴고 join()과 설계 남음. 얘를 잘해야 sql을 잘짤수있다!!!!
-- lian xi lian xi
-- 잘짜면 한방에, 못 짜면 여러번에 걸쳐서 짜야된다
USE sample;
SELECT *
FROM sample54; DESC sample54;			-- shud be a habit!!!!!!!
-- er diagram
-- actually the outcome shud be sql query lines




-- -------------------------------------------------------

-- subquery definition

-- sample54에서 a컬럼의 가장 작은값을 구하라!
SELECT MIN(a)
FROM sample54
;

-- sample54에서 a컬럼의 가장 작은값을 구하여 그 레코드를 삭제하라
-- (삭제시 복구 안댐!!!)
DELETE
FROM
	sample54
WHERE
	a = 20
;


-- u hav 2 write twi queries!
-- (earned data from first query then ran another)


-- WHEN USING SUBQUERIES, MAKE SURE YOU SURROUND EM WITH ()!!!!!
DELETE
FROM
	sample54
WHERE
	-- mysql에서는 데이터 추가 혹은 갱신시 동일 테이블을 서브쿼리서
	-- 사용 못하게 되어있다고한다. 에러 없에려면 인라인 뷰로
	-- 임시 테이블을 만들수있게 처리해야한다.
	a = (
SELECT MIN(a)
FROM sample54) -- 그래서 이건 안된다
;
SELECT *
FROM sample54; USE bookstore;
SELECT *
FROM orders;

-- orders테이블 가격이 가장 비싼 bookid에 해당하는 book의 정보를
-- 확인하자
SELECT
FROM orders
ORDER BY saleprice DESC
LIMIT 1;
SELECT *
FROM book
WHERE bookid = 3;
SELECT * FROMbook
WHERE bookid = (seect orders);
SELECT
FROM bo kwhere bookid = (
SELECT bookid
FROM orders
ORDER BY DESC;

-- 과정중에 자꾸만 sql을 보여줘야한다
-- 자바발표 X!!
-- sql문에대한 내용


-- 집단함수는 무적권 한줄은 나온다!!1 (결과가)

-- subquery 결합할때 그게 어떻게 나올지 반환값을 알고 써야된다는것이다
-- p.209 상단에 WHERE문 쓰는데 a = (어쩌구) 형식이자너
-- 그럼 당연히 값은 한개만 나와야되는데 값이 만약에 column갯수, 반환되는 레코드의 갯수가 안맞는경우가 많다@!!!! 그러니까 반환되는거 알고쓰자
-- 서브쿼리 부분만 잘라내서 실행해봐! --------> result를 서브쿼리 부르는애한테 넣을수이으면 되는거지만 아니면 섭쿼리를 잘못짠거라고 이해하면도니다

-- p.207-208 섭쿼리로 나올수있는 값의 패턴 네가지 중
-- 1번처럼 단 한개만 나오는걸 스칼라 값이라고 한다.

-- mostly 1번 2번. oracle에서 set해서 가로붙일떄는 좀 쓰긴하는데 mysql에선안쓴다

-- 210p 5-21, 5-22(굿-쌤피셜) set을 다른데서불러온값으로..
USE sample;
SELECT *
FROM sample54;
UPDATE sample54 SET a = (
SELECT MAX(a) maximum
FROM sample54
WHERE	1 = 1			-- where절은 책에없으도 일단 쓰고봐. 의무야!!!
;

-- 함 수 연산자 수식 쓰면 moo-jeuk-kwon ALIAS name 쓰는버릇들여! ----> so others could access this via alis name


-- 211쪽-FROM 구에서 섭쿼리 사용하기

-- FROM 뒤에 테이블이름만 썼었는데 이젠 뒤에 섭쿼리 와도 된다
-- --- 인라인 뷰--data는 내것이아니라 나를 통해 접근할 수 있따
USE scott; SHOW TABLES;
SELECT *
FROM emp; DESC emp;

-- 



-- 여태까지는 from 뒤에 테이블명만 와엇지:



-- emp 테이블중에서 부서코드가 2인 사람들ㅇ의 레보드 중에서 급여가
-- 1000 이상인 사람 정보럴 출력하라 ==> 조건으롬ㄴ 닫제앦겨
SELECT 
	*		-- 여기서 왜 job이랑 안나오지?? 밑에 from다음에 봐봐~
FROM	
	(
SELECT
		empno, ename, sal
FROM
		emp
WHERE
		deptno = 20 AND sal >= 1000) sa
WHERE dm
;

-- 섭쿼리 연스 연습연연습!!!
USE scott;
SELECT *
FROM emp;


-- 실습: emp 테이블에서 부서별 급여합을 구하고, 그 합중에
-- 값이 4000보다 큰 부서의 코드와 그 합을 출력하라

-- (FROM 뒤에 subquery루다가)
SELECT
	*		-- from 안에있는 그 반환값들
FROM
	(
SELECT
		deptno, SUM(sal) sal_sub -- 여기서 반환되는것만 밖으로 튀나간다
FROM
		emp
GROUP BY
		deptno
	) etemp
WHERE
	-- sal_sub >= 4000
	scott.etemp.sal_sub >= 4000 -- 사실은 컬럼 앞 이름에는 어디어디 테이블 안에있는거 쩜 을 찍어야한다
;
-- 좋아요 한 친구들중에서( == 레코드 쪼갠다. 그리고 가 아니야!)
-- 최다 따봉받은사람들 출력 등.
-- 먼저 레코드를 쪼개서 써야되는것이 우선이라면 subquery쓴다. AND로 하지말고 대상을 먼저 쪼개라!
-- 대상먼저 뽑아내고 (일부분으로) 그안에서 뭔가 하고싶을떄가 있을수있다.
-- 레코드를 전체에서 가 아니고 나는 ~~중에서 일때 같이 서브쿼리로 뽑아내서 작동해야한다.


-- -----------------------------------------------------------------------------

-- 3교시
USE sample;
SELECT *
FROM sample541; DESC sample541;
INSERT INTO sample541 VALUES(3, 4);
INSERT INTO sample541 VALUES(3, 3);
INSERT INTO sample541 VALUES(1, 2);
INSERT INTO sample541 VALUES(2, 1);
INSERT INTO sample541 VALUES(2, 5);
INSERT INTO sample541 VALUES(3, 7);
INSERT INTO sample541 VALUES(3, 2);
INSERT INTO sample541 VALUES(1, 1);
INSERT INTO sample541 VALUES(1, 3);
INSERT INTO sample541 VALUES(2, 2);

	-- 값을 집어넣고 전체레코드 다있는데 1,2,3ㅂㄴ 테이블 만들어서 테이블 쪼개서 만들고싶다..

-- 541과 same structured! 541걸 여다가 집어넣을것이다
CREATE TABLE IF NOT EXISTS sample542(
	c INTEGER,			-- same datatype
	d
INTEGER
);
INSERT INTO sample542
SELECT *
FROM sample541
WHERE a = 3;
SELECT *
FROM sample542;


-- inline view, subquarie

-- sample54테이블의 a값중 가장 작은 것의 레코두룰 서삭제
SELECT amin
FROM (
SELECT MIN(a)
FROM sample54) ta;
SELECT MIN(a)
FROM sample54;
DELETE
FROM
	sample54
WHERE
	a = (
SELECT
		 		amin				-- amin은 스칼라값
FROM
SELECT				-- 제일 괄호안부터(sam54에서 최소값구하는 테이블있음.
MIN(a) amin		-- (임시테이블) 이름을 ta로 바꿈
FROM
		 			sample54		-- 
		 		) ta
		 	)
;

--  이렇게 분석할줄알아야, 분장을 쿼리로, 쿼리를 문으로 연습!
--  col에 func, operation 등 오면 무--적--권(오타아님 ㅎ) alias


-- 5.22 에러 어짜구 에러안나게 : 211p 상단
SELECT *
FROM sample54;
UPDATE
	sample54 SET
	a = (
SELECT 
				amin
FROM 
		 		(
SELECT MAX(a) amin
FROM
		 			sample54
		 		) ee
		)
WHERE
		 	1 = 1
;

-- *** 기존테이블이랑 똑가든거 갖고와서 테트스용으로 좋을것 (원본 레코드에 손대는게 
-- table생성하면서 기존에있던 테이블 기반으로 불러온정보를 생성 겸 인서트
CREATE TABLE sample545 AS
SELECT *
FROM sample54
WHERE a = 3;



-- ////////////////////////////////////////////////////////////////////////////

-- 점심먹고 4교시

-- sample551테이블의 a 컬럼을 있음으로 수정하라 (Update
-- 단, sample552의 번호가 있는 경우
USE sample;
SELECT *
FROM sample551;
SELECT *
FROM sample552;
UPDATE sample551 SET a = '있음'
-- WHERE `no` = 3 OR `no` = 5		-- 얘대신 IN 연산자
-- WHERE `no` IN (3, 5)			-- 얘덕에 subquery사용가능하다(안에)
WHERE NO IN (
SELECT no2
FROM sample552) -- 컬럼한놈만와야대
;

-- 스칼라, 한컬럼 한로우, 멀티로우 멀티레코드
USE bookstore;
SELECT *
FROM orders;
SELECT *
FROM book;

-- orders 목록에서 판매된 책 목록의 정보(bookid, publisher, price)
-- IN 연산자루다가 해봐라 (IN 겁나많이쓰죠ㅛㅛㅛㅛㅛ)
-- orders정보 참고하여...

-- 뽑아와야되는거 먼저 뽑아온다
SELECT
	*
FROM
	book
WHERE
	bookid IN (
SELECT DISTINCT bookid
FROM orders) -- distinct로 중복막기
;

-- 판매되지않은 책목록 출력))
-- 애초에 이런건 없다
-- 이렇게 쿼리를 어떻게 짜느냐에 따라 똑같은 db로 더욱 다채로운 아웃풋이 나온다
SELECT
	*
FROM
	book
WHERE
	bookid NOT IN (
SELECT DISTINCT bookid
FROM orders) -- distinct로 중복막기
;


-- IN 쓰면 확장이가능해진다. 가급적 OR 쓰찌말짜!
-- 얘랑 select 섭쿼리랑 짝짝꿍으로 자주쓰인다


-- ------------------------------------------------------------------------

-- DB만들기

-- 'db 분리하세요~' == db 따로 생성
CREATE DATABASE IF NOT EXISTS dbprac; USE dbprac;
DROP TABLE IF EXISTS a;
CREATE TABLE IF NOT EXISTS a(
	a INT
);
DROP DATABASE IF EXISTS dbprac;

-- constraints
--  pkey
-- constraints dynamic ud

-- -----------------------------------------------------

-- VIEW

-- 이걸 통해서 보라!
-- 실제 물리적접근할수잇는...information_schema
USE sample;
SELECT 
*
FROM
sample54
;
DELETE
FROM sample54;
TRUNCATE TABLE sample54;
INSERT INTO sample54 VALUES(1, 2);
INSERT INTO sample54 VALUES(1, 3);
INSERT INTO sample54 VALUES(2, 4);
INSERT INTO sample54 VALUES(2, 6);
INSERT INTO sample54 VALUES(1, 7);
INSERT INTO sample54 VALUES(2, 5);
INSERT INTO sample54 VALUES(1, 1);
INSERT INTO sample54 VALUES(1, 2);
INSERT INTO sample54 VALUES(2, 9);
INSERT INTO sample54 VALUES(1, 8);

-- sample54에서 no가 2인것들의 갯수, adml합, a평균
-- a최댓값을 반환하도록 하여라
CREATE VIEW sample54v1	-- 실제 레코드가 그대로적용됨 (d엄뭊론 ㅜ
SELECT COUNT(*) cnt2,	-- alias
SUM(a) summnation_a, ROUND(AVG(a)) avrg_a, MAX(a)
FROM
	sample54
WHERE NO = 2
;
-- 조건절 복잡하거나 함수 많이쓰면
-- 뷰 만들어놓고 뷰 셀렉트하면 맨날 최신상태의것을 손쉽게 보게된다
-- (물리적테이블 변경되도 반영된다)
INSERT INTO sample54(NO, a) VALUES(2, 90);


-- /////////////////////////////////////////////////////////////////

-- 5교시 및 7장. 복수의 테이블 다루기

-- 31강 집합 연산(많이쓰지넌아너~ㅎㅎ;)

-- 합집함같은건 보통 테이블구조가 똑같겠지? (예. 응시자와 합격자 테이블 등)
SELECT *
FROM sample71_a UNION
SELECT *
FROM sample71_b;
SELECT *
FROM sample71_a UNION ALL	-- 중복 포함하여 나온다
SELECT *
FROM sample71_b;

-- 아래 두개는 mysql에서 지원안됨^^
-- 교집합: INTERSECT
-- 차집합: EXCEPT(오라클은 MINUS)

-- 얘네 잘 안쓰이긴하는데
-- 전체응시자중 합격자, 불합격자, 2차응시자 등등에 사용할수있겠지

-- -----------------------------------------------------------------

-- 테이블 결합(32강) (JOIN)

-- 테이블과 테이블을 연결해서 쓸 경우도 있지?
-- 곱집합->교차결합(CROSS JOIN) 이거는 좀...

-- 교차결합 간단히
SELECT *
FROM sample72_x;
SELECT *
FROM sample72_y;

-- FROM 뒤에는 두개이상의 테이블 또는 뷰, 인라인 뷰(섭쿼리)가 올수있따
SELECT *
FROM sample72_x, sample72_y; USE scott; SHOW TABLES;
SELECT *
FROM emp;	-- deptno!!! 코드 의미를 알고싶다?
SELECT *
FROM dept;	-- 야 그럼

-- union: 1반과 2반을 보여준다
-- 교차결합: CROSS JOIN으로 테이블을 걍 두개쓰는거야
SELECT *
FROM emp, dept; -- 원하는 컬럼 띄우고싶으면
-- 조인이야 조인!!!! ---> FOREIGN KEY를 다른 테이블의 PRIMARY KEY랑 합치ㅡㄴ거양 그래서 foreign key에 제약조건을 주는거. 두개는 짝짝꿍!
-- 일괄insert하는 table 구조는 제약조건을 왠만하면 안준다. 끝날때 일괄적으로준다.

-- 289p
-- 상품 테이블, 290p 재고 테이블

-- cross join하면 우리가원하는결과가안나올수도있으므로
-- 293p에서 조건절을 붙인다

-- p294에서
-- 상품코드같이 둘다 있는 컬럼 아닌한 풀네임 써줄필요놉
USE sample;

-- 여기까지만 잘하믄대~

show tables;

SELECT * FROM `상품`, `재고수`; -- 한글명 실화냐ㅋㅋ

-- 솎아내기: 정규화. 쌤피셜: 상품분류도 잘라넀어야...

-- cross join은 완벽하게 조인된건아니다(썜피셜: 에라!)
SELECT 상품.상품코드, 상품명, 재고수 FROM `상품`, `재고수`;
-- 상품코드는 ambiguous 오류 뜨므로 풀네임써줘야돼...


-- subquery들 중에서 FROM절 뒤에 있는것만 inline view라고 한다


-- --------------------------------------------------------------
use sample;
-- 6교시

SELECT
	a.상품코드, b.재고수
FROM
	-- 테이블 명에 alias를 사용하게되면 혼용 안되고 alias로만 사용해야한다.
	상품 a, 재고수 b	-- 상품.상품코드 이걸 alias로 대체할수있다
WHERE
	a.상품코드 = b.상품코드 -- 테이블명 . 을해야 ambiguity를 피하지 ㅋ
;


use bookstore;

SELECT * FROM book;
SELECT * FROM orders;

-- orders  테이블을 출력하면서 책이름과 출판사도 같이 출력
SELECT
	od.*, bk.bookname, bk.publisher
FROM
	book bk, orders od
WHERE
	od.bookid = bk.bookid
;


use scott;

SELECT * FROM emp;
SELECT* FROM DEPT;

-- 직원의 이름과 job? 업무...부서명....부서 위치를 알려주고싶다
-- job이 매니저가 아닌사람
--						====> join 필요!!!!!!

SELECT
	ename, job, dname, loc
FROM
	emp e, dept d
WHERE
	e.DEPTNO = d.DEPTNO AND job <> 'MANAGER' -- where절에 조건 복수로 달순있지만...
--	join하려고 쓴 조건 AND 레코드 구분하려고 들인 조건
-- 이거하려고 최-신 유행으로 INNER JOIN이라는 ON이 생겻다
--	일반과 join은 따로 빼서쓰자는 의미.
;


SELECT
	ename, job, dname, loc
FROM
	emp INNER JOIN dept -- 테이블
	on emp.DEPTNO = dept.DEPTNO
WHERE
	job <> 'MANAGER'
;
use scott;
-- 이름과 급여와 급여등급을 찍고싶으면? (호봉)
SELECT * FROM salgrade;
select * from emp;

SELECT
	ename, sal, grade
FROM 
	emp Inner JOIN salgrade
ON sal BETWEEN losal And hisal
;


-- 적어도 등가나 만이해라d
-- 등가조인, 범위조인

-- 일반적인것ㅇ느 298처럼 외부키 전용으로 


-- self join 

SELECT * FROM emp;

select e1.ename, e2.ename
FROM emp e1 INNER JOIN emp e2
on e1.MGR = e2.empno
;


use sample;


select * from 상품;
SELECT * FROM 재고수;

insert into 상품 values('0009', '상품9', 'maker2', 5000,'식료품');
-- Insider into weather;

-- 조인해보자

insert into 재고수  values('0009', '2014-01-07', 30);
-- Inside into weather;
SELECT
	s.`상품코드`, 상품명, 재고수
From
	상품 s left join 재고수 j -- outer join = right join
on
	s.`상품코드`= j.`상품코드`
;
-- orders 테이블 정보와 book 테이블 정보를 같이 보여주는데 책 
-- 목록은 반드시 출력하라
use bookstore;

SELECT
	o.*, b.bookname, b.publisher
FROM
	orders o right join book b -- 빈자리가 있지만 책목록은 다나온다
on
	o.bookid = b.bookid
;

-- -------------------- 301쪽같이~ 302p는 구식이라구 쓰지말랴~


