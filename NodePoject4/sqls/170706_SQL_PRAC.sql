SHOW databases;
USE bookstore;

show tables;

-- SELECT구문들에 대해 많이했지?
-- ORDER BY ASC, DESC
-- LIMIT로 조건을 만족한다 하더라도 잘라서 볼수있게..
SELECT
1 / 3;	-- SQL은 정수끼리의 연산도 실수연산된다~
			-- 그래서 round가 많이 쓰일것!

-- 문자열 처리 (7.6)
SELECT
	CONCAT('드', '라', '군')
;

USE sample;

SELECT *
FROM sample35
;

DESC sample35;

SELECT CONCAT(quantity, ' ', unit) AS priceInfo -- 습관적으로 alias
FROM sample35
;


USE bookstore;

-- CONCAT()
SELECT
	name, adderss, phone, CONCAT('당신의 이름은 ', name, '이며, 주소는 ', adderss, '입니다') showInfo
FROM
	customer
;


-- SUBSTRING()
SELECT
	SUBSTRING('pneumonoultramicroscopicsilicovolcanoconiosis', 1, 10)	-- start pos, end pos
;

SELECT
	SUBSTRING('하이하이 하하이 ', 2, 2)
;

-- trim()
SELECT 
	TRIM('     hi    hello     ') hiMan
	,CONCAT('*****', '     hi    hello     ', '*****') byeMan
	,CONCAT('*****', TRIM('     hi    hello     '), '*****') wutMan
;
	


-- CHARACTER_LENGTH(글자수) : LENTGH(byte갯수)
SELECT
	LENGTH('pnemonocrisis') lengthA
	, LENGTH('한글의 길이') lengthK -- unicode에서 한글은 3바이트차지
	, CHARACTER_LENGTH('pneumonoultramicro') lengthM
	, IFNULL(LENGTH(NULL), 0)
;

SELECT
	CURRENT_TIMESTAMP() --  ㅗㅜㅑ 연원일 시분초 다나온다!
	, NOW()				  -- 얘두야
;


USE sample;

SELECT * FROM sample21;
-- DESC sample21;
SELECT *
FROM 
	sample21
-- WHERE birthday >= '1970-01-01' 
-- 정확히 따지면 Date타입이니 날짜로 바꿔줘야된다(TODATE())
WHERE 
	birthday >= STR_TO_DATE('1970-01-01', '%Y-%m-%d')
;



-- 15강 ----- CASE문 --------- (자바의 switch case문과 비슷)


-- 개발자는 무지무지 긴데 셀렉트하는 사용자입장에선 편-리 (반환되는덴 의미있는data나옴)
SELECT * FROM sample37; -- null있다!
-- 여긴 boolean없지만 자바랑 할거면 좀 변경해서 boolean해주는게좋다

-- 대체 case
SELECT
	a 
	, CASE -- 보통 case문
			WHEN a = 1 THEN '남자' -- WHEN이 IF같은것. 관계연산자 쓸수있따
			WHEN a = 2 THEN '여자' 
			ELSE '모름' -- default같은것
	  END gender-- 값이 뭐냐에따라나오는것
	-- CASE 가 END까지간다. 얘가 컬럼명에서 제일길게들어갈것
	
	, CASE a -- simple case문(우리가 알던것과 흡사)
			WHEN 1 THEN '남자'
			WHEN 2 THEN '여자'
			ELSE '모름'
	  END genderSimple -- end뒤엔 컬럼명을!
FROM
	sample37
;



-- 16강 -- 행 추가하기 INSERT ---------------------------
SELECT *
FROM sample41	-- 공백이었어! ColumnNAme만 있었어!
;

DESC sample41;

-- 집어넣자!!!
INSERT 
	INTO sample41
VALUES	-- values 갯수와 내부적인 type도 맞춰줘야된다(마치 인자전달같네??)
	(1, '100', CURRENT_DATE()) -- '2017-07-06' 대신 NOW()넣어도됨!! 근데 여선안되네 ㅋ 대신 CURRENT_DATE()는됨
; -- no 자리에 '100'넣으면 에러 안나긴 함...mysql은 실제 value를 중요시하나보네! 

-- DELETE FROM sample41 WHERE no = 12345;
-- table 자바에서 class로 만들땐 table명 첫자가 소문자라도 대문자로 해서 써라
SELECT no + 1 ADDED, a + 1 FROM sample41; -- a column은 문자들어가는데자너..

SELECT * FROM sample41;

-- 특정 컬럼에만 삽입하고싶다
INSERT
	INTO sample41 (a, no) -- 이렇게 순서 바꿔쓸순 있다만 이렇게 쓰지말자 ㅡㅡ+ 앞뒤순서 변경 ㄴㄴ
VALUES
	('와다다다다다다다', 34) -- 앞에 'NULL'넣으면 문자널이 들어간거고 NULL넣으면 진짜 NULL이들어간거임
;

SELECT *
FROM sample37
;

DESC sample37;

INSERT
	INTO	
	sample37
VALUES
	(3) -- 만약이게 성별이면 제약조건을 설정해줘야한다(나중에 배울것)
;

DESC sample411;

