var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var jwt = require('jsonwebtoken');
var pool = mysql.createPool({ //Cria o pool do MySql
  host: 'localhost',
  user: 'root',
  password: '1234',
  database: 'valkyr'
});

/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('index', {
    title: 'Express'
  });
});

module.exports = router;

//Permite fazer login. Caso as credenciais estejam corretas, cria-se um token com o ID do usuario.
router.post('/login', function (req, res) {
  var userData = req.body; //Pega o json recebido e guarda na variavel.

  //Abre uma conecção com o MySql e executa a query
  pool.getConnection(function (err, connection) {
    if (err) throw err; // Joga uma exceção em caso de erro
    var sql = 'SELECT * FROM usuario WHERE usuarioLogin = ' +
      connection.escape(userData.userName) + ' AND usuarioSenha = ' +
      connection.escape(userData.userPassword) + ';'; // Query que verifica o usuario e a senha

    //Executa a query
    connection.query(sql, function (error, results, fields) {
      if (error) throw error;
      if (results != null) { //Se o results for diferente de nulo é porque tem algo nele
        //Cria o token, Primeiro eu crio o json com as informações que vieram do resultado da query e depois passo o segredo
        jwt.sign({result: results[0].usuarioId}, 'valkyrsecret', function (err, token) {
          if (err) throw err;
          //Devolvo o token em um json
          res.json({
            token: token
          })
        })
      }
    })
  })
})

router.post('/getmodulo', function (req, res) {
  var receivedToken = req.body;

  jwt.verify(receivedToken.token, 'valkyrsecret', function (err, decoded) {
    if (err) {
      res.end("Não autorizado!!!");
    }
    var sql = 'SELECT * FROM MODULO WHERE usuarioLogin = ' +
      connection.escape(userData.userName) + ' AND usuarioSenha = ' +
      connection.escape(userData.userPassword) + ';';

    connection.query(sql, function (error, results, fields) {
      if (error) throw error;
      if (results != null) {
        jwt.sign({
          result: results[0].usuarioId
        }, 'valkyrsecret', function (err, token) {
          if (err) throw err;
          res.json({
            token: token
          })
        })
      }
    })
    //res.json({result : decoded.result});
  })
})