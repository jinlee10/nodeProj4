
// ◈====================================================◈
// 		17. 8. 8. Node!
// ◈====================================================◈


// =======================================================
// require들
// =======================================================
const path = require('path');
const moment = require('moment');
const express = require('express');
const bodyParser = require('body-parser');
const multer  = require('multer');
const errorHandler = require('express-error-handler');
const cookieParser = require('cookie-parser');
const session = require('express-session');

const dao = require('./dao/memberdao');
const boarddao = require('./dao/boarddao');
//const board = require('./board');	//라우터가 반환됨(module.exports했었잖어~)

const app = express();

app.moment = moment;
 

//ejs
//정적인건 public, 여깄는걸 거치고나서 만둘곳이다
app.set('views', __dirname + '/views1'); 
app.set('view engine', 'ejs');
console.log('뷰 엔진이 EEjs로 설정되었습니다 ');


// ========================================================
// middleware ( == 주입하다 라는 용어가 자주 쓰인다)
// ========================================================
app.use(express.static(path.join(__dirname, 'public1')));
app.use('/images', express.static(path.join(__dirname, 'uploads1')));
app.use(cookieParser()); //함수가 리턴되고 우린 함수를 생성해서 넘겨주고 해야되겠지

// 세션 주입
app.use(session({
  secret: 'bird is love', //내맘
  resave: true,
  saveUninitialized: true,
//  cookie: { secure: true }
}))


app.use(bodyParser.urlencoded({ extended: false }))
 
// 최근 추세가 모발쪽에선 json을 그대로 쏘고받는경우가 늘었다함

// parse application/json //만약에 상대방이 나한테 json타입보내면
app.use(bodyParser.json()) //얘가 json객체 반환해서 알아서 객체화시켜준다



