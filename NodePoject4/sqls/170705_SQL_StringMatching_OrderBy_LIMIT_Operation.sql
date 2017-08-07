USE sample;

-- 이렇게 두개 쓰는게 주석 --
/* 이곳은 sql 구문 라인 주석 */


SELECT * FROM sample21;

SELECT * FROM sample25;	-- 필요한만큼만 드래그하고 Ctrl F9하면댄다! --

-- CASE 1:
SELECT * FROM sample25 WHERE text = '%SQL'; -- =은 실제내용과 뒤의내용이 완벽히 일치할떄만 나온다 --
-- 와일드문자를 이용한 패턴검색 할때는 = 쓰면안디고 LIKE를 써야나온대 이 바부야 --

-- CASE 2:
SELECT * FROM sample25 WHERE text LIKE 'SQL%'; 
-- 'SQL%' ===> MOO조건 맨 첫글자가 SQL로 시작하는걸찾구 --
-- '%SQL' ===> MOO조건 맨 끝 글자가 SQL로 끝나는걸 찾는그야 마! --

-- CASE 3: 								 = 쓰면 안되죠? LIKE써야되죠 와일드문자 검색은?
SELECT * FROM sample25 WHERE text LIKE '%SQL%'; -- 앞뒤로 뭔문자가 오든간에 중간에 SQL만 포함돼있음  노상관ㅋ --
-- 내용검색이 대게 이런거얌~

-- CASE 4:
SELECT * FROM sample25 WHERE text LIKE '% SQL %'; -- 여기 공백도 하나의 문자여 그러니까 안나오지 ㅉㅉ


-- LIKE로 % 검색 : 앞뒤로 아무문자 와도 되는데 중간에 %가있었음 좋겠어!!
-- case 1: 								 = 매칭은 [전체내용]이 같냐를 구분하는것이야
SELECT * FROM sample25 WHERE text = '%'; 

-- case 2:   -- 여기선 메타문자(와일드문자)로 인식되어 다불러오라그럼
SELECT * FROM sample24 WHERE text LIKE '%';  -- 모든 레코드가 반환되었다

-- case 3:
SELECT * FROM sample25 WHERE text LIKE '%%%'; -- A MOO GUH NAH DA O GEO?

-- case 4:
SELECT * FROM sample25 WHERE text LIKE '%\%%'; -- 메타문자보단 와일드문자라고 쌤prefered

-- Lower dash case '_'
-- case 1:
SELECT * FROM sample25 WHERE text LIKE '%_%';  -- 응 여기도 아무 한문자가 들어갈수있게돼

-- case 2:
SELECT * FROM sample25 WHERE text LIKE '%\_%'; -- 킹갓제너럴엠페러더그레이트올마이티역슬래시


-- 문자열 '\'
SELECT * FROM sample25 WHERE text LIKE'%korea''s%';
SELECT * FROM sample25 WHERE text LIKE'%koreas%'; 


-- ----------------------------------------------------------------------------------------------------

use bookstore;	-- 이 줄만 따로 ^ F9해라
show tables;

SELECT * FROM book;
DESC book;

-- 복숩울 햐소 진도를 따라와야지
-- 한번놓지만축적돼서 놓친다 마!

-- WHERE절과 함께 많이 쓰이는 연산자 두개
-- 1) IN 연산자 : IN (1, 2, 4) <<<<<< NOT IN을 지원한다
-- 2) BETWEEN a AND b

SELECT * FROM book WHERE price >= 10000 AND price <= 20000;
SELECT * FROM book WHERE price BETWEEN 10000 AND 20000; -- between a and b 연산자^^

SELECT * FROM orders; -- 주문정보들에 대한것

SELECT * FROM orders WHERE custid = 1 OR custid = 2 OR custid = 4;
SELECT * FROM orders WHERE (custid BETWEEN 1 AND 4) AND custid <> 3;
SELECT * FROM orders WHERE custid <> 3;

SELECT * FROM orders WHERE custid IN (1, 2, 4); -- 괄호안에 숫자일때만
SELECT * FROM orders WHERE custid NOT IN (1, 2, 4); -- supports not
-- 필요한것만 딱 해서 고것만 불러가면 db는 뿌리기만하면되자너
-- 자바에선 넣어주고 출력 명령만하고 요런건 다 SQL로 구현하자

show databases;
use sample;

show tables;

SELECT * FROM sample31;

SELECT * FROM Customer ORDER BY age DESC;

SELECT * FROM sample31 ORDER BY address DESC;


-- SELEDT FROM samp1e32 order t

show databases;
use sample;
-- ascending으로 소트했을때 NULL보다 작은값은 없다는뜻에서 ORDER BY하면 맨위에나온다
SELECT * FROM sample21 order by birthday; 

SELECT * FROM sample21 order by birthday DESC; -- MySQL은 NULL이 가장작은값(값X), Oracle은 반대일것임
-- table에 NULL없으면 안쓰는데 (DB에 null이 들어가는일이없게 설계하는것이먼저야)
-- 그래서 NULL을 ORDER BY에서 빼기위해...
-- IFNULL(컬럼명, 대체값) 함수를 쓴다!!!!!!! 

SELECT birthday , IFNULL(birthday, 'N/A') FROM sample21 ORDER BY birthday DESC;
-- 잠깐!!!! IFNULL 컬럼 타입이 int면 대체도 int로, String이면 String으로, Date면 Date타입으로!!!

