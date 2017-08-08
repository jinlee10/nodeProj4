/**
 * 
 */

var express = require('express');
var router = express.Router();
//body parser가 잇어야한다multer도
const bodyParser = require('body-parser');
const multer  = require('multer');



//const app = express();







router.use(bodyParser.urlencoded({ extended: false }));
 
// 최근 추세가 모발쪽에선 json을 그대로 쏘고받는경우가 늘었다함

// parse application/json //만약에 상대방이 나한테 json타입보내면
router.use(bodyParser.json());

//multer 저장되는 폴더 및이름바꿔
var storage = multer.diskStorage({
	  destination: function (req, file, cb) {
	    cb(null, '/uploads1');
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
 

















router.post('/write', function(req, res){
	var title = req.body.title;
	console.log('읽어온 타이틀: ' + title);
	res.send('make a write page!: ' + title); //여기에 db가들가고 해야겟지
});

router.post('/update', function(req, res){
	res.send('make a update page'); 
});

router.get('/delete', function(req, res){
	res.send('make a delete page'); 
});

router.get('/list', function(req, res){
	res.send('make a list page');
});



module.exports = router;


