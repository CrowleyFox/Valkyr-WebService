var express = require('express');
var app = express();

var mysql      = require('mysql');

app.get('/', function(req, res){
	var connection = mysql.createConnection({
		host     : 'localhost',
		user     : 'root',
		password : '1234',
		database : 'valkyr'
	});

	connection.connect();

	connection.query('SELECT * from pessoa where pessoaid in (1,4)', function (error, results, fields) {
	  if (error) throw error;
	  connection.end();
	  res.json(results);
	});
});

app.get('/login', function(req, res){
	var connection = mysql.createConnection({
		host     : 'localhost',
		user     : 'root',
		password : '1234',
		database : 'valkyr'
	});

	var login = req.body;
	var sqlQuery = 'select * from usuario where usuarioLogin = \' ' + connection.escape(login.usuarioLogin) +
	' \' and usuarioSenha = \' ' + connection.escape(login.usuarioSenha) + ' \';'
	connection.connect();

	connection.query(sqlQuery, function (error, results, fields){
		if (error) throw error;
		connection.end();
		
		var obj = {
			token : '',
			result : results[0]
		};

		res.json(results);
	});
});

app.listen(3000);