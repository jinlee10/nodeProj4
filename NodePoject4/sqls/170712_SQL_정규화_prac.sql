DROP DATABASE YES24;
CREATE DATABASE YES24;

use YES24;

DROP TABLE IF EXISTS pdct;
CREATE TABLE IF NOT EXISTS pdct(
	pdctid varchar(4) NOT NULL,
	pdctname varChar(30) NOT NULL,
	CONSTRAINT pri_pdct PRIMARY KEY(pdctid)
);

INSERT INTO pdct(pdctid, pdctname)
VALUES
	('0001', '톰 소여의 모험'),
	('0002', '허클베리 핀의 모험'),
	('0003', '80일간의 세계일주'),
	('0004', '동방견문록'),
	('0005', '괴테의 이탈리아 기행')
;

/*use yes24;
show tables;
SELECT * FROM pdct;*/

DROP TABLE IF EXISTS customer;
CREATE TABLE IF NOT EXISTS customer(
	custnum int NOT NULL AUTO_INCREMENT,
	custname varchar(20) NOT NULL,
	custphone varchar(14) NOT NULL,
	CONSTRAINT pri_cust PRIMARY KEY (custnum)
);

INSERT INTO customer(custname, custphone)
VALUES
	('JOHN CENA', '010-9909-9999'),
	('Bob Ross', '017-864-8946'),
	('이지영', '010-0000-0000'),
	('김민주', '010-2222-3333'),
	('t아카데미', '02-9999-8888'),
	('김정규', '010-0100-0010'),
	('이정규', '02-2222-3333')
;

show tables;
SELECT * FROM customer;
SELECT * FROM pdct;
SELECT * FROM orders;

DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders(
	ordernum int AUTO_INCREMENT,
	orderdate varchar(5) NOT NULL,
	ordercid int NOT NULL,
	CONSTRAINT pri_odnum PRIMARY KEY (ordernum),
	CONSTRAINT fri_oid FOREIGN KEY (ordercid) REFERENCES customer(custnum)
);

INSERT INTO orders(ordernum, orderdate, ordercid)
VALUES
	('JOHN CENA', '010-9909-9999'),
	('Bob Ross', '017-864-8946'),
	('이지영', '010-0000-0000'),
	('김민주', '010-2222-3333'),
	('t아카데미', '02-9999-8888'),
	('김정규', '010-0100-0010'),
	('이정규', '02-2222-3333')
;


DROP TABLE IF EXISTS bkorderlist;
CREATE TABLE IF NOT EXISTS bkorderlist(
	ordernum int NOT NULL,
	orderitmid varchar(4) NOT NULL,
	orderquantity integer(3) NOT NULL,
	CONSTRAINT fri_odnum FOREIGN KEY (ordernum) REFERENCES orders(ordernum)
);