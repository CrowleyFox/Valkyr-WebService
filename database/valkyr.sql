# Host: localhost  (Version 5.6.39-log)
# Date: 2018-04-24 22:26:19
# Generator: MySQL-Front 6.0  (Build 2.20)


#
# Structure for table "chat_mensagem"
#
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `chat_mensagem`;
CREATE TABLE `chat_mensagem` (
  `chat_mensagemId` int(11) NOT NULL AUTO_INCREMENT,
  `chatId` int(11) NOT NULL DEFAULT '0',
  `chat_mensagemConteudo` varchar(500) NOT NULL DEFAULT '',
  `chat_mensagemDataEnvio` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `chat_mensagemDataRecebimento` datetime DEFAULT NULL,
  `chat_mensagemVisualizada` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = Visualizada, 0 = Não Visualizada',
  `chat_mensagemRemetente` int(11) NOT NULL DEFAULT '0',
  `chat_mensagemDestinatario` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`chat_mensagemId`),
  KEY `FK_Chat_Mensagem_ChatId` (`chatId`),
  CONSTRAINT `FK_Chat_Mensagem_ChatId` FOREIGN KEY (`chatId`) REFERENCES `chat` (`chatId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Data for table "chat_mensagem"
#

INSERT INTO `chat_mensagem` VALUES (1,1,'Eae man blz? Fez a atividade lá do Fábio?','2018-04-10 10:18:00','2018-04-10 10:20:00',1,1,2),(2,1,'Rapaz, e se eu te disse que nem lembrava kkkk? Vo ver se faço hoje.','2018-04-10 10:25:00','2018-04-10 10:25:05',0,2,1),(3,2,'Professor, me tira uma dúvida. Arduino é com A ou com H?','2018-04-12 15:00:00','2018-04-12 15:00:06',1,3,4),(4,2,'É com A Sr. Marcos.','2018-04-12 15:10:12','2018-04-12 15:10:18',1,4,3);

#
# Structure for table "forma_pagamento"
#

DROP TABLE IF EXISTS `forma_pagamento`;
CREATE TABLE `forma_pagamento` (
  `forma_pagamentoId` int(11) NOT NULL AUTO_INCREMENT,
  `forma_pagamentoDescricao` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`forma_pagamentoId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#
# Data for table "forma_pagamento"
#

INSERT INTO `forma_pagamento` VALUES (1,'DINHEIRO'),(2,'CHEQUE'),(3,'BOLETO'),(4,'CARTÃO DE CRÉDITO'),(5,'CARTÃO DE DÉBITO');

#
# Structure for table "lancamento_categoria"
#

DROP TABLE IF EXISTS `lancamento_categoria`;
CREATE TABLE `lancamento_categoria` (
  `lancamento_categoriaId` int(11) NOT NULL AUTO_INCREMENT,
  `lancamento_categoriaDescricao` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`lancamento_categoriaId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Data for table "lancamento_categoria"
#

INSERT INTO `lancamento_categoria` VALUES (1,'MENSALIDADE'),(2,'ACORDO'),(3,'FIES');

#
# Structure for table "matricula_status"
#

DROP TABLE IF EXISTS `matricula_status`;
CREATE TABLE `matricula_status` (
  `matricula_statusId` int(11) NOT NULL AUTO_INCREMENT,
  `matricula_statusDescricao` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`matricula_statusId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#
# Data for table "matricula_status"
#

INSERT INTO `matricula_status` VALUES (1,'ATIVA'),(2,'INATIVA'),(3,'TRANCADA'),(4,'DEVEDORA'),(5,'CONCLIÍDA');

#
# Structure for table "pessoa"
#

DROP TABLE IF EXISTS `pessoa`;
CREATE TABLE `pessoa` (
  `pessoaId` int(11) NOT NULL AUTO_INCREMENT,
  `pessoaTipo` char(2) NOT NULL DEFAULT '' COMMENT 'A = Aluno, F = Funcionario, P = Professor, AF = Aluno e Funcionario, AP = Aluno e Professor e por ai vai.',
  `pessoaNome` varchar(20) NOT NULL DEFAULT '',
  `pessoaSobrenome` varchar(60) NOT NULL DEFAULT '',
  `pessoaCPF` varchar(12) NOT NULL DEFAULT '',
  `pessoaRG` varchar(11) DEFAULT NULL,
  `pessoaSexo` char(1) NOT NULL DEFAULT '',
  `pessoaDataNascimento` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`pessoaId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Data for table "pessoa"
#

INSERT INTO `pessoa` VALUES (1,'A','DIEGO','LIMA','39288877714','474616528','M','1996-02-14'),(2,'A','LUCAS','BUENO','12345678901',NULL,'M','0000-00-00'),(3,'A','MARCOS','PAULO','10987654321',NULL,'M','0000-00-00'),(4,'P','FABIO','VERSOLATTO','12345698710',NULL,'M','0000-00-00');

#
# Structure for table "lancamento"
#

DROP TABLE IF EXISTS `lancamento`;
CREATE TABLE `lancamento` (
  `lancamentoId` int(11) NOT NULL AUTO_INCREMENT,
  `pessoaId` int(11) NOT NULL DEFAULT '0',
  `lancamento_categoriaId` int(11) NOT NULL DEFAULT '0',
  `forma_pagamentoId` int(11) NOT NULL DEFAULT '0',
  `lancamentoData` date NOT NULL DEFAULT '0000-00-00',
  `lancamentoValorLancado` decimal(10,2) DEFAULT '0.00',
  `lancamentoVencimentoOriginal` date NOT NULL DEFAULT '0000-00-00',
  `lancamentoVencimentoAtual` date NOT NULL DEFAULT '0000-00-00',
  `lancamentoValorPago` decimal(10,2) NOT NULL DEFAULT '0.00',
  `lancamentoValorCreditado` decimal(10,2) NOT NULL DEFAULT '0.00',
  `lancamentoDataPagamento` date DEFAULT NULL,
  PRIMARY KEY (`lancamentoId`),
  KEY `FK_Lancamento_PessoaId` (`pessoaId`),
  KEY `FK_Lancamento_Lancamento_CategoriaId` (`lancamento_categoriaId`),
  KEY `FK_Lancamento_Forma_PagamentoId` (`forma_pagamentoId`),
  CONSTRAINT `FK_Lancamento_Forma_PagamentoId` FOREIGN KEY (`forma_pagamentoId`) REFERENCES `forma_pagamento` (`forma_pagamentoId`),
  CONSTRAINT `FK_Lancamento_Lancamento_CategoriaId` FOREIGN KEY (`lancamento_categoriaId`) REFERENCES `lancamento_categoria` (`lancamento_categoriaId`),
  CONSTRAINT `FK_Lancamento_PessoaId` FOREIGN KEY (`pessoaId`) REFERENCES `pessoa` (`pessoaId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Aqui vão os lançamentos financeiros das mensalidades dos alunos.';

#
# Data for table "lancamento"
#

INSERT INTO `lancamento` VALUES (1,1,1,3,'2018-04-10',854.56,'2018-04-20','2018-04-20',854.56,854.56,'2018-04-16'),(2,3,1,4,'2018-04-10',427.28,'2018-04-20','2018-04-20',0.00,0.00,NULL);

#
# Structure for table "endereco"
#

DROP TABLE IF EXISTS `endereco`;
CREATE TABLE `endereco` (
  `enderecoId` int(11) NOT NULL AUTO_INCREMENT,
  `pessoaId` int(11) NOT NULL DEFAULT '0',
  `enderecoLogradouro` varchar(150) NOT NULL DEFAULT '' COMMENT 'Rua Tal, Av. Tal, Viela Tal, etc',
  `enderecoNumero` varchar(8) DEFAULT NULL,
  `enderecoComplemento` varchar(20) DEFAULT NULL,
  `enderecoBairro` varchar(30) NOT NULL DEFAULT '',
  `enderecoCidade` varchar(50) NOT NULL DEFAULT '',
  `enderecoUF` char(2) NOT NULL DEFAULT '' COMMENT 'Estado',
  `enderecoCEP` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`enderecoId`),
  KEY `FK_Endereco_PessoaId` (`pessoaId`),
  CONSTRAINT `FK_Endereco_PessoaId` FOREIGN KEY (`pessoaId`) REFERENCES `pessoa` (`pessoaId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Data for table "endereco"
#

INSERT INTO `endereco` VALUES (1,1,'RUA UNIVERSAL','988',NULL,'PIRAPORINHA','DIADEMA','SP','09950874'),(2,2,'AV. DAS PEDALEIRAS','1200','CASA A','BAIRRO DOS CASA','SÃO BERNARDO DO CAMPO','SP','54478941'),(3,3,'BECO DOS SEM CABEÇA','666','CASA DE TAIPA B','CORTE DA COLINA','MAUÁ','SP','00021231');

#
# Structure for table "curso"
#

DROP TABLE IF EXISTS `curso`;
CREATE TABLE `curso` (
  `cursoId` int(11) NOT NULL AUTO_INCREMENT,
  `coordenadorId` int(11) NOT NULL DEFAULT '0',
  `cursoNome` varchar(60) NOT NULL DEFAULT '',
  `cursoDescricao` varchar(2048) DEFAULT NULL,
  `cursoConteudo` blob COMMENT 'Neste campo vai um texto formatado em HTML, então aqui ficará o texto com as devidas TAGs.',
  `cursoQtdeSemestres` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cursoId`),
  KEY `FK_Curso_PessoaId` (`coordenadorId`),
  CONSTRAINT `FK_Curso_PessoaId` FOREIGN KEY (`coordenadorId`) REFERENCES `pessoa` (`pessoaId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Data for table "curso"
#

INSERT INTO `curso` VALUES (1,4,'ANÁLISE E DESENVOLVIMENTO DE SISTEMAS','CURSO FOCADO NA ANÁLISE DE SISTEMAS DESKTOP E WEB.',X'3C48333E53D320434F4E5445DA444F20444F20424F4D2050524120564F43CA20534149522050524F4752414D414E444F20494755414C20554D20444F49444F3C2F68333E',5);

#
# Structure for table "modulo"
#

DROP TABLE IF EXISTS `modulo`;
CREATE TABLE `modulo` (
  `moduloId` int(11) NOT NULL AUTO_INCREMENT,
  `cursoId` int(11) NOT NULL DEFAULT '0',
  `moduloNome` varchar(100) NOT NULL DEFAULT '',
  `moduloDescricao` varchar(512) DEFAULT NULL,
  `moduloCargaHoraria` int(4) NOT NULL DEFAULT '0' COMMENT '11 = 11 horas, 150 = 150 horas, etc',
  `moduloSemestre` int(1) DEFAULT NULL,
  PRIMARY KEY (`moduloId`),
  KEY `FK_Modulo_CursoId` (`cursoId`),
  CONSTRAINT `FK_Modulo_CursoId` FOREIGN KEY (`cursoId`) REFERENCES `curso` (`cursoId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Data for table "modulo"
#

INSERT INTO `modulo` VALUES (1,1,'DESENVOLVIMENTO MÓVEL E EMBARCADO','VAI APRENDER ANDROID E ARDUINO.',90,1),(2,1,'DESENVOLVIMENTO AVANÇADO','VAI APRENDER A ENCONTRAR BRECHAS DE SEGURANÇAS PARA VOCÊ VIRAR UM HACKERMAN',80,1);

#
# Structure for table "curso_modulo"
#

DROP TABLE IF EXISTS `curso_modulo`;
CREATE TABLE `curso_modulo` (
  `curso_moduloId` int(11) NOT NULL AUTO_INCREMENT,
  `cursoId` int(11) NOT NULL DEFAULT '0',
  `moduloId` int(11) NOT NULL DEFAULT '0',
  `curxo_moduloSemestre` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`curso_moduloId`),
  KEY `FK_Curxo_Modulo_CursoId` (`cursoId`),
  KEY `FK_Curxo_Modulo_ModuloId` (`moduloId`),
  CONSTRAINT `FK_Curxo_Modulo_CursoId` FOREIGN KEY (`cursoId`) REFERENCES `curso` (`cursoId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Curxo_Modulo_ModuloId` FOREIGN KEY (`moduloId`) REFERENCES `modulo` (`moduloId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Data for table "curso_modulo"
#

INSERT INTO `curso_modulo` VALUES (1,1,1,1),(2,1,2,1);

#
# Structure for table "contato"
#

DROP TABLE IF EXISTS `contato`;
CREATE TABLE `contato` (
  `contatoId` int(11) NOT NULL AUTO_INCREMENT,
  `pessoaId` int(11) NOT NULL DEFAULT '0',
  `contatoTipo` char(1) NOT NULL DEFAULT '' COMMENT 'T = Telefone, C = Celular, E = E-mail, F = Fax, O = Outro',
  `contatoConteudo` varchar(40) DEFAULT NULL COMMENT 'Neste campo você coloca o conteúdo do tipo do contato que definiu.',
  PRIMARY KEY (`contatoId`),
  KEY `FK_Contato_PessoaId` (`pessoaId`),
  CONSTRAINT `FK_Contato_PessoaId` FOREIGN KEY (`pessoaId`) REFERENCES `pessoa` (`pessoaId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Data for table "contato"
#

INSERT INTO `contato` VALUES (1,1,'T','1140758478'),(2,2,'C','11954547899'),(3,3,'C','11954123215'),(4,4,'E','fabio.versolatto@metodista.com.br');

#
# Structure for table "chat"
#

DROP TABLE IF EXISTS `chat`;
CREATE TABLE `chat` (
  `chatId` int(11) NOT NULL AUTO_INCREMENT,
  `chatRemetenteId` int(11) NOT NULL DEFAULT '0',
  `chatDestinatarioId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`chatId`),
  KEY `FK_Chat_Remetente_PessoaId` (`chatRemetenteId`),
  KEY `FK_Chat_Destinatario_PessoaId` (`chatDestinatarioId`),
  CONSTRAINT `FK_Chat_Destinatario_PessoaId` FOREIGN KEY (`chatDestinatarioId`) REFERENCES `pessoa` (`pessoaId`),
  CONSTRAINT `FK_Chat_Remetente_PessoaId` FOREIGN KEY (`chatRemetenteId`) REFERENCES `pessoa` (`pessoaId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Data for table "chat"
#

INSERT INTO `chat` VALUES (1,1,2),(2,3,4);

#
# Structure for table "turma"
#

DROP TABLE IF EXISTS `turma`;
CREATE TABLE `turma` (
  `turmaId` int(11) NOT NULL AUTO_INCREMENT,
  `cursoId` int(11) NOT NULL DEFAULT '0',
  `turmaDescricao` varchar(15) NOT NULL DEFAULT '',
  `turmaSemestre` char(1) NOT NULL DEFAULT '' COMMENT '1 = 1º Semestre, 2 = 2º Semestre, etc',
  `turmaPeriodo` char(1) NOT NULL DEFAULT '' COMMENT 'M = Matutino, V = Vespertino e N = Noturno',
  PRIMARY KEY (`turmaId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Data for table "turma"
#

INSERT INTO `turma` VALUES (1,1,'ADS5','5','N'),(2,1,'ADS1','1','M'),(3,1,'ADS3','3','V');

#
# Structure for table "matricula"
#

DROP TABLE IF EXISTS `matricula`;
CREATE TABLE `matricula` (
  `matriculaId` int(11) NOT NULL AUTO_INCREMENT,
  `pessoaId` int(11) NOT NULL DEFAULT '0',
  `cursoId` int(11) NOT NULL DEFAULT '0',
  `turmaId` int(11) NOT NULL DEFAULT '0',
  `matriculaData` date NOT NULL DEFAULT '0000-00-00' COMMENT 'Data que foi realizada a matrícula.',
  `matricula_statusId` int(11) NOT NULL DEFAULT '0' COMMENT 'Veja a tabela matricula_status.',
  `matriculaSemestre` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`matriculaId`),
  KEY `FK_Matricula_PessoaId` (`pessoaId`),
  KEY `FK_Matricula_TurmaId` (`turmaId`),
  KEY `FK_Matricula_Matricula_StatusId` (`matricula_statusId`),
  KEY `FK_Matricula_CursoId` (`cursoId`),
  CONSTRAINT `FK_Matricula_CursoId` FOREIGN KEY (`cursoId`) REFERENCES `curso` (`cursoId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Matricula_Matricula_StatusId` FOREIGN KEY (`matricula_statusId`) REFERENCES `matricula_status` (`matricula_statusId`),
  CONSTRAINT `FK_Matricula_PessoaId` FOREIGN KEY (`pessoaId`) REFERENCES `pessoa` (`pessoaId`),
  CONSTRAINT `FK_Matricula_TurmaId` FOREIGN KEY (`turmaId`) REFERENCES `turma` (`turmaId`)
) ENGINE=InnoDB AUTO_INCREMENT=263433 DEFAULT CHARSET=utf8;

#
# Data for table "matricula"
#

INSERT INTO `matricula` VALUES (263250,2,1,1,'2016-01-14',1,1),(263432,1,1,1,'2016-01-15',1,1);

#
# Structure for table "cronograma_aula"
#

DROP TABLE IF EXISTS `cronograma_aula`;
CREATE TABLE `cronograma_aula` (
  `cronograma_aulaId` int(11) NOT NULL AUTO_INCREMENT,
  `cronograma_aulaProfessorId` int(11) NOT NULL DEFAULT '0',
  `turmaId` int(11) NOT NULL DEFAULT '0',
  `moduloId` int(11) NOT NULL DEFAULT '0',
  `cronograma_aulaSala` varchar(8) DEFAULT NULL,
  `cronograma_aulaData` date DEFAULT NULL COMMENT 'Data da aula.',
  `cronograma_aulaTitulo` varchar(50) NOT NULL DEFAULT '',
  `cronograma_aulaDescricao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cronograma_aulaId`),
  KEY `FK_Cronograma_Aula_PessoaId` (`cronograma_aulaProfessorId`),
  KEY `FK_Cronograma_Aula_TurmaId` (`turmaId`),
  KEY `FK_Cronograma_Aula_ModuloID` (`moduloId`),
  CONSTRAINT `FK_Cronograma_Aula_ModuloID` FOREIGN KEY (`moduloId`) REFERENCES `modulo` (`moduloId`),
  CONSTRAINT `FK_Cronograma_Aula_PessoaId` FOREIGN KEY (`cronograma_aulaProfessorId`) REFERENCES `pessoa` (`pessoaId`),
  CONSTRAINT `FK_Cronograma_Aula_TurmaId` FOREIGN KEY (`turmaId`) REFERENCES `turma` (`turmaId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Data for table "cronograma_aula"
#

INSERT INTO `cronograma_aula` VALUES (1,4,1,1,'D-217','2018-04-20','AULA SOBRE ALGUMA COSIA','VOCÊS APRENDERÃO ALGO'),(2,4,1,2,'L-433','2018-04-25','AULA SOBRE GIT','VOCÊ VERÃO GIT');

#
# Structure for table "material"
#

DROP TABLE IF EXISTS `material`;
CREATE TABLE `material` (
  `materialId` int(11) NOT NULL AUTO_INCREMENT,
  `cronograma_aulaId` int(11) NOT NULL DEFAULT '0',
  `materialArquivoId` bigint(15) NOT NULL DEFAULT '0' COMMENT 'Este campo é formado pelos seguintes códigos: PessoaId + TarefaId + Data (somente Nº. Ex: 263432120180410',
  `materialArquivoNome` varchar(256) NOT NULL DEFAULT '',
  `materialArquivoExt` varchar(5) DEFAULT NULL,
  `materialArquivoDataEnvio` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`materialId`),
  KEY `FK_Material_Cronograma_AulaId` (`cronograma_aulaId`),
  CONSTRAINT `FK_Material_Cronograma_AulaId` FOREIGN KEY (`cronograma_aulaId`) REFERENCES `cronograma_aula` (`cronograma_aulaId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Material que o professor utilzia para complementar a aula.';

#
# Data for table "material"
#

INSERT INTO `material` VALUES (1,1,4120180410,'apresentação','pdf','2018-04-05');

#
# Structure for table "tarefa"
#

DROP TABLE IF EXISTS `tarefa`;
CREATE TABLE `tarefa` (
  `tarefaId` int(11) NOT NULL AUTO_INCREMENT,
  `materialId` int(11) NOT NULL DEFAULT '0',
  `cronograma_aulaId` int(11) NOT NULL DEFAULT '0',
  `tarefaTitulo` varchar(40) NOT NULL DEFAULT '',
  `tarefaDescricao` blob COMMENT 'Texto em HTML.',
  `tarefaDataInicio` date NOT NULL DEFAULT '0000-00-00',
  `tarefaDataEntrega` date DEFAULT NULL,
  `tarefaNotaPeso` int(3) NOT NULL DEFAULT '0' COMMENT 'O peso da ntoa da tarefa é em porcentagem, ou seja, 10 = 10% da nota total do módulo.',
  `tarefaNotaValor` decimal(4,2) DEFAULT NULL COMMENT 'Comprimento é 4 e possui duas casa decimais, ou se, 2 digitos inteiros e 2 decimais.',
  PRIMARY KEY (`tarefaId`),
  KEY `FK_Tarefa_Cronograma_AulaId` (`cronograma_aulaId`),
  KEY `FK_Tarefa_MaterialId` (`materialId`),
  CONSTRAINT `FK_Tarefa_Cronograma_AulaId` FOREIGN KEY (`cronograma_aulaId`) REFERENCES `cronograma_aula` (`cronograma_aulaId`),
  CONSTRAINT `FK_Tarefa_MaterialId` FOREIGN KEY (`materialId`) REFERENCES `material` (`materialId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Data for table "tarefa"
#

INSERT INTO `tarefa` VALUES (1,1,1,'INTRODUÇÃO A DESENVOLVIMENTO',X'3C423E444553454E564F4C5641204120435552412050415241204F2043C24E4345523C2F423E','2018-04-20','2018-04-25',10,1.00),(2,1,2,'GIT E GITHUB',X'4749542045204749544855426E','2018-04-25','2018-04-30',30,NULL);

#
# Structure for table "nota"
#

DROP TABLE IF EXISTS `nota`;
CREATE TABLE `nota` (
  `notaId` int(11) NOT NULL AUTO_INCREMENT,
  `tarefaId` int(11) NOT NULL DEFAULT '0',
  `notaAlunoId` int(11) NOT NULL DEFAULT '0',
  `notaValor` decimal(4,2) DEFAULT NULL COMMENT 'Comprimento é 4 e possui duas casa decimais, ou se, 2 digitos inteiros e 2 decimais.',
  PRIMARY KEY (`notaId`),
  KEY `FK_Nota_TarefaId` (`tarefaId`),
  KEY `FK_Nota_PessoaId` (`notaAlunoId`),
  CONSTRAINT `FK_Nota_PessoaId` FOREIGN KEY (`notaAlunoId`) REFERENCES `pessoa` (`pessoaId`),
  CONSTRAINT `FK_Nota_TarefaId` FOREIGN KEY (`tarefaId`) REFERENCES `tarefa` (`tarefaId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Data for table "nota"
#

INSERT INTO `nota` VALUES (1,1,3,7.25),(2,1,1,7.00),(3,1,1,7.20);

#
# Structure for table "tarefa_arquivo"
#

DROP TABLE IF EXISTS `tarefa_arquivo`;
CREATE TABLE `tarefa_arquivo` (
  `tarefa_arquivoId` int(11) NOT NULL AUTO_INCREMENT,
  `tarefaId` int(11) NOT NULL DEFAULT '0',
  `tarefa_arquivoAlunoId` int(11) NOT NULL DEFAULT '0',
  `tarefa_arquivoArquivoId` bigint(15) DEFAULT NULL COMMENT 'Este campo é formado pelos seguintes códigos: PessoaId + TarefaId + Data (somente Nº. Ex: 263432120180410',
  `tarefa_arquivoArquivoNome` varchar(256) DEFAULT NULL,
  `tarefa_arquivoArquivoExt` varchar(5) DEFAULT NULL,
  `tarefa_arquivoDataEnvio` date DEFAULT NULL,
  PRIMARY KEY (`tarefa_arquivoId`),
  KEY `FK_Tarefa_Arquivo_PessoasId` (`tarefa_arquivoAlunoId`),
  KEY `FK_Tarefa_Arquivo_TarefaId` (`tarefaId`),
  CONSTRAINT `FK_Tarefa_Arquivo_PessoasId` FOREIGN KEY (`tarefa_arquivoAlunoId`) REFERENCES `pessoa` (`pessoaId`),
  CONSTRAINT `FK_Tarefa_Arquivo_TarefaId` FOREIGN KEY (`tarefaId`) REFERENCES `tarefa` (`tarefaId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Esta tabela será responsável por armazenar os arquivos que os alunos enviam para entregar as tarefas.';

#
# Data for table "tarefa_arquivo"
#

INSERT INTO `tarefa_arquivo` VALUES (1,1,2,2120180422,'CódigoFonte','pdf','2018-04-22'),(2,2,2,0,NULL,NULL,NULL);

#
# Structure for table "lista_presenca"
#

DROP TABLE IF EXISTS `lista_presenca`;
CREATE TABLE `lista_presenca` (
  `lista_presencaId` int(11) NOT NULL AUTO_INCREMENT,
  `cronograma_aulaId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`lista_presencaId`),
  KEY `FK_Lista_Presenca_Cronograma_AulaId` (`cronograma_aulaId`),
  CONSTRAINT `FK_Lista_Presenca_Cronograma_AulaId` FOREIGN KEY (`cronograma_aulaId`) REFERENCES `cronograma_aula` (`cronograma_aulaId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Data for table "lista_presenca"
#

INSERT INTO `lista_presenca` VALUES (1,1);

#
# Structure for table "lista_presenca_aluno"
#

DROP TABLE IF EXISTS `lista_presenca_aluno`;
CREATE TABLE `lista_presenca_aluno` (
  `lista_presenca_alunoId` int(11) NOT NULL AUTO_INCREMENT,
  `lista_presencaId` int(11) NOT NULL DEFAULT '0',
  `moduloId` int(11) NOT NULL DEFAULT '0',
  `lista_presenca_alunoAlunoId` int(11) NOT NULL DEFAULT '0',
  `lista_presenca_alunoSituacao` char(1) NOT NULL DEFAULT '' COMMENT 'P = Presente e A = Ausente',
  PRIMARY KEY (`lista_presenca_alunoId`),
  KEY `FK_Lista_Presenca_Aluno_Lista_PresencaId` (`lista_presencaId`),
  KEY `FK_Lista_Presenca_Aluno_PessoaId` (`lista_presenca_alunoAlunoId`),
  KEY `FK_Lista_Presenca_Aluno_ModuloId` (`moduloId`),
  CONSTRAINT `FK_Lista_Presenca_Aluno_Lista_PresencaId` FOREIGN KEY (`lista_presencaId`) REFERENCES `lista_presenca` (`lista_presencaId`),
  CONSTRAINT `FK_Lista_Presenca_Aluno_ModuloId` FOREIGN KEY (`moduloId`) REFERENCES `modulo` (`moduloId`),
  CONSTRAINT `FK_Lista_Presenca_Aluno_PessoaId` FOREIGN KEY (`lista_presenca_alunoAlunoId`) REFERENCES `pessoa` (`pessoaId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Data for table "lista_presenca_aluno"
#

INSERT INTO `lista_presenca_aluno` VALUES (1,1,1,1,'P'),(2,1,2,2,'A'),(3,1,1,3,'P'),(4,1,1,2,'P'),(5,1,1,2,'A');

#
# Structure for table "mensagem"
#

DROP TABLE IF EXISTS `mensagem`;
CREATE TABLE `mensagem` (
  `mensagemId` int(11) NOT NULL AUTO_INCREMENT,
  `turmaId` int(11) NOT NULL DEFAULT '0',
  `mensagemConteudo` blob COMMENT 'Conteúdo da mensagem em HTML.',
  `mensagemRemetenteId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mensagemId`),
  KEY `FK_Mensagem_TurmaId` (`turmaId`),
  KEY `FK_Mensagem_PessoaId` (`mensagemRemetenteId`),
  CONSTRAINT `FK_Mensagem_PessoaId` FOREIGN KEY (`mensagemRemetenteId`) REFERENCES `pessoa` (`pessoaId`),
  CONSTRAINT `FK_Mensagem_TurmaId` FOREIGN KEY (`turmaId`) REFERENCES `turma` (`turmaId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Mensagens e comunicados que a Universidade enviará para os alunos.';

#
# Data for table "mensagem"
#

INSERT INTO `mensagem` VALUES (1,1,X'3C5354524F4E473E564F43CA53204EC34F2054454D2041554C412E3C2F5354524F4E473E',4);

#
# Structure for table "usuario"
#

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `usuarioId` int(11) NOT NULL AUTO_INCREMENT,
  `pessoaId` int(11) NOT NULL DEFAULT '0',
  `usuarioLogin` varchar(30) NOT NULL DEFAULT '',
  `usuarioSenha` varchar(9) NOT NULL DEFAULT '',
  `usuarioAdmin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = Sim, 0 = Não',
  PRIMARY KEY (`usuarioId`),
  KEY `FK_Usuario_PessoaID` (`pessoaId`),
  CONSTRAINT `FK_Usuario_PessoaID` FOREIGN KEY (`pessoaId`) REFERENCES `pessoa` (`pessoaId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Data for table "usuario"
#

INSERT INTO `usuario` VALUES (1,1,'DIEGO.LIMA','123',0),(2,2,'LUCAS.BUENO','312',0),(3,3,'MARCOS.PAULO','222',1),(4,4,'FABIO.VERSOLATTO','333',0);
SET FOREIGN_KEY_CHECKS = 1;