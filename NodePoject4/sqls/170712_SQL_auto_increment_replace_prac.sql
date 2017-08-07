DROP DATABASE community;
CREATE DATABASE community;

use community;

-- 멤버테이블 : 뭐뭐뭐뭐뭐
-- 게시판 테이블: 어쩌저쩌
-- 댓글 테이블: 왈왈왈왈
-- 좋아요 테이블: 얼럴럴럴러

-- 멤버테이블 : cnt, id, pw, signupdate, idate, signupip, deviceinfo
-- 게시판테이블: cnt, authorid(fri), title, text, likeid, cmtid, idate, ip
-- 댓글테이블: cntid, boardcnt(fri), authorid(fri), text, idate, ip
-- 좋아요 테이블: cntid, boardid(fri), authorid(fri), idate, ip
/*
drop table decodetest;
create table decodetest(
	pwd blob
);
select * from decodetest;

insert into decodetest values(encode('aaa', 'gadgetzan')); -- encapsulation
select pwd from decodetest;
select pwd, decode(pwd, 'tacademy') from decodetest;			-- 가장 기초적 보안*/
DROP TABLE IF EXISTS member;
CREATE TABLE IF NOT EXISTS member(
	usrnum int not null default 0,
	usrid varchar(14) not null,
	usrname varchar(20) not null,
	usrpwd varchar(15) not null,
	idate datetime default now(),
	ip varchar(20) not null,
	constraint pri_mem_username primary key(usrid)
);

insert into member(usrnum, usrid, usrpwd, usrname, ip)
	values(1, 'abc', '1234', '존씨나1', '210.219.32.42');

insert into member(usrnum, usrid, usrpwd, usrname, ip)
	values(2, 'abcd', '2234', '존씨나2', '210.219.32.43');

insert into member(usrnum, usrid, usrpwd, usrname, ip)
	values(3, 'abce', '3234', '존씨나3', '210.219.32.44');

select max(usrnum) + 1 from member;

insert into member(usrnum, usrid, usrpwd, usrname, ip)
	values((SELECT num FROM ( select max(usrnum) + 1 num from member) numT), -- 마! 현업가면 다 이래 쓴다!
		'abcac', '1234f', '존씨나', '210.219.32.55');

SELECT num FROM ( select max(usrnum) + 1 num from member) numT;		-- 얘를 인라인뷰로만든거얄


SELECT * FROM member;

-- //////// 이런식으로 하고 auto_increment안쓴다 //////// --
-- insert된 구문은 순서가없으므로 갖다쓸때 반드시 order by 해줘야된다


-- 게시판테이블
DROP TABLE IF EXISTS board;
CREATE TABLE IF NOT EXISTS board(
	brdnum int AUTO_INCREMENT,
	brdid varchar(14) not null,
	brdtitle varchar(40) not null,
	brdtext text(15) not null,
	idate datetime default now(),
	ip varchar(20) not null,
	constraint pri_baord_id primary key(brdnum), -- 안드가서 맨첨보는 레이아웃이 constraint일거래~ 제약이 잇군!
	CONSTRAINT fri_board_member_id FOREIGN KEY(brdid) REFERENCES member(usrid) -- 잊지말자구!
);

SELECT * FROM board;

-- 안드등 다른 디바이스의 경우 맥어드레스 얻어서 pri key삼거나 하나봄~
insert into board(brdid, brdtitle, brdtext, ip) 
	VALUES('abc', 'title551', 'text551', '192.168.0.2');		
	
insert into board(brdid, brdtitle, brdtext, ip) 
	VALUES('abc', 'title441', 'text441', '192.168.0.33');		
	
insert into board(brdid, brdtitle, brdtext, ip) 
	VALUES('abc', 'title331', 'text331', '192.168.0.44');		
	
insert into board(brdid, brdtitle, brdtext, ip) 
	VALUES('abc', 'title1222', 'text122', '192.168.0.55');		
	
insert into board(brdid, brdtitle, brdtext, ip) 
	VALUES('abc', 'title111', 'text111', '192.168.0.66');		


-- 댓글테이블

DROP TABLE IF EXISTS comments;
CREATE TABLE IF NOT EXISTS comments(
	cmtnum int AUTO_INCREMENT,
	brdnum int NOT NULL,
	cmtid varchar(14) not null,
	cmttext varchar(200) not null,
	idate datetime default now(),
	ip varchar(20) not null,
	constraint pri_cmd_num primary key(cmtnum),
	constraint fri_cmt_writer_id1 FOREIGN KEY(cmtid) REFERENCES member(usrid),
	constraint fri_brdnum_board_brdnum FOREIGN KEY(brdnum) REFERENCES board(brdnum)
);

-- 글번호에 해당하는 댓글만 불러오기
SELECT * FROM comments WHERE brdnum = 3;	-- java서 연동할떈 얘만 바꾸면되죠?(뒤에3)
-- 글번호에 대핟ㅇ하는 댓글 수
SELECT count(*) cnt FROM comments WHERE brdnum = 3; -- 함수썼으면 뒤에 alias!!!
SELECT * FROM board;

-- 글 불러오면서 글의 댓글수도 함게 출력하는 select
SELECT
	board.*, COUNT(comments.brdnum) cmt_cnt
FROM
	board  join comments
	on board.brdnum = comments.brdnum
GROUP BY
	board.brdnum
;

-- 썜풀아ㅣ
SELECT
	b.*, IFNULL(r.cnt, 0) cnt -- 댓글 null인놈들 처리해줘야지
FROM
	board b left join -- 댓글 없는놈들도 나와야되기 때문에
					(select brdnum, count(*) cnt from comments GROUP BY brdnum) r
