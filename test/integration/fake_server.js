/*
###################################
# FAKE SERVER FOR AWS S3 SIMULATION
#
# Written in javascript for node
###################################
*/
var express = require('express');
var cors = require('cors');

function log(req, res, next) {
  console.log("called");
  console.log(req.headers);
  next();
}
var app = express();

var corsOptions = {origin: 'http://localhost:3000', credentials: true};
app.use(cors(corsOptions));

app.use(function (req,res,next) {
  console.log("called2");
  next();
});

app.options('*',cors(corsOptions)); 
app.get('*', function(req, res, next){
  res.send('hello world');
});

app.post('*', log, function(req, res, next) {
  res.send(200);
});

app.listen(8088);
