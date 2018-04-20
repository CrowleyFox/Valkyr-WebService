var express = require('express');
var app = express();

var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : '2205',
  database : 'valkyr'
});



app.get('/', function(req, res){
	connection.connect();

	connection.query('SELECT * from pessoa', function (error, results, fields) {
	  if (error) throw error;
	  connection.end();
	  res.json(results);
	});
});


app.get('/professor', function())

app.listen(3000);