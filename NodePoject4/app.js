/**
 * 
 */
const path = require('path');
const moment = require('moment');
// express
const express = require('express');
// body parser
const  bodyParser = require('body-parser');
// multer
const multer  = require('multer')
// error handler
const errorHandler = require('express-error-handler');
// cookie parser
const cookieParser = require('cookie-parser');
// express-session
const session = require('express-session');
//mysql
const mysql      = require('mysql');


const app = express();

app.moment = moment;


//ejs
//정적인건 public, 여깄는걸 거치고나서 만둘곳이다
app.set('views', __dirname + '/views'); 
app.set('view engine', 'ejs');
console.log('뷰 엔진이 EEjs로 설정되었습니다');


// ========================================================
// middleware ( == 주입하다 라는 용어가 자주 쓰인다)
// ========================================================
app.use(express.static(path.join(__dirname, 'public')));
app.use(cookieParser()); //함수가 리턴되고 우린 함수를 생성해서 넘겨주고 해야되겠지

// 세션 주입
app.use(session({
  secret: 'bird is love', //내맘
  resave: true,
  saveUninitialized: true,
//  cookie: { secure: true }
}))


app.use(bodyParser.urlencoded({ extended: false }))
 
// parse application/json 
app.use(bodyParser.json())



//multer 저장되는 폴더 및이름바꿔
var storage = multer.diskStorage({
	  destination: function (req, file, cb) {
	    cb(null, '/uploads');
	  },
	  filename: function (req, file, cb) {
		  var fname = file.originalname;
		  var idx = fname.lastIndexOf('.');
		  fname = fname.substring(0, idx)
		  			+ Date.now()
		  			+ fname.substring(idx);
	    cb(null, fname);
	  }
	})
	 
var upload = multer({ storage: storage });



// =====================================================
// routing ///////
// =====================================================
//동일 라우터에서 각각 변수를 잡고싶으면 var,
//동일 라우터에서 공용의 변수를 잡고싶으면 req.varname,
//===> 하나의 리퀘스트가 끝나서 받을때까지 유지된다
//전체 전역변수처럼 사용하고 싶으면 app.varname
// ==> 얘는 app(서버)가 동작하는동안은 계속 유지된다
// =====================================================
//가장 첫위치를 root routing이라고 한다
app.get('/', function (req, res) {
  res.send('Hello World!');
});

//동일 라우터에 여러작업 동시에 진행할 수 있음 주의
app.cnt = 0;
app.get('/pro/:member', function (req, res, next) {
	console.log('a');
	var member = req.params.member;
	
	// 뭔처리? redirect처리!
	if(member == 'guest'){
		//redirect처리
		req.member = 'guest';
		res.redirect('/guestpro');
		return;	//얘는 return 있어야한다
	}
	//리디렉트는 기억장소의 req가 다 날라간다는 개념으루다가
	// (새로운 리퀘스트) 접근해야된다.
	// 하나의 req는(요청) 하나의 요청 내에서만 왔다갔다 next로하고
	// 하는것이다. 
	// 서버에 저장되는 data의 expire date가 다르다
	// app은 서버에 있는 수~수억명이 모두 하나의 data를쓴다면?
	// app.변수 하면 되고
	// id/pw처럼 클라마다 별개루다가 하고싶어=>쿠키 / 세션
	
	// 예전에 했던 TCP/IP는 한번 connect되어 i/o 객체 되어
	// 주거니받고니 하면 계---속 유지가 되었는데
	// HTTP 를 쓰는 모든 것들은 한번 주고받으면 연결이 끊긴다
	// 그래서 엄청 많은 유저들한테 serve할수있을것이다
	
	// 기본적으로 http는 보내고 받으면 끊어버려서 같은 놈인지
	// 몰랐었다. 그래서 새롭게 나온 개념이 
	// 데이터를 저장하고있다가 같이 데이터를 보내고 받고 해주는걸루..
	// (눈에 안보이는 헤더마냥)
	// 뭘 위해? 내가 아까 그사람이라는걸 알려주기 위해
	// --------> 상태유지
	// 그 데이터를 클라(파일, 엄밀이 말하면 하드)에 저장하면 쿠키!
	// 그 데이터를 서버에 저장하면 세션!
	// 참고로 클라는 하드에 저장하므로 안날라가고
	// 서버는 메모리에 저장하기떄문에 날라간다
	
	req.member = member;	//새로 만들어지지 않을까?
	app.cnt++;
	next();
});

app.get('/pro/:member', function (req, res) {
	console.log('b');
	res.send('Hello there, ' + req.member + ' app: ' + app.cnt);
});

app.get('/pro1/', function (req, res) {
	console.log('b');
	app.cnt++;
	res.send('Hello there, ' + req.member + ' app.cnt: ' + app.cnt);
});

