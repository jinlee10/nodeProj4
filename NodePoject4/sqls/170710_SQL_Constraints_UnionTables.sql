use sample;

-- 복습! 
-- sql문의 주석은 --야!
-- 테이블 이름은 ta1
-- column은 1. name에 varchar10자리
-- 2. num은 숫자 기본값은 0

CREATE TABLE IF NOT EXISTS ta1(
	name varChar(10),			-- do indent 4 readability
	num Integer DEFAULT 0
);	-- 끝은 semicolon!

DESC ta1;


INSERT INTO 
	ta1(name) -- 모든컬럼이면 생략ok
VALUES 
	('kim')		-- 숫자는 ''안해도되지만 엄밀이 따지면  해주는게좋다?
;

SELECT * FROM ta1;

-- DELETE FROM ta1 WHERE name = 'kim';


-- NULL방지 위원회
-- IFNULL(만약에 여기가 null이면, 여기있는걸로 탈로스 대체해주세요) *****


-- ------------------------------------------------------------------------------

-- 2교시, constraints

CREATE TABLE IF NOT EXISTS sample631(
	a varChar(10) NOT NULL,
	b varChar(10) UNIQUE, -- 같은 column에 대해서만 제약조건이 걸린다
	c varChar(10)
);

INSERT INTO sample631(a, b, c) VALUES('a', 'a', 'a'); -- 모든 column보단 name을 assign하자..

DESC sample631;
SELECT * FROM sample631;

-- DELETE FROM sample631 WHERE a = 'f';

INSERT INTO sample631(a, b, c) values('b', 'b', null);

INSERT INTO sample631(a, b, c) values('c', null, null);
-- UNIQYE: null도 하나의 값으로 인정을 해서
-- null 데이터들으 null계열은 는 안됨
INSERT INTO sample631(b, c) values('ㅇ', 'b', b);


CREATE TABLE IF NOT EXISTS sample632
	a varChar(10) NOT NULL UNIQUE,
	b varChar(10) UNIQUE UNIQUE, -- 같은 column에 대해서만 제약조건이 걸린다
	c varChar(10) UNIQUE	-- 들어간
	
	-- 열끼리면 비교한다
);

SELEct * from from SAMPLE 6311;

-- ----------------------------------

CREATE TABLE sample6312(
	a varChar(10) primary key, -- 기존에있는내용과 비슷해서 똑같으면 아예 insert가안된다
	b varChar(10)
);

INSERT into sample6312(a, b) VALUES('a', 'a');
INSERT into sample6312(a, b) VALUES('b', 'c');
INSERT into sample6312(a, b) VALUES('c', null);
INSERT into sample6312(a, b) VALUES('c', null);
INSERT into sample6312(a, b) VALUES(null,null);

TRUNCATE TABLE sample6312;
SELECT * FROM sample6312;

-- ----------------------------------

-- PRIMARY KEY는 하나의 컬럼에만 지정할 수 있다!!!!
-- 유니크는 여러곳에 사용ok
CREATE TABLE sample6313(
	a varChar(10) primary key, -- 기존에있는내용과 비슷해서 똑같으면 아예 insert가안된다
	b varChar(10)			-- 여기선 단 하나의 primary가 모든 컬럽ㅁ을 검열한다
);

-- --------------------------------------------

-- 3교시: primary key

-- 앞으로 위에꺼처럼 안쓸꺼고 두 개 이상의 column을 합쳐서 
-- 하나의 primary key 를 만들것이다

-- primary key는 레코드 하나하나 구분하기 위한 용도의 키다.
-- 경우데 따라선두 개 이상의 column을 합쳐야만 primary key가되는경우가있따 --> 이게 주 용도

-- primary key 사용법
-- 1. 하나의 column뒤에 붙인다
-- 2. 테이블 생성할때 column type 선언 하고나서 제약조건을 comma(,) 찍고 추가한다

