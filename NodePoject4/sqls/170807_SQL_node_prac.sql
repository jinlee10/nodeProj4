CREATE DATABASE tacademy;
use tacademy;

-- 회원테이블
-- 번호, 이름, 아이디 ,암호, 이메일, 날짜, 카운트
-- num, name, id, pw, email, idate, cnt

CREATE TABLE member(
	num integer AUTO_INCREMENT,
	name varchar(21),
	id varchar(15),
	pw varchar(15), -- blob, encoder였나 찾아봐라,
	email varchar(30),
	idate datetime default NOW(),
	primary key (num)
);


desc member;


INSERT INTO member(name, id, pw, email) VALUES ('홍길동', 'f3f242', 'f823rvg', 'hololoo@gmail.g');
	
INSERT INTO
	member(name, id, pw, email)
VALUES	
	('탈모빔', 'aaa', '1234', '3r3r2wr@fgdg.cdf');

SELECT * FROM member;
SeLECT * FROM member where id = 'f3ef' and pw = '3f3fqagv';
SELECT * FROM member where id = 'aaa' and pw = '1234';

UPDATE member SET name = '람쥐썬더', pw = 'qwer1234' WHERE id = 'aaa';

DELETE FROM WHERE; -- 사실 딜리트도 논리삭제가 되어야한다!


-- 없데이트 테이블
create table mem_updated(
	num integer AUTO_INCREMENT,
	id varchar(15),
	pw varchar(15), -- blob, encoder였나 찾아봐라,
	email varchar(30),
	primary key(num) 
);


-- 딜리-트 테이블
create table mem_deleted(
	num integer AUTO_INCREMENT,
	name varchar(21),
	id varchar(15),
	primary key(num)
);


DESC mem_updated;
DESC mem_deleted;