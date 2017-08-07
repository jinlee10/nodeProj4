-- transaction

SELECT @@autocommit;	-- 자동화된값을가졌다

use sample;

SELECT @@autocommit;

SET autocommit = false;

SELECT @@autocommit;

-- table이름 comtest
-- num, name
CREATE TABLE comtest(
	num integer,
	name varchar(10)
);

insert into comtest
	values(1, 'kim');
	
insert into comtest
	values(2, 'lee');


commit;

insert into comtest
	values(3, 'kim');
	
insert into comtest
	values(4, 'lee');

CREATE table abcdef(a integer);

select * from comtest;
insert into comtest values(5, 'lee3');
insert into comtest values(6, 'kimkim');

rollback;

delete from comtest;