app.get('/guestpro', function(req, res){
	res.send('tacademy member name: ' + req.member);
});

//쿠키 파서 라우팅
app.get('/makecookies', function(req, res){
	//유저라는 이름으로 korea가 들어감
	res.cookie('user', 'hihihi', {maxAge : 1000 * 60});//1분동안 살아있으렴~
							//{maxAge : 1000 * 60 * 60 * 24} //하루
	// maxAge 안주면 저장 안하겠다는뜻인가봉가 (maxAge : 0)
	res.cookie('email', 'hihihi@hi.com');
	res.send('cookies made successfully');
	
});

app.get('/showcookies', function(req, res){
	console.dir(req.cookies);
	var output = `welcome! ${req.cookies.user}, email: ${req.cookies.email}`;
	res.send(output);
});

app.get('/deletecookies', function(req, res){
	res.clearCookie('user');
	res.redirect('/showcookies');
});
// 원래 http는 보안상 클라 하드에 접근할 수 없도록 되어있다.
// 그래서 브라우저설정에 쿠키사용안함 돼있으면 우리 예제 실행 안되었을것
// 접근 허용대신 8kb 제한 걸어 아주 작은 데이터만 저장하라고 함
// 자동로그인, id/pw 저장, 하루동안 열지않기 등에 쓰인다
// 보통은 일정시간이지나면 지워지게 되어있음

// cookie 데이터는 동일 이름에 다른값 넣으면 수정되는 개념

// 세션하자
app.get('/sessiontest', function(req, res){
	if(!req.session.cnt){
		req.session.cnt = 0;
	}
	req.session.cnt++;
	res.send('count: ' + req.session.cnt);
}); 

// 4교시 뷰 템플릿 라우팅
app.get('/sam', function(req, res){
	//이건 동적처리는 가능하지만 html쓰기가 불편했었쬬?
	var name = req.query.name;
	var email = req.query.email;
//	res.send('test name: ' + req.query.name); //dynamic page
	
	// WHAT IF
	
	// html tag처럼 표시해주고싶다?
	res.render('sam', {name : name, email : email,
		hobby : ['히오-스', '히오스', '시공의 폭풍'] //배열두됨ㅋ
	});		//.ejs파일의 name여야한다
	
	
					//왼쪽은 이름, 우측은 위에 var name
	//sam이라는 문서를 렌더링해주면서 요 객체가 넘어올거라 얘기해줌
	
});


app.get('/gugudan/:num', function(req, res){
	//파라미터 단 받아서 그 단 출력하기
	//테이블 태그루다가 반복해서 출력
	// tr td
	var num = req.params.num;
	res.render('dan', {num : num});
});

// 5교시
// 객체출력
app.get('/viewBoard/:num', function(req,res){
	var num = req.params.num;
	//DB꺼 불러오는대신
	var obj = {
		num : num,
		writer : '존 씨나',
		title : 'gol-den title',
		contents : 'U CANT C ME',
		idate : '2017-07-07 07:07',
		cnt : 223
	};
		res.render('viewBoard', {board : obj});
});



//쌤권장!
//일반 라우팅주소는 걍 써먹고
//주소만 하나 더만들어내고 그랴
// .json만 보내면 원래하던거 고치지않아도되서좋잖어
app.get('/viewBoardJson/:num', function(req,res){
	var num = req.params.num;
	//DB꺼 불러오는대신
	var obj = {
			num : num,
			writer : '존 씨나',
			title : 'gol-den title',
			contents : 'U CANT C ME',
			idate : '2017-07-07 07:07',
			cnt : 223
	};
	res.json(obj);	//obj로 보내버리기~ (js다보니 json을쉽게보내네?)
});

//원본
//app.get('/viewBoard/:num', function(req,res){
//	var num = req.params.num;
//	//DB꺼 불러오는대신
//	var obj = {
//			num : num,
//			writer : '존 씨나',
//			title : 'gol-den title',
//			contents : 'U CANT C ME',
//			idate : '2017-07-07 07:07',
//			cnt : 223
//	};
//	var type = req.query.type; //이러면 있을수도있고 없을수도있어
//	
//	//json이면 제이슨으로 쏴주고
//	if(type == 'json'){
//		res.json(obj);	//obj로 보내버리기~ (js다보니 json을쉽게보내네?)
//	}
//	else{
//		res.render('viewBoard', {board : obj});
//	}
//});




// HTTP Protocol에서
//어떤 data의 유지범위! (유효버무이)
// 어떤 data가 메모리를 차지하는 시점을 변수로 보관
//	page		|	var(제일작은 스코프)
//	request		|	한 request내에서 유효 .찍고 집어넣는방법 // 다시 접속시 새로운범위
//	session		|	사용자가 나와서 들어가고 해도 새로고침시 계속 유지되는놈
//					브라우저가 각각 창마다 다르게 인식한다(유저들마다 따로따로 할당)
//					하나의 창이 열려있는동안 session.으로 접근ok(A, B 각각 세션 잡힌다)
//					browser별로 다르기도함
//	application	|	app.cnt: 어떤 사용자든 공용으로 사용할수있다

