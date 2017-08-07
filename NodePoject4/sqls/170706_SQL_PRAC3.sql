-- 170706 오늘의 쿼리문 연습

-- 1. 레코드 만들기
CREATE TABLE IF NOT EXISTS student(
	num Integer(4) NOT NULL,
	hakbun char(8) NOT NULL,
	name varChar(120) NOT NULL,
	kor Integer(3) DEFAULT 0,
	eng Integer(3) DEFAULT 0,
	mat Integer(3) DEFAULT 0
);

DESC student;
SELECT * FROM student;

-- 2. 레코드 삽입하기 (7명)
INSERT INTO student VALUES(1, '20170001', '홍길동', 90, 100, 80);
INSERT INTO student VALUES(2, '20170002', '장나라', 40, 80, 50);
INSERT INTO student VALUES(3, '20170003', '임꺽정', 90, 30, 80);
INSERT INTO student VALUES(4, '20170004', '박찬호', 80, 100, 70);
INSERT INTO student VALUES(5, '20170005', '송중기', 90, 40, 80);
INSERT INTO student VALUES(6, '20170006', '이홍기', 30, 100, 90);
INSERT INTO student VALUES(7, '20170007', '김명호', 90, 90, 100);

SELECT * FROM student;

-- 3 20170003 국영수 90,90,90수정
UPDATE student SET kor = 90, eng = 90, mat = 90
WHERE hakbun = 20170003 ;

-- 4. 이홍기, 송중기 삭제
DELETE FROM student WHERE name IN ('이홍기', '송중기');

-- 5. 등급 출력하기 case when (뒤 세개는 select할떄만나오는거)
SELECT *, 
	(kor + eng + mat) total, FLOOR((kor + eng + mat) / 3) average,
	CASE FLOOR(((kor + eng + mat) / 3) / 10)
		WHEN 10 THEN 'A'
		WHEN 9 THEN 'A'
		WHEN 8 THEN 'B'
		WHEN 7 THEN 'C'
		WHEN 6 THEN 'D'
		ELSE 'F'
	END grade
FROM student;


-- 6. truncate
TRUNCATE TABLE student;

DESC student;
SELECT * FROM student;

-- 7. table delete
DROP TABLE IF EXISTS student;
SELECT * FROM student;