-- 제약조건!!!!! constraints!!!
CREATE TABLE IF NOT EXISTS sample632(
	`no` integer,		-- ` (grave accent 로 둘러싸면 keyword도 col이나 table명으로 사용할 수 있다)
	sub_no integer,
	name varChar(10), -- oracle에선 varchar2로써야 한글이 안깨진단다~
	-- primary key (no, sub_no)		-- 여기서 제약조건을 준것이다 (모든 레코드 구분용)
	CONSTRAINT pri_no_sub primary key(no, sub_no)		-- 제약조건에 이름을 할당 (두개이상이면 복합키라고도 한대)
	
	-- keyword들이 column name으로 쓰여도 오류가 나진 않지만 엔간하면 쓰지말장
	-- column명이다 table명 앞뒤에 single quotation 붙인건 그냥 일반 문자다! 라고 명시적으로 하는거
	
	-- col이나 table 지정할때 ` (grave accent 로 둘러싸면 
	-- keyword도 col이나 table명으로 사용할 수 있긴 하다) ---> node.js가서도 나올거!
);

-- 모든 레코드 구분하는 용도로 쓸거라 특정 column에 같은값 들어가면 안돼!
DROP TABLE IF EXISTS sample632;

INSERT INTO sample632(no, sub_no, name) VALUES(1, 1, 'kim');
INSERT INTO sample632(no, sub_no, name) VALUES(1, 2, 'kim');		-- no라는 컬럼은 primary key 할거라고 지정해놔서 에라뜨죠?
INSERT INTO sample632(no, sub_no, name) VALUES(1, 3, 'kim');		-- 첫번째 key 계속 중복이 되고있네?
INSERT INTO sample632(no, sub_no, name) VALUES(2, 1, 'kim');		-- 앞에건 ㄴ중복이지만 둘째컬럼은 중복되네??
INSERT INTO sample632(no, sub_no, name) VALUES(1, 3, 'kim');		-- 이미 1, 3이 insert되어있는상태 ---> 에~~~라@@@
										-- > 두 개의 컬럼이 동시에 같은 경우에만 에러가 떨어진다
										-- > 독자적인 column에는 primary key 미적용. 합 쳐 서 따진다
INSERT INTO sample632(no, sub_no, name) VALUES(NULL, 3, 'kim');	-- primary key로 묶인 column들ㄷ은 기본적으로 not null이 물려있다

-- 두개이상의 col로 묶어야지만 레코드 구분되는 일들이 업무적으로 많이나온다....
-- (고객이 물건을 산다치면 여러개 살수 있었을거니까 고객+상품(단발성 서비스 등) id 붙여서 primary하면된당)

-- -------- 여태까지는 이름을 지정하지 않았었다 : anonymous같이 .찍어 접근하지 못했었음
-- 나중에 변경하거나 하고 싶으면 이름이 없어서 접근이 안된다
-- CONSTRAINT 제약조건이름 PRIMARY KEY (컬럼1, 컬럼2 등) (pri로 많이 시작한다: pri_no_sub 같이)

SELECT * FROM sample632;

-- 제약조건이 있으면 집어넣을때마다 다 검사하기때문에 느린다. 그래서 일부러
-- 제약조건 삭제했다가 다시 집어넣는 경우도 많다 (백업데이터 insert할떄 많이 쓰는 방법이다)
--  -----> 이름을 붙여야 제약조건을 추가, 수정, 삭제 가능하겠지?
-- ALTER TABLE : 테이블의 구조를 수정하는 DDL

ALTER TABLE sample632 DROP primary key;	 -- column을 지우는게 아니고 제약조건을삭제할것


-- -----------------------------------------------------------------

-- 점심먹ㄱ ㅗ4교시

CREATE TABLE IF NOT EXISTS sample632(
	`no` integer,		
	sub_no integer,
	name varChar(10),
	
	CONSTRAINT pri_no_sub primary key(no, sub_no)
);

DROP TABLE IF EXISTS sample632;

INSERT INTO sample632(no, sub_no, name) VALUES(1, 1, 'kim');
INSERT INTO sample632(no, sub_no, name) VALUES(1, 2, 'kim');		
INSERT INTO sample632(no, sub_no, name) VALUES(1, 3, 'kim');		
INSERT INTO sample632(no, sub_no, name) VALUES(2, 1, 'kim');		
INSERT INTO sample632(no, sub_no, name) VALUES(1, 3, 'kim');		
INSERT INTO sample632(no, sub_no, name) VALUES(NULL, 3, 'kim');

