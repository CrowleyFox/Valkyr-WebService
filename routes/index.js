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
router.post('/api/login', function (req, res) {
  var userData = req.body; //Pega o json recebido e guarda na variavel.
  //Abre uma conecção com o MySql e executa a query
  pool.getConnection(function (err, connection) {
    if (err) throw err; // Joga uma exceção em caso de erro
    var sql = 'SELECT usuarioId userId FROM usuario WHERE usuarioLogin = ' +
      connection.escape(userData.userName) + ' AND usuarioSenha = ' +
      connection.escape(userData.userPassword) + ';'; // Query que verifica o usuario e a senha
    //Executa a query
    connection.query(sql, function (error, results, fields) {
      if (error) throw error;
      if (results != null) { //Se o results for diferente de nulo é porque tem algo nele
        //Cria o token, Primeiro eu crio o json com as informações que vieram do resultado da query e depois passo o segredo
        jwt.sign({
          userId: results[0].userId
        }, 'valkyrsecret', function (err, token) {
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

router.post('/api/getmodules', function (req, res) {
  var receivedToken = req.body;
  var moduloId;
  var moduloNome;
  var cursoNome;
  var cursoId;
  var matriculaSemestre;

  jwt.verify(receivedToken.token, 'valkyrsecret', function (err, decoded) {
    if (err) {
      res.end("Forbidden!!!");
    }
    pool.getConnection(function (err, connection) {
      if (err) throw err;
      // Pega o ID e Nome do Curso
      console.log(decoded);
      var sql = 'SELECT CURSOID, CURSONOME FROM CURSO WHERE CURSOID = (SELECT CURSOID FROM MATRICULA WHERE PESSOAID = (SELECT PESSOAID FROM USUARIO WHERE USUARIOID = ' + connection.escape(decoded.userId) + '));'
      connection.query(sql, function (error, results, fields) {
        if (error) throw error;
        if (results != null) {
          cursoId = results[0].CURSOID;
          cursoNome = results[0].CURSONOME;
          // Pega o semestre da matricula
          var sql = 'SELECT MATRICULASEMESTRE FROM MATRICULA WHERE PESSOAID = (SELECT PESSOAID FROM USUARIO WHERE USUARIOID = ' + connection.escape(decoded.userId) + ');'
          connection.query(sql, function (error, results, fields) {
            console.log(results);
            if (error) throw error;
            if (results != null) {
              matriculaSemestre = results[0].MATRICULASEMESTRE;
              // Retorna o nome do curso, o nome e ID do módulo e as faltas
              var sql = 'SELECT CURSONOME courseName, LISTA_PRESENCA_ALUNO.MODULOID moduleId, MODULONOME moduloName, COUNT(LISTA_PRESENCA_ALUNOSITUACAO) absence FROM LISTA_PRESENCA_ALUNO ' +
                'INNER JOIN MODULO ON MODULO.MODULOID = LISTA_PRESENCA_ALUNO.MODULOID ' +
                'INNER JOIN CURSO ON MODULO.CURSOID = CURSO.CURSOID WHERE LISTA_PRESENCA_ALUNOALUNOID = ' +
                '(SELECT PESSOAID FROM USUARIO WHERE USUARIOID =' + connection.escape(decoded.userId) + ') AND LISTA_PRESENCA_ALUNOSITUACAO = \'A\' ' +
                ' AND MODULOSEMESTRE = ' + connection.escape(matriculaSemestre) + ' GROUP BY MODULONOME;';
              connection.query(sql, function (error, results, fields) {
                if (error) throw error;
                if (results != null) {
                  var resultModulesTasks = {
                    modules: results
                  }
                  // Devolve as tarefas
                  var sql = 'SELECT CRONOGRAMA_AULA.MODULOID moduleId, TAREFA.TAREFATITULO taskTitle, TAREFA.TAREFANOTAPESO taskGradeWeight, TAREFA.TAREFANOTAVALOR taskGradeValue FROM TAREFA_ARQUIVO ' +
                    'INNER JOIN TAREFA ON TAREFA.TAREFAID = TAREFA_ARQUIVO.TAREFAID ' +
                    'INNER JOIN CRONOGRAMA_AULA ON CRONOGRAMA_AULA.CRONOGRAMA_AULAID = TAREFA.CRONOGRAMA_AULAID ' +
                    'INNER JOIN MATRICULA ON TAREFA_ARQUIVO.TAREFA_ARQUIVOALUNOID = MATRICULA.PESSOAID ' +
                    'WHERE TAREFA_ARQUIVOALUNOID = (SELECT PESSOAID FROM USUARIO WHERE USUARIOID = ' + connection.escape(decoded.userId) + ') ' +
                    'AND MATRICULA.matriculaSemestre = ' + connection.escape(matriculaSemestre) + ' GROUP BY TAREFA.TAREFATITULO';

                  connection.query(sql, function (error, results, fields) {
                    if (error) throw error;
                    if (results != null) {
                      // Faz um append no json onde já contém os módulos.
                      resultModulesTasks.tasks = results;
                      res.json(resultModulesTasks);
                    }
                  })
                }
              })
            }
          })
        }
      })
    })
  })
})

router.post('/api/getmaterials', function (req, res) {
  var receivedToken = req.body;
  jwt.verify(receivedToken.token, 'valkyrsecret', function (err, decoded) {
    if (err) {
      res.end("Forbidden!!!");
    }
    pool.getConnection(function (err, connection) {
      if (err) throw err;
      // Pega o ID e Nome do Curso
      console.log(decoded);
      var sql = 'SELECT MATERIALARQUIVONOME materialFileName, MATERIALARQUIVOID materialFileId, MATERIALARQUIVOEXT materialFileExt FROM MATERIAL ' +
      'INNER JOIN CRONOGRAMA_AULA ON CRONOGRAMA_AULA.CRONOGRAMA_AULAID = MATERIAL.CRONOGRAMA_AULAID ' +
      'WHERE MODULOID = ' + connection.escape(receivedToken.moduleId) + ';'
      connection.query(sql, function (error, results, fields) {
        if (error) throw error;
        if (results != null) {
          res.json(results);
        }
      })
    })
  })
})

router.post('/api/gettasks', function (req, res) {
  var receivedToken = req.body;
  jwt.verify(receivedToken.token, 'valkyrsecret', function (err, decoded) {
    if (err) {
      res.end("Forbidden!!!");
    }
    pool.getConnection(function (err, connection) {
      if (err) throw err;
      // Pega o ID e Nome do Curso
      console.log(decoded);
      var sql = 'SELECT TAREFA.TAREFAID taskId, TAREFATITULO taskTitle, TAREFADESCRICAO taskDescription, PESSOANOME teacherName, MODULONOME moduleName, TAREFADATAPOSTAGEM taskPostDate, TAREFADATAENTREGA taskDeliveryLimitDate, TAREFA_ARQUIVODATAENVIO taskDeliveryDate FROM TAREFA_ARQUIVO ' +
      'INNER JOIN TAREFA ON TAREFA.TAREFAID = TAREFA_ARQUIVO.TAREFAID ' +
      'INNER JOIN CRONOGRAMA_AULA ON CRONOGRAMA_AULA.CRONOGRAMA_AULAID = TAREFA.CRONOGRAMA_AULAID ' +
      'INNER JOIN MATRICULA ON TAREFA_ARQUIVO.TAREFA_ARQUIVOALUNOID = MATRICULA.PESSOAID ' +
      'INNER JOIN MODULO ON CRONOGRAMA_AULA.MODULOID = MODULO.MODULOID ' +
      'INNER JOIN PESSOA ON PESSOA.PESSOAID = CRONOGRAMA_AULA.CRONOGRAMA_AULAPROFESSORID ' +
      'WHERE TAREFA_ARQUIVOALUNOID = (SELECT PESSOAID FROM USUARIO WHERE USUARIOID = ' + connection.escape(decoded.userId)+ ') AND MATRICULA.MATRICULASEMESTRE = (SELECT MATRICULASEMESTRE FROM MATRICULA WHERE PESSOAID = (SELECT PESSOAID FROM USUARIO WHERE USUARIOID = ' + connection.escape(decoded.userId) + '))' +
      'GROUP BY TAREFA.TAREFATITULO;';
      connection.query(sql, function (error, results, fields) {
        if (error) throw error;
        if (results != null) {
          res.json(results);
        }
      })
    })
  })
})