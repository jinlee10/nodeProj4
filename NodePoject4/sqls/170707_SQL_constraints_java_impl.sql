-- 192.168.205.198 --
-- uid/pw/port(3306) 도 알아야 later java에 implement

-- 17.7.7

-- 0) 접속하자마자 db를 선태간다
use sample;

-- 머릿속에잇다고 걍하지말구 나중에 sql문서 볼 사람들 생각해서write em down!!!!

-- table sa
-- num: 숫자(자동으로 인덱스 맺어지게)
-- name: 문자, not null
-- idate: datetime - default가 current date and time
-- ip4: varChar(15byte)누가 조회했는지 db담당자가 알아야하므로(time and ip알면 찾을수있따) == ipv4
-- 이젠 ipv6도 고려를 해야한당 ( MODIFY보단 하나더 ADD하자. 엥간하면 모딮이 하지말것! 차라리 add another column)
-- ip6:varChar(50?)
-- 모든 db는 날짜시간과 ip를 반드시 가져야한다 -- 고로케 설계하자

CREATE TABLE IF NOT EXISTS sa(
	num Integer, /* AUTO_INCREMENT: primary keyd잇어야대고 오로지 Integer에만붙는다! varchar char ㄴㄴ */
	name varChar(12) NOT NULL, /* ()에 # 안잡아주면 넘나크게잡혀서 용량 많이잡아먹... */
	idate datetime DEFAULT CURRENT_TIMESTAMP not null,
	ipv4 varChar(15),
	ipv6 varChar(50)
);
SELECT * FROM sa;

INSERT INTO	sa(num, name, ipv4)VALUES (0, 'JOHN CENA1', '192.108.205.0');	 -- 갯수와 타입을 매핑(맞춰)해야됨
INSERT INTO	sa(num, name, ipv4)VALUES (1, 'JOHN CENA2', '192.108.205.110');
INSERT INTO	sa(num, name, ipv4)VALUES (3, 'JOHN CENA3', '192.108.205.220');
INSERT INTO	sa(num, name, ipv4)VALUES ('hongildiong', 'JOHN CENA4', '192.108.205.240');
INSERT INTO	sa(num, name, ipv4)VALUES (16, 'JOHN CENA5', '192.108.205.90');



-- 어제 연습했던 student 객체 다시 만들기
CREATE TABLE IF NOT EXISTS student(
	num int(4) NOT NULL,
	hakbun char(8) NOT NULL,
	name varChar(120) NOT NULL,
	kor int(3) DEFAULT 0,
	eng int(3) default 0,
	mat int(3) default 0
	
);

DROP TABLE IF EXISTS student;

DESC student;	-- 다 쓰면 생략가능^^

INSERT INTO student VALUES(1, '20170010', 'JOHN CENA1', 90, 100, 80);

SELECT * FROM student;