DESC sample632;
SELECT * FROM sample632;

ALTER TABLE sample632 DROP primary key;		-- 얘만 유독 그냥 drop contraint name 안하고 그냥 된다
															-- 테이블에 단 하나! 만 있어야되서 그런가부지

-- 제약조건추가
ALTER TABLE sample632
	ADD CONSTRAINT pri_no_sub primary key (no, sub_no)
;


-- ------------------------------------------------------------

-- AUTO_INCREMENT (MySQL, MariaDB, SQLite 3.0 등에만 해당)
-- increment means 증가. 얘는 오직 숫자만 증가한다

-- member 테이블
-- num 숫자 1,2,3,4,5,6,7,8, primary key (중복 노우!!!) --> 얘로 식별한다
-- name 문자 10자리까지

CREATE TABLE IF NOT EXISTS member(
	num Integer AUTO_INCREMENT,
	name varChar(10),
	CONSTRAINT primary key (num)	-- 컬럽하나 뒤에 놔도 되지만 가급적 쓰지말자
	--	그래야 나중에 중복 primary key 만들기도쉽다
);

DESC member;
-- num 이라는컬럼이 pri로 잡힌다. extra에 auto_increment (오라클-sequence, mssql-identity)
-- AUTO_INCREMENT는 현업에가면 절대로 jue dui 쓰지 말라고할것
--					  문제점: 한 10번까지 넣어뒀다가 3번이상 지우고 다시 insert하면 11부터되어있다
--								중간에 없는번호를 많이 만들어둔다(oracle의 sequence도 ms의 identity도 마찬가지

SELECT * FROM member;

TRUNCATE TABLE member;

-- CRUD는 이제 기본이된다? 김성모체다?
INSERT INTO member (num, name) VALUES (1, 'kim'); -- num은 primary key얄!
INSERT INTO member (name) VALUES ('JOHN CENAA');

INSERT INTO member values(null, 'kim');			-- NULL을 넣었음에도 불구하고 알아서 숫자로 들어간다
								-- 진짜 null이 아니라 db보고 알아서 auto increment 해달라고 한것
								-- (자동 증가 숫자 컬럼)

-- 3번이상되는 record를 다 지워보자
DELETE FROM member WHERE num > 9;


-- ----------------------------------------------

-- 또 하나의 제약 조건 : FOREIGN KEY     (외래키 혹은 참조키)
-- 다른 테이블의 특정한 테이블과 매칭된다
-- 학과, 학생 관리 테이블처럼...

-- 어떠한 테이블을 생성하면서 하나의 뭔가로 접근하고싶다??뭔소링댜


-- ㅘ쇼ㅐㄹ
-- ㅘ-- ㅗㅔㅅ댜ㅔ

SELECT * FROM member;

-- 학새,ㅇ

CREATE TABLE IF NOT EXISTS faculty(
	num Integer AUTO_INCREMENT,
	name varChar(100),
	tel varChar(20),
	-- primary for faster ussage
	CONSTRAINT pkey_num primary key (num) -- 펄네임으루다가 써야한다!
	-- constraint 제약조건 이름ㅇ느 써주는것이좋다
	
	
);

-- db없는건 하나도덦다. 설계->분석->DB ->  gui -> 로직개발

-- 게임이든 뭐든 제일중요해@!!!

INSERT INTO faculty(num, name, tel) VALUES(1, '밀가루연구과', '000-0000-0001');
INSERT INTO faculty(num, name, tel) VALUES(2, '라면연구과', '000-0000-0002');
INSERT INTO faculty(num, name, tel) VALUES(3, '과자 연구과', '000-0000-0003');
INSERT INTO faculty(num, name, tel) VALUES(4, '음료수 연구과', '000-0000-0040');

SELECT * FROM faculty;

DROP TABLE IF EXISTS faculty;

-- ----------------------- 학생만들자

-- 이름
-- 학과코드
-- 학생 코드

CREATE TABLE IF NOT EXISTS tstudent(
	num Integer,
	name varChar(20),
	fNum Integer, -- REFERENCES faculty(num) 이라고도 쓸수있으나 ㄱ냥 따로따로 써라!!!
	CONSTRAINT pri_stud primary key(num),
	CONSTRAINT fri_faculty_num_fNum FOREIGN KEY(fNum) REFERENCES facubookstorelty(num) -- <-- fNum컬럼 제약조건줌
			-- fNum이 foreign key입니다~ 그리고 참조하고자하는 테이블(참조할컬럼)
			-- FOREIGN KEY(컬럼명) REFERENCES 테이블(컬럼명) ---> 자릿수제한, 타입 다 같아야 한다(이름은 노상관)
			
			-- 조건)
			-- 카페에올라와있셩~
);bookstore