//multer 저장되는 폴더 및이름바꿔
var storage = multer.diskStorage({
	  destination: function (req, file, cb) {
	    cb(null, './uploads1');
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
 


//=====================================================
// routing ///////
//=====================================================

app.get('/', function (req, res) {
	  res.send('hello, world 170808');
	});


// post routing
app.post('/login', function(req, res){
	//입력시 오류검출(클라)는 나중에 알아서 처리해보셈
	var id = req.body.id;
	var pw = req.body.pw;
	//거름망
	if(!id || !pw){
		res.redirect('/login.html');
		return;
	}
	
	/////// dao 로그인 /id/pw 객체ㅏㄴ달ㅇ ㄴ
	dao.login(id, pw, function(err, results){
		if(err){
			res.render('p500', {err : err});
		}
		if(results.length == 0){
			res.redirect('/login.html');
			return;
		}else{ //세션필터를 이용했을것이므로 넣어놓자SSSsss
			req.session.name = results[0].name;
			req.session.email = results[0].email;
			res.redirect('membera');
			return;
		}
	});
	
	// DB연동 ~~~~~~~~~~~~~~~~~~~~~~
	
	
});

//멤버페이지A
app.get('/membera', function(req, res){
	
	if(!req.session.name){
		res.redirect('/login.html');
		return;
	}
	var user = {
			name : req.session.name,
			email : req.session.email
	};
	res.render('membera', { user : user});
});

//멤버페이지B
app.get('/memberb', function(req, res){
	
	if(!req.session.name){
		res.redirect('/login.html');
		return;
	}
	
	var user = {
			name : req.session.name,
			email : req.session.email
	};
	res.render('memberb', { user : user});
});

app.get('/logout', function(req, res){
	if(!req.session.name){
		console.log('이미 세션이 존재하지 않는다');
		res.redirect('/');
		return;
	}
	req.session.destroy(function(err){
		if(err){
			console.log('err: ' + err);
			
		}
		//객체없에기: finalize or destroy많이나온다
		console.log('req.session destroyed!SSSsss');
		
		//로그아웃했으면 다시 로그인 페이지로 가자
		res.redirect('/login.html');
		return;
	});

});

// JSON 전송(최근 모바일 쪽에서 바로 json을 쏘고받는 추세)
// bodyParserjson있어야된다
app.post('/loginJson', function(req, res){
	var obj = req.body; //body가 json객체로 날라올것이야
	
	//json보낼때 double quotation(" ")으로 문자열 싸야됨
	
	var id = req.body.id;
	var pw = req.body.pw;
	res.json('login post id: ' + id + ', pw: ' + pw);
});


//
//app.get('membera');, function(req, res){
//	if(!req.session.name){
//		res.redirect());
//	}
//	var user = {nano)
//	'
//	}
//});

// DB연동과 세션

// 페이지 3개 만든다
// ㅁ , ㅁ ㅁ
// 로그인 1, 회원 전용 페이지 2
// 이럴때 세션이 이용도니다
// 로그인 페이지는 정적 ==> public1



// -- ============ =========== -- ---------- ===========
// 점심먹고 4교시
// ===== ---------- =================== ------------ ===

// +----------+----------------+------+----------------+
//	얘네 대체할거야
// +----------+----------------+------+----------------+
//app.use('/board', board);	// /board 로 시작하는놈들은 다 일루와! 하고 빼서 이 주소로 따로 관리해주겠다
//app.use('/member', member);
//app.use('/member', member);	//이런식으로 라우팅 짧아지게....

//DB 라우팅 잘르니깐 러닝 빨라진건 아니지만 여기가 짧아졌지
//쪼개자!
//
//app.post('/board/write', function(req, res){
//	res.send('make a write page'); //여기에 db가들가고 해야겟지
//});
//
//app.post('/board/update', function(req, res){
//	res.send('make a update page'); 
//});
//
//app.get('/board/delete', function(req, res){
//	res.send('make a delete page'); 
//});
//
//app.get('/board/list', function(req, res){
//	res.send('make a list page');
//});

// +----------+----------------+------+----------------+
// 5교시
app.post('/board/write', upload.single('img'), function(req, res){
	var title= req.body.title;
	var author = req.body.author;
	var fname = '';
	var content = req.body.content
	if(req.file){
		fname = req.file.filename;
	}
	//IQ추적 들어오기전에 제대로 처리하기
	var iq = req.ip;
	var idx = iq.lastIndexOf(':');
	iq = iq.substring(idx + 1);
	
	
	console.dir(req.file);
	var boardObj = {
		title : title, //앞에껀 이름 뒤에껀 변수명
		author : author,
		content : content,
		ip : iq,
		img : fname
	};
	
	//DB에 Insert하기 dao
	boarddao.insert_board(boardObj, function(state){
		//얘가 실질적 업무 다하고 콜백던져줘야하느놈
		//모바일 서버라면 이부분이 json이어야된다
//		var s = (state ? 'success' : 'fail');
//		var obj = {
//				"state" : s 	//모바일은 이렇게해라!
//		}
//		res.json(obj);
		
		//웹은 뭔가 하면 무적권(오타아님ㅎ) 뭔가 실패성공에
		//상관없이 페이지를 보여줘야되는데
		//모바일은 전혀 다르다
		
//		res.send('insert ' + (state ? 'succeess' : 'failed'));

		//사실상 성공실패 여부 페이지가 아니라
		//목록으로 이동을 해야되잖어!
		
		res.redirect('/board/list');
		return;
	});
	
});


app.get('/board/list', function(req, res){
	//db로 목록불러와얌마
	boarddao.select_all(function(err, results){
		//검색하세되면  나중에 저기 ()에 처리할것(이름, 페이지 등
		//인자같은것들)
		
		if(err){
			res.render('p500', {err : 'server extremely busy!'});
			return;
		}
		
		//실제 목록이 있다면
		//html문서로 생성하여 보내줘야곘제
		res.render('boardlist', {list : results, moment : moment}); //객체가 전달된다
		
	}); 
});

//상세읽기(pri key로 잡은 글번호가 있따면..?)
//app.post()
app.get('/board/read', function(req, res){
	var num = req.query.num;
	//db로 요청해서 콜백처리해라
	boarddao.read_article(num, function(err, results){
		//검색하세되면  나중에 저기 ()에 처리할것(이름, 페이지 등
		//인자같은것들)
		
		if(err){
			res.render('p500', {err : 'server extremely busy!'});
			return;
		}
		console.dir(results);
		//실제 목록이 있다면
		//html문서로 생성하여 보내줘야곘제
		res.render('boardthread', {board : results[0], moment : moment}); //객체가 전달된다
		
	});
});


//여러개면?
//app.post('/board/write', upload.single('img'), function(req, res){
//	var title= req.body.title;
//	var file = req.files;
//	res.send('send write title: ' + title);
//});




//======================================================
//500번 오류처리
//======================================================
app.use(function (err, req, res, next) {
	console.log(err);
	// ejs만들어서 ㄱㄱ
	res.render('p500', {err : 'Server very busy.'});
});

//======================================================
//404 express error handler
//======================================================
handler = errorHandler({
	  static: {
	    '404': './public1/nfound.html'
	  }
	});

//use로 미들웨어 추가설치
app.use( errorHandler.httpError(404) );
app.use( handler );




/////// LISTEN //////////////////////////////////
app.listen(80, function () {
console.log('Example app listening on port 80!!!!!');
});