INSERT
	INTO sample411(no, d)
VALUES
	(1, null) -- 타입갯수 순서 위랑 같아야죠?
;

UPDATE sample41 
SET a = 'TTTTTTTT'
-- WHERE no = 1
WHERE 1 = 1		-- 만약 모든레코드를 다 바꾸고싶으면 이렇게!
;					-- 일단 복구할방법 없다치고 하니 조심하도록!


SELECT
	-- 많이쓰인다! args0 대신에 columnName이올수있겠지??  UPDATE나 독자적으로나 많이쓰인다
	REPLACE('java c java c java c', 'java', '자바 두명 타요 ') 
;


SELECT * FROM sample41; -- 원 데이터에 +2 해서 출력하자

SELECT *, no + 2 noPlus2 -- 출력만되지 no 컬럼 데이터 변경되는건 아니다
FROM sample41
;

-- 특정 컬럼값을 받아서 연산한걸 다시 넣어주고싶다면??
UPDATE
	sample41
SET
	no = no + 2
WHERE 			-- WHERE절은 무적권 쓰는거야
	1 = 1 -- 모든레코드 데이타가 수정됨
;

INSERT
	INTO sample41(no, a)
VALUES
	(123, 'king god emperor general')
;


-- 안에있는 문자 'TTTTTTTT'를 한글로 바꾸자 (a 컬럼)
SELECT * FROM sample41;

UPDATE
	sample41
SET
	a = REPLACE(a, 'TTTTTTTT', '한글한글') -- 얠 이용해서 기존값 수정가능하죠?
WHERE
	1 = 1
;



UPDATE
	sample41
SET		-- comma를 써서 2개 이상의 컬럼을 수정할 수 있다!!!!
	no = no + 10, a = 'T academy'
WHERE
	1 = 1
;


DELETE FROM sample41 WHERE no = 13;



-- -------------------------------------------------------------------------------------
-- CREATE는 tabel객체를 생성하고자 할때 필요한 구문!
-- ----> 뷰 인덱스 프로시저 또한 생성할수있다

-- table 생성하자 (DDL)
-- sample62
--  num: 숫자
-- name: 문자
-- idate: 날짜 및 시간


CREATE TABLE sample62 (	-- 괄호 사이엔 열명 알지?	
	num INTEGER, 
	name VARCHAR(15), -- 여러 개는 콤마로 나열할 수 있지?
	idate DATETIME
); -- 이미 존재할 시 못만든다

DESC sample62;

INSERT INTO sample62 -- 이거 생략하면 culumn명 서순대로 작성해야한다
VALUES(100, '띠용', NOW())
;

INSERT INTO sample62
VALUES(12, '암욜맨', '2017-07-06') -- 
;

SELECT * FROM sample62;

-- 티아카데미 자유게시판을 테이블로 만들어보기 연습
-- 글번호, 종류, 타이틀, 이름, 커멘트숫자
-- 외부 작성일, 내부 작성일, 조횟수
-- 내용, 댓글id, 댓글내용



CREATE TABLE IF NOT EXISTS freeboard(
	num INTEGER,				/* 글번호 */
	category Integer,			/* 카테고리종류 */
	title VARCHAR(25),		/* 글제목 */
	userid VARCHAR(50),		/* 작성자id */
	numofcomments INTEGER,	/* 코멘트 숫자 */
	pubdate DATETIME,			/* 작성일시 */
	viewcount INTEGER,			/* 조회수 */
	context TEXT,				/* 글 본문 */
	keyword varChar(15),		/* 키워드 */
	ipnum VARCHAR(16)			/* ip */
);

CREATE TABLE IF NOT EXISTS cmtboard(
	cmtpubdate datetime,		/* 작성일시 */
	cmtid varChar(12),		/* 작성자id */
	cmtcontxt VARCHAR(200), /* 코멘트 본문 */
	ipnum VARCHAR(16)			/* ip */
);


-- -----------------------------------
-- 회원가입 창
-- 이름, 아이디, 닉네임, 비번, 비번 재입력
-- 생년월일, 이메일, 이멜수신여부, 통신사, 폰번호, 인증번호
-- sms수신여부

DROP TABLE IF EXISTS signupboard;
CREATE TABLE IF NOT EXISTS signupboard(
	name varChar(10) NOT NULL,
	userid varChar(50) NOT NULL,
	username varChar(10) NOT NULL,
	pswd varChar(20) NOT NULL,
	psw_ensure varChar(20) NOT NULL,
	birthday date NOT NULL,
	email varChar(255) NOT NULL,
	newsletterchk Integer(1),
	phonetype Integer(1) NOT NULL,
	phonenumber Integer NOT NULL,
	verifynumber Integer(6) NOT NULL,
	smsrcvchk Integer(1),
	ipnum varChar(16) NOT NULL
);

-- --------------------------------------
-- 다음 회원가입창
-- 아이디, 비번, 재확인, 폰번호, 인증번호입력
-- 본인ㅇ확인 메일주소

