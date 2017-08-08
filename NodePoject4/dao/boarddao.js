/**
 * 
 */



const mysql      = require('mysql');

var boarddao = function(){}

// ==========================================================
//	INSERT
// ==========================================================
boarddao.prototype.insert_board = function(board, cb){
	console.log('board');
	
	var connection = mysql.createConnection({
		host     : '192.168.205.170',
		user     : 'root',
		password : '1234',
		database : 'tacademy'
	});
	
	connection.connect();
	
	connection.query('INSERT INTO board(title, author, content, ip, img) VALUES (?, ?, ?, ?, ?)', 
			[board.title, board.author ,
			 board.content, board.ip, board.img,], 
			 function (err, results, fields) {
		if (err){
			console.log('err: ' + err);
			cb(0);	//에러면 던지고 끝내라
			return;
		}
		var state = 0;
		if(results.affectedRows == 1){
			state = 1;
		}
		cb(state);
	});
	
	connection.end();
}

//==========================================================
//	SELECT - ALL
//==========================================================
boarddao.prototype.select_all = function(cb){//인자로 콜백
	console.log('list board예제');
	var connection = mysql.createConnection({
		host     : '192.168.205.170',
		user     : 'root',
		password : '1234',
		database : 'tacademy'
	});
	
	connection.connect();
	
	connection.query('SELECT * FROM board ORDER BY num DESC',//최신순 
			function (err, results, fields) {
		if (err){
			console.log('err: ' + err);
		}
		//query문 실행된 결과를 콜백함수로 호출해준다
		cb(err, results);
	});
	
	connection.end();
}



//==========================================================
//	SELECT - ONE
//==========================================================
boarddao.prototype.read_article = function(num, cb){//인자로 콜백
	console.log('list board예제');
	var connection = mysql.createConnection({
		host     : '192.168.205.170',
		user     : 'root',
		password : '1234',
		database : 'tacademy'
	});
	
	connection.connect();
	
	connection.query('SELECT * FROM board WHERE num = ?', [num], 
			function (err, results, fields) {
		if (err){
			console.log('err: ' + err);
		}
		//query문 실행된 결과를 콜백함수로 호출해준다
		cb(err, results);
	});
	
	connection.end();
}



module.exports = new boarddao();


