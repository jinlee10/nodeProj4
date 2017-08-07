use bookstore;

-- 고유식별을 위한 primary key 적용시켜보기

CREATE IF NOT EXISTS uerinfo(
	userid Integer NOT NULL,
	username varChar(12) NOT NULL,
	userrealname varChar(15) NOT NULL,
	userbirthday date,
	usercontactnum Integer NOT NULL,
	useraddress varChar(200) NOT NULL,
	userrank Integer(1) DEFAULT 0, -- 내부데이터?
	CONSTRAINT pkey_userinfo (userid, username)
);

CREATE IF NOT EXISTS orderinfo(
	itemid Integer NOT NULL,
	itemname varChar(60) NOT NULL,
	itemweight Integer NOT NULL,
	itemcount Integer(4) NOT NULLT DEFAULT 1,
	itempricelist Integer NOT NULL,
	itemprice Integer NOT NULL,
	itemmileage Integer NOT NULL,
	CONSTRAINT pkey_iteminfo (itemid, itemname)
);