-- 나중가면 길어지니까 키워드(명령어) 엔터 들여쓰기 내용 ---> 이런구조가될것
SELECT
	birthday, IFNULL(birthday, '2017-07-05') as Alias_Name -- ---> as는 대부분안씀
FROM
	sample21
ORDER BY				-- 실행순간에만 이렇게나오지 실지 DB수정안된다
	Alias_Name		-- alias 썼을경우 함수는앞으로 이 이름으로 접근해야한다!!!! (variable name마냥)
DESC
;


SELECT *
FROM sample33
LIMIT 6, 3; -- > offset (전체에서 몇 개 건너뛸것인지), 불러올건수(행수)
--		뒤의 3: 페이지당 보여지는 레코드 갯수
--		앞의 3: 몇 개 건너뛰고 보여줄건데
--		만약에 page가 offset의 변수라치면 공식: (page - 1) * page당 행수

--		총 페이지수 공식: (레코드 갯수 - 1) / 3 + 1  (int int연산은 int나오는데
--								나눠떨어질땐 +1이 돼버리니까 -1을 해서 영원히 맞아떨어지지못하게한다


-- -----------------------------------------------------------------------------------------------------

use sample;

SELECT 
	* -- 컬럼명
FROM 
	sample33
WHERE
	no <= 5
ORDER BY 
	no DESC
-- LIMIT
--	3 -- 3 행씩 나온당		-- order by가 먼저 해석이된거다 그래서 7 6 5나옴
;


use bookstore;

-- 요구사항: 출판사가 굿스포츠가 아닌 목록을 가져와 내림차순으로 출력하라
-- 단, 페이지당 건수는 3개일 경우, 2페이지 목록을 불러와라

SELECT
	*
FROM
	book
WHERE
	publisher <> '굿스포츠'
ORDER BY
	price DESC
LIMIT
	3, 3 -- 스킵되는 갯수, 페이지당 표시 레코드 갯수 (limit max row)


;


-- --------- 수치연산(12강)


use sample; -- 오라클은 유저별 db라고해서 db개념이없다 유저가면 테이블만만든다
-- 하나의 db ~= 하나의 프로젝트!

SELECT
	price, quantity, price * quantity cPrice, price * 0.1 DC10, price * 0.3 DC30
FROM
	sample34
;
-- 컬럼커스텀으루다가 만ㄷ를때 변수를만들어서해라
-- db로는 막 모양 이쁘게 나오게 하지말고 그냥 값만 넘겨줘라
-- Student로 table설계하면 sum avrg rank 이런건 구하면 안된다^^7
-- 앞쪽 column에서 연산하는게있으면 연산값은 테이블에 넣지않고 리턴할때 쿼리로 계한해주는거래~

SELECT
	5 % 3, MOD(5, 3), 5 MOD 3;
	
SELECT
	NULL + 3
;	
SELECT
	IFNULL(NULL, 0) + 3 -- 이렇게 살려줄 순 있당
;

DESC sample341; -- decimal type (옜날에는 double이랑 real 많이 썼었대)

SELECT 
	amount, round(amount), round(amount, -2), FLOOR(amount),-- 버림 (얘는 인자 두개 못넣나벼 ㅋㅋ)
	CEIL(amount), CEIL(amount - 2) -- 올림		---- 고 순간에만 그렇게 보일뿐  실제로 값이 저장된것이 아니라고!
						-- 쌤피셜: DB에서 너무 많이하지마라
FROM 
	sample341;



-- ----------------- SQL 연습 2 ------------------------------------------------

use sample;

-- 1.sample341 테이블에서 100의 자리에서 올림하는 것과,  
-- 소수첫째 자리에서 내림하는 값을 반환하는 Select 구문 완성하세요
SELECT 
	amount, CEIL(amount / 100) * 100 newAmount, FLOOR(amount)
FROM sample341
;

use bookstore;
-- 2.book 테이블에서 bookname에 축구가 포함된 목록에서,  
-- 책이름과 출판사와 가격을 출력하시오?
SELECT
	bookName, publisher, price
FROM
	book
WHERE 
	bookName LIKE '%축구%'
;

-- 3.book 테이블에서 출판사가 굿스포츠와 대한미디어인 
-- 것만의 목록을 출력
SELECT
	*
FROM
	book
WHERE
	publisher IN('굿스포츠', '대한미디어')
ORDER BY
	publisher ASC, price DESC
;


-- 4. book 테이블의 목록을 가격의 내림차순으로 출력하세요
SELECT
	*
FROM
	book
ORDER BY
	price DESC
;



-- 5. orders 테이블에서 saleprice가 10000원 이상인 목록중에서
--   custid의 오름차순으로 정렬하고, 순서가 같으면 bookid의 
--   내림차순으로 정렬해서
--   orderid, custid, bookid, saleprice 만 출력하세요
SELECT
	orderid, custid, bookid, saleprice
FROM
	orders
WHERE
	saleprice >= 10000
ORDER BY
	custid ASC, bookid DESC
;


-- 6. orders 테이블에서 3번째 부터 3개만 출력하는 sql 구문을
-- 작성하세요
SELECT
	*
FROM
	orders
LIMIT
	2, 3
;

-- 7. book 테이블에서 책제목과 출판사와 가격과 30%DC 가격을
--  출력하는 Select 구문을 작성하세요
SELECT
	bookName, publisher, price, FLOOR(price * 0.7) DC30
FROM
	book
;