on b.brdnum = r.brdnum
ORDER BY
	--	b.idate DESC -- 혹은 brdnum 내림차순
	b.brdnum DESC
;

-- 보편적으로 게시판 쓰게되면 최신글들이 먼저오지? boardnum에따른 
-- 내림차순되거나 idate에따른 내림차순에 따라 내려주는게 좋다

desc comments;

insert into comments(brdnum, cmtid, cmttext, ip)
	values(3, 'abce', '홀롤롤롤롤로', '192.168.205.1');

insert into comments(brdnum, cmtid, cmttext, ip)
	values(4, 'abcc', '홀롤롤롤롤로2', '192.168.205.12');

insert into comments(brdnum, cmtid, cmttext, ip)
	values(5, 'abce', '홀롤롤롤롤로3', '192.168.205.13');

insert into comments(brdnum, cmtid, cmttext, ip)
	values(5, 'abcd', '홀롤롤롤롤로4', '192.168.205.14');

insert into comments(brdnum, cmtid, cmttext, ip)
	values(6, 'abcd', '홀롤롤롤롤로5', '192.168.205.51');

insert into comments(brdnum, cmtid, cmttext, ip)
	values(7, 'abc', '홀롤롤롤롤로6', '192.168.205.51');

insert into comments(brdnum, cmtid, cmttext, ip)
	values(7, 'abcd', '홀롤롤롤롤로7', '192.168.205.15');

insert into comments(brdnum, cmtid, cmttext, ip)
	values(7, 'abc', '홀롤롤롤롤로8', '192.168.205.12');

insert into comments(brdnum, cmtid, cmttext, ip)
	values(4, 'abcd', '홀롤롤롤롤로9', '192.168.205.12');

insert into comments(brdnum, cmtid, cmttext, ip)
	values(3, 'abce', '홀롤롤롤롤로10', '192.168.205.12');

insert into comments(brdnum, cmtid, cmttext, ip)
	values(5, 'abc', '홀롤롤롤롤로11', '192.168.205.12');

insert into comments(brdnum, cmtid, cmttext, ip)
	values(5, 'abcd', '홀롤롤롤롤로12', '192.168.205.12');

insert into comments(brdnum, cmtid, cmttext, ip)
	values(5, 'abce', '홀롤롤롤롤로13', '192.168.205.12');

insert into comments(brdnum, cmtid, cmttext, ip)
	values(5, 'abcac', '홀롤롤롤롤로14', '192.168.205.12');


SELECT * FROM comments;




-- 따봉 테이블: num, 멤버id, 게시판 num, idate, ip

DROP TABLE IF EXISTS ddabong_brd;
CREATE TABLE IF NOT EXISTS ddabong_brd(
	ddanum int AUTO_INCREMENT,
	brdnum int NOT NULL,
	ddaid varchar(14) not null,
	idate datetime default now(),
	ip varchar(20) not null,
	constraint pri_brdddabong_id primary key(ddanum),
	constraint fri_ddabong_brd_writer_id2
		FOREIGN KEY(ddaid) REFERENCES member(usrid),
	constraint fri_ddabong_brd_board_brdnum 
		FOREIGN KEY(brdnum) REFERENCES board(brdnum)
);

desc ddabong_brd;

-- 보드정도는 짰으면좋겠음....`openapi만사용하지말고` 양쪽다...

insert into ddabong_brd(brdnum, ddaid, ip)
	values(3, 'abce', '192.168.33.90');

insert into ddabong_brd(brdnum, ddaid, ip)
	values(4, 'abcd', '192.168.33.90');

insert into ddabong_brd(brdnum, ddaid, ip)
	values(6, 'abce', '192.168.33.90');

insert into ddabong_brd(brdnum, ddaid, ip)
	values(6, 'abce', '192.168.33.90');

insert into ddabong_brd(brdnum, ddaid, ip)
	values(7, 'abce', '192.168.33.90');

insert into ddabong_brd(brdnum, ddaid, ip)
	values(3, 'abc', '192.168.33.90');

insert into ddabong_brd(brdnum, ddaid, ip)
	values(6, 'abc', '192.168.33.90');

insert into ddabong_brd(brdnum, ddaid, ip)
	values(6, 'abc', '192.168.33.90');

SELECT * FROM ddabong_brd;

SELECT brdnum, COUNT(brdnum) cnt
FROM ddabong_brd
GROUP BY brdnum;

-- 멤버테이ㅂㄹ하고 조인해서 글불러오기, 댓글보기, like보기, 좋아요한사람 이름
-- 10기도 사실 좋아요 구현한사람(리스트) 얼마안댐

SELECT 
	d.brdnum, m.*
FROM
	ddabong_brd d inner join member m
	on d.ddaid = m.usrid
WHERE
	d.brdnum = 7
;

-- 글별 댓글수와 좋아요 수 구하기

-- 썜풀이
SELECT
	b.*, IFNULL(r.cnt, 0) rcnt, IFNULL(ddabong_cnt, 0) dcnt-- 댓글 null인놈들 처리해줘야지
FROM
	board b 
	LEFT JOIN -- 댓글 없는놈들도 나와야되기 때문에
		(select 
			brdnum, count(*) cnt 
		from 
			comments 
		GROUP BY 
			brdnum
		) r
		
ON b.brdnum = r.brdnum
	LEFT JOIN
	(
		SELECT
			brdnum, COUNT(*) ddabong_cnt
		FROM
			comments
		GROUP BY
			brdnum
	) d
	
ON	b.brdnum = d.brdnum
ORDER BY
	d.brdnum DESC
;

--	b.idate DESC -- 혹은 brdnum 내림차순


