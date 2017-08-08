/**
 * 
 */



const mysql      = require('mysql');

var dao = function(){}


dao.prototype.login = function(id, pw, cb){
	console.log('login');
	
	var connection = mysql.createConnection({
		host     : '192.168.205.170',
		user     : 'root',
		password : '1234',
		database : 'tacademy'
	});
	
	connection.connect();
	
	connection.query('SELECT name, email FROM member where id = ? and pw = ?', 
			[id, pw], function (err, results, fields) {
		if (err){
			console.log('err: ' + err);
		}
		cb(err, results);
	});
	
	connection.end();
}


module.exports = new dao();