DROP TABLE IF EXISTS tstudent;
ALTER TABLE tstudent DROP CONSTRAINT fri_faculty_num_fNum;	
SELECT * FROM tstudent;

INSERT INTO tstudent(num, name, fNum) VALUES(1, 'JOHN CENA', 1);-- fNum에 자약걸어서 특정한 테이블컬럼의 있는값이면 쓴다
INSERT INTO tstudent(num, name, fNum) VALUES(2, 'CHUCK NOURISH', 2);
INSERT INTO tstudent(num, name, fNum) VALUES(3, 'DRUID', 3);
INSERT INTO tstudent(num, name, fNum) VALUES(4, 'PALADIN', 4);
-- 다른 테이블의 컬럼하고 똑같아야 된다: foreign keys

-- --------------------------------------------------------

-- 물리삭제와 논리삭제

-- 테이블 생성 Dmember
-- memId: 숫자, 자동증가 숫자 형태, primary key 로 지정
-- 이름: 문자 ~10자
-- ㅇ림 : 0 ==> 일반,  --> 탈퇴 -- boolean 없네...

CREATE TABLE IF  NOT EXISTS dmember(
	memID integer AUTO_INCREMENT,
	name varChar (10),
	dFlag int(1) NOT NULL DEFAULT 0,
	CONSTRAINT pri_melId_ primary key(memID)
);

INSERT INTO DMember values(null, 'john cena', 0);
INSERT INTO DMember values(null, 'john Cena', 0);
INSERT INTO DMember values(null, 'F cena', 0);
INSERT INTO DMember values(null, 'john cena', 0);
INSERT INTO DMember values(null, 'john cena', 0);
INSERT INTO DMember values(null, 'john cena', 0); 

SELECT * FROM Dmember;

-- DELETE TABLE from DMember WHERE memId = 4;	-- 진짜하지마라
UPDATE DMember SET dFlag = 1 WHERE memId = 4;	-- 삭제대신 flag를 줘서 나중에 SELECT할때 0인건만 뽑고 이런식으루닥 ㅏ하자

-- DELETE TALE from DMember WHERE memId = 2;
UPDATE DMember SET dFlag = 1 WHERE memId = 2;

-- 일반회원 목록 불러오기
-- delete안하고 flag만 바꾼거면 나중에 탈퇴회원 목록도 볼 수 있겠지?
SELECT * FROM DMember WHERE dFlag = 0;

-- 물리삭제되신 특정컬럼을 두어서 그 컬럼의 데이터가 수정되는것
-- 현업에선 심지어 얘도 안쓰고 DELETE TABLE 따로만든댄다~


-- -----------------------------------------------------------------------
-- -----------------------------------------------------------------------
-- -----------------------------------------------------------------------


-- 집 단 함 수 & SUBQUERY


use sample;

SELECT * FROM sample51;

-- 레코드가 몇 건인지 보여주죠? name, quantity는 4건이죠? 
-- 왜냐면 Count()할때 NULL은 대상에서 제외되기 때문이죠?
-- quantity는 합계가 아니고 걍 행수죠?
-- count(아스테리스크)는 null 무관하게 record의 갯수를 리턴하죠?
SELECT COUNT(name), COUNT(quantity), COUNT(*) FROM sample51;	