CREATE TABLE IF NOT EXISTS signupboard_daum(
	daumid varChar(20) NOT NULL,
	pswd varChar(20) NOT NULL,
	psw_ensure varChar(20) NOT NULL,
	name varChar(10) NOT NULL,
	phonenumber Integer NOT NULL,
	verifynumber Integer(5) NOT NULL,
	veryfyemail varChar(255) NOT NULL
);


-- -----------------------------------------
-- 구글 회원가입
-- 성, 이름, username, 비번, 비번확인,
-- 생년월일, gender, phone#, current email address, nationality

CREATE TABLE IF NOT EXISTS signupboard_google(
	lastname varChar(20) NOT NULL,
	firstname varChar(20) NOT NULL,
	psw varChar(20) NOT NULL,
	psw_ensure varChar(20) NOT NULL,
	birthday date NOT NULL
	gender Integer(1)DEFAULT 0,
	phonenumber Integer NOT NULL,
	current_email varChar(255),
	locale Integer(3) NOT NULL
);


CREATE TABLE IF NOT EXISTS board2_cafe(
	boardname varChar(20) NOT NULL,
	boardindex Integer(5) NOT NULL,
	article_id Integer NOT NULL,
	title varChar(40) NOT NULL,
	cmtCount Integer NOT NULL,
	username varChar(15) NOT NULL,
	pubdate datetime NOT NULL,
	viewcnt Integer NOT NULL,
	comtent Text
);

CREATE TABLE IF NOT EXISTS cmtboard_cafe(
	username varChar(15) NOT NULL,
	context Text NOT NULL,
	myemote Integer(4),
	mysticker Integer,
	imgurl varChar(255)
);


-- ---------------------------------------------------------

DROP TABLE IF EXISTS sample62;

DESC cmtboard_cafe;

insert into cmtboard_cafe values('ddf', '3fc', 11, 1, ' ');

SELECT * FROM cmtboard_cafe;

TRUNCATE TABLE cmtboard_cafe;

DROP TABLE IF EXISTS sample62;

CREATE TABLE IF NOT EXISTS sample62(
	num INTEGER NOT NULL DEFAULT 0,
	name varChar(10) NOT NULL DEFAULT 'guest',
	idate datetime NOT NULL DEFAULT NOW()
);

INSERT INTO
	sample62
VALUES
('333', '2414123')
;

INSERT INTO
	sample62(num)
VALUES
	(555)
;

INSERT INTO sample62(num, name)
VALUES(33, 'ㅇㄹㅇㄹ')
;

SELECT * FROM sample62;


-- ---------------------- 테이블 수정 -------------------------------

-- sample65
-- num:숫자
-- a: vachar default 'aaa'
-- idate: datetime default now()

DROP TABLE IF EXISTS sample63;
CREATE TABLE IF NOT EXISTS sample63(
	num Integer,
	a varChar(20) DEFAULT 'JOHN CENA', /* 입려않을시 디폴트가 존씨나 */
	idate datetime DEFAULT NOW() /* db의 시간을 입력(디폴트) */
);

INSERT INTO
	sample63(num)
VALUES
	(33)
;

INSERT INTO sample63(num, a, idate) VALUES (7, 'john1', now());
INSERT INTO sample63(num, a, idate) VALUES (78, 'john2', now());
INSERT INTO sample63(num, a, idate) VALUES (77, 'john3', now());
INSERT INTO sample63(num, a, idate) VALUES (47, 'john4', now());
INSERT INTO sample63(num, a, idate) VALUES (567, 'john5', now());
INSERT INTO sample63(num, a, idate) VALUES (27, 'john6', now());

SELECT * FROM sample63;

-- ----- ALTER로 테이블 구조를 변경해보자

ALTER TABLE sample63 ADD id varChar(30); -- 컬럼하나를 추가하는거마냥 된다 

DESC sample63;

ALTER TABLE sample63 ADD c varChar(30) DEFAULT 'U CANT C ME';
-- ADD는 이름이 똑같아선 안된다
-- 이렇게 하면 기존에있던 레코드들에 값이 들어가있다

ALTER TABLE sample63 
MODIFY a varChar(3); -- modify는 이미 입력이 완료된 컬럼의 속성을
		-- 수정하려하는 경우 기존값을 검색한후 그릇된 속성이면(이미있는
		-- 문자보다 작다던가) 에러를 듸운다
		-- 참고로 오라클은 이렇게 하면 3자리까지만 남겨두고 나머지는
		-- 다 짤라버린다 ㄷㄷ
;

-- 얘넨 다 file에저장되ㅡㄴ거 알지?

ALTER TABLE sample63 MODIFY num VARCHAR(10);

DESC sample63;
SELECT * FROM sample63;

ALTER TABLE sample63 MODIFY a INTEGER; -- 기존값이 NULL이면 된다

ALTER TABLE sample63 MODIFY id INTEGER;

-- column 삭제 테이블이아니다 it's column!!! ---
-- 내용이 있는 column 지워보자
ALTER TABLE sample63 DROP c; -- 내용 있어도 바로 없어졌다! (기존 내용도 함께 지워짐)

-- 우린 이제 
-- 테이블 만들주알고 crud할줄알고 
-- column cud할줄알고 그렇지?
-- 자바랑 연동하는건 내일한대!













