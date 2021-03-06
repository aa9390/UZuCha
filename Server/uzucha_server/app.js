// app.js

// [LOAD PACKAGES]
var express     = require('express');
var app         = express();
var bodyParser  = require('body-parser');

var mongoose    = require('mongoose');

var path        = require('path');
var fs          = require('fs');
var request     = require('request');
var progress    = require('progress-stream');
var url         = require('url');
var serializer  = require('express-serializer');
var ip          = require('ip');
var multer      = require('multer');

// 변수
var mongoURL = 'mongodb://localhost:27017/UzuChaDB'
// [CONFIGURE SERVER PORT]
var port = process.env.PORT || 8091;


// [CONFIGURE mongoose ]
var db = mongoose.connection;
db.on('error', console.error);
db.once('open', function() {
    // CONNEC TED TO MONGODB SERVER
    console.log("Connected to mongod server");
});
var mongooConnection = mongoose.connect(mongoURL);

// DEFINE MODEL
var Parking = require('./models/parking')

// [CONFIGURE APP TO USE bodyParser]
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// [CONFIGURE TO USE GAIN ACCESS TO STATICS] 
app.use(express.static(path.join(__dirname, 'public')));

// SET EJS ENGINE
app.set('views', path.join(__dirname, '/views'));
app.set('view engine', 'ejs');
app.engine('html', require('ejs').renderFile);

// SET DiskStorage
var storage = multer.diskStorage({
    // set destiantion
    destination: function (req, file, cb) {
        cb(null, 'public/images')
    },
    // set file name
    filename: function (req, file, cb) {
        cb(null, file.originalname)
    }
});

// SET Upload variable
var upload = multer({ storage: storage});


// [CONFIGURE ROUTER]
var router = require('./routes')(app, Parking, db, serializer, upload);

// [RUN SERVER]
var server = app.listen(port, function(){
 console.log("Express server has started on port " + port)
 console.log(ip.address())
});