-- 테이블 내용중에 name이 A인 레코드의 수를 반환하라
-- 	==> 특정한 column주지않고 조건절로만 하고 COUNT()함수를 써라! 라는 뜻 ㅎ
SELECT name FROM sample51 WHERE name = 'A';
SELECT COUNT(*) cnt FROM sample51 WHERE name = 'A'; -- ALIAS쓰는걸 습관하해라
-- 함수 쓰고나면 뒤에 꼭 함수명(ALIAS) 써라! java서 갖다쓰기좋게!!!
-- 검색창에서 n건이 나왔습니다 이것도 count()이거쓴거

-- 일반적인 집단함수를 쓰면 조건 만족 안해도 한줄은 나온대!!
SELECT COUNT(*) cnt FROM sample51 WHERE name = 'X'; 

-- 중복제거 DISTINCT
SELECT COUNT(*), COUNT(name), COUNT(DISTINCT name) FROM sample51; -- 응 중복된값은 하나로만봐~


use bookstore;

show tables;

SELECT * FROM orders;

-- 주문한 실 고객수, 실 판매된 책 종류를 알고싶어!
SELECT COUNT(custid) custid, COUNT(bookid) bookid,
		 COUNT(DISTINCT custid) custcnt,  -- 중복은 무적권(오타아님ㅎ) 하나로 쳐!
		 COUNT(DISTINCT bookid) bookcnt
FROM orders
;

SELECT custid FROM orders;

SELECT DISTINCT custid FROM orders; -- 중복뺀 1234만 나오죠?


-- ---------------------------------------------------------------

-- count() 이외의 집계함수!!!!
-- 얘네는 count마냥 문자숫자 구분없이 다쓸수없다

use sample;

SELECT * FROM sample51;

SELECT AVG(IFNULL(quantity, 0)), SUM(quantity), AVG(quantity) FROM sample51;
-- 나온 데이턴 자바에서 잘 갖구가~


-- ----------------------------------------------------------------------
use sample;
-- 7교시 GROUP BY!!! 말그대로 그룹으로 묶어 실행하는것. 
-- typing 순서: (SELECT) - FROM - WHERE - GROUP BY - ORDER BY - LIMIT (각각을 절 이라고한다)

SELECT name, quantity FROM sample51;

SELECT name, SUM(quantity) FROM sample51 GROUP BY name; -- group by에 썼던 컬럼명은 쓸수있다

SELECT 
	name, SUM(quantity), COUNT(*) 
FROM 
	sample51 
WHERE 
	name IS NOT NULL 
GROUP BY 
	name
; -- null은 솔까 뺴자~
-- where에서 null을 비교할 때는 !=도 안되고 <> 안되고(얘는 문자열이나 숫자만)
-- IS NULL, IS NOT NULL에만 써야한다

-- SELECT name, quantity FROM sample51 GROUP BY name; -- 그룹바이에 안나오는 quantity는 저리 가라그래
-- 참고로 집단함수 안에 넣으려 사용하는 것은 괜찮느니라~

use bookstore;

SELECT * FROM orders;

-- orders table에서 customer별 매출액 합계와 거래 건수를 출력하라!
-- 매출액 상위 3명만 금액이 많은 순으로 뽑아봐 마!
use bookstore;
SELECT
	custid, SUM(saleprice) sales, COUNT(*) cnt -- 보편적으로 groupby한 놈(custid)을 같이 출력한다
FROM
	orders
WHERE 
	orderid >= 1
GROUP BY
	custid
HAVING
	cnt = 3
ORDER BY
	sales DESC -- alias!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
LIMIT 3	-- 3명만 뽑을란다~
;


-- group by절 된 column외에 컬럼명이 들어가면 오라클에선 에러떨어진댄다~ (집단함수에 들가는것들 빼고)


use sample;

select name, count(*) cnt -- 항상 앞에 groupby가 오게 하라
from sample51
where name is not null
group by name
having cnt > 1	-- 얘는 그룹으로 나누고 그룹별로 적용되는거 ALIASSSSSSSSSSSSSsss
;