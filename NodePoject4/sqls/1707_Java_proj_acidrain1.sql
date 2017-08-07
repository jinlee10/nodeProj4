DROP DATABASE acidrain;
CREATE DATABASE acidrain;

use acidrain;


CREATE TABLE IF NOT EXISTS wordlist(
	idx integer NOT NULL,
	word varChar(21) NOT NULL,
);

INSERT INTO
	wordlist
VALUES
	(1, '김삿갓'),
	(SELECT num FROM (SELECT MAX(idx) + 1 num FROM wordlist) numT), '따봉'),
	(SELECT num FROM (SELECT MAX(idx) + 1 num FROM wordlist) numT), '안경'),
	(SELECT num FROM (SELECT MAX(idx) + 1 num FROM wordlist) numT), '캐리어'),
	(SELECT num FROM (SELECT MAX(idx) + 1 num FROM wordlist) numT), '기상청'),
	(SELECT num FROM (SELECT MAX(idx) + 1 num FROM wordlist) numT), '구름'),
	(SELECT num FROM (SELECT MAX(idx) + 1 num FROM wordlist) numT), '하늘'),
	(SELECT num FROM (SELECT MAX(idx) + 1 num FROM wordlist) numT), '와우'),
	(SELECT num FROM (SELECT MAX(idx) + 1 num FROM wordlist) numT), '붕붕이'),
	(SELECT num FROM (SELECT MAX(idx) + 1 num FROM wordlist) numT), '따르릉'),
	(SELECT num FROM (SELECT MAX(idx) + 1 num FROM wordlist) numT), '자전거')
;