// 필요에 의해 선택해 사용할것!


// post ... //////////////////////////////////////
// 사실 이런것들은 dao화 시켜야한다 그리고 빼놔야한다
app.post('/login', function(req, res){
	var id = req.body.id;
	var pw = req.body.pw;
	
	
//	mysql conn객체 //jdbc에서 driver connection알지?
	var connection = mysql.createConnection({
		host     : '192.168.205.163',
		user     : 'root', //db접속하는 유저명
		password : '1234',
		database : 'tacademy'	//내가만든db
	});

	connection.connect();
//	connection.query('SELECT * FROM member', function (error, results, fields) {
//	if (error) throw error;
//	console.log('async! results:', results);
//	});

//	단 하나! 도 배열로나온다dd
	console.log('3');
//	틀려도 undefined 안떨어지고 배열이 나오긴 하네
//	sql구문 틀리면 throws걸린다
	connection.query('SELECT * FROM member where id = ? and pw = ?', 
			[id, pw], function (error, results, fields) {
		// fields will contain information about the returned results fields (if any)
		console.log('4');
		console.log('id: ' + id);
		if(error){
			console.log(error);
			res.send('server very busy');
		}
		if(results.length == 0){ //실-패
			res.render('loginfail');
		}else{ //성공함
			res.render('loginsuccess', {user : results[0]});
		}
		console.log('result2: ', results);
//		console.log('fields: ' , fields);
	});
	connection.end();
});


//회우너가입처리
app.post('/memberInsert', function(req, res){
	console.log('아직 살아있다 1');
	var name = req.body.name;
	var id = req.body.id;
	var pw = req.body.pw;
	var email = req.body.email;
	console.log('아직 살아있다 2');
	
//	mysql conn객체 //jdbc에서 driver connection알지?
	var connection = mysql.createConnection({
		host     : '192.168.205.163',
		user     : 'root', //db접속하는 유저명
		password : '1234',
		database : 'tacademy'	//내가만든db
	});
	console.log('아직 살아있다 3');
	//connect하자
	connection.connect();
	console.log('아직 살아있다 4');
	
	connection.query('INSERT INTO member(name, id, pw, email) VALUES(?, ?, ?, ?);', 
			[name, id, pw, email], function (error, results, fields) {
		// fields will contain information about the returned results fields (if any)
		console.log('아직 살아있다 5');
		if(error){
			console.log(error);
			res.send('server very busy');
		}
		if(results.affectedRows == 1){
			res.send('joined successfully');
		}else{
			res.send('failed to join');
		}
		console.log('아직 살아있다 6');
		console.log('result is: ' + results);
	});
	
	connection.end();
	
});

// 회원정보 리스트 페이지 생성
app.get('/memberlist', function(req, res){
	//conn create하기
	var connection = mysql.createConnection({
		host 	 : '192.168.205.163',
		user 	 : 'root',
		password : '1234',
		database : 'tacademy'
	});
	
	connection.connect();
	
	connection.query('SELECT * FROM member', function(error, results, fields){
		if(error){
			console.log(error);
		}
		if(results.length == 0){
			res.send('회원이 없습니다!');
		}else{
			res.render('memlist', {user : results, moment : moment});
		}
		
	});
	
	connection.end();
});


// member list Json 페이지 생성
app.get('/memberlistJson', function(req, res){
	//conn create하기
	var connection = mysql.createConnection({
		host 	 : '192.168.205.163',
		user 	 : 'root',
		password : '1234',
		database : 'tacademy'
	});
	
	connection.connect();
	
	connection.query('SELECT * FROM member', function(error, results, fields){
		if(error){
			console.log(error);
		}
		if(results.length == 0){
			res.send('회원이 없습니다!');
			return;
		}
		//얌마! 여러개라서 []가 오니까 {}가 먼저오도록 담아줘야될거아니냐!
		var obj = {
			list : results
		}
		
		res.json(obj);
	});
	
	connection.end();
});

//회원정보 수정

//회원탈퇴

//회원가입


//======================================================
// 500번 오류처리
//======================================================
app.use(function (err, req, res, next) {
	console.log(err);
	res.send('Server busy');	//서버가 바쁘니다 보내기
});

//======================================================
// 404 express error handler
//======================================================
handler = errorHandler({
	  static: {
	    '404': './public/nfound.html'
	  }
	});

//use로 미들웨어 추가설치
app.use( errorHandler.httpError(404) );
app.use( handler );






/////// LISTEN //////////////////////////////////
app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});











