-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ProjetoJSP
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ProjetoJSP`;
-- -----------------------------------------------------
-- Schema ProjetoJSP
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ProjetoJSP` DEFAULT CHARACTER SET utf8 ;
USE `ProjetoJSP` ;

-- -----------------------------------------------------
-- Table `ProjetoJSP`.`perfis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjetoJSP`.`perfis` (
  `idPerfil` INT NOT NULL AUTO_INCREMENT,
  `nomePerfil` VARCHAR(45) NULL,
  PRIMARY KEY (`idPerfil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjetoJSP`.`usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProjetoJSP`.`usuarios`;
CREATE TABLE IF NOT EXISTS `ProjetoJSP`.`usuarios` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(15) NULL,
  `idPerfil` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_usuarios_perfil1_idx` (`idPerfil` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_perfil1`
    FOREIGN KEY (`idPerfil`)
    REFERENCES `ProjetoJSP`.`perfis` (`idPerfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjetoJSP`.`postagens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjetoJSP`.`postagens` (
  `idPostagem` INT NOT NULL AUTO_INCREMENT,
  `postagem` TEXT NULL,
  `titulo` VARCHAR(100) NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`idPostagem`),
  INDEX `fk_postagem_usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_postagem_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `ProjetoJSP`.`usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjetoJSP`.`comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjetoJSP`.`comentarios` (
  `idComentario` INT NOT NULL AUTO_INCREMENT,
  `status` INT NULL DEFAULT 0,
  `mensagem` VARCHAR(200) NULL,
  `idPostagem` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`idComentario`),
  INDEX `fk_comentarios_postagem1_idx` (`idPostagem` ASC) VISIBLE,
  INDEX `fk_comentarios_usuarios1_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_comentarios_postagem1`
    FOREIGN KEY (`idPostagem`)
    REFERENCES `ProjetoJSP`.`postagens` (`idPostagem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentarios_usuarios1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `ProjetoJSP`.`usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


insert into perfis (nomePerfil) values ('moderador'),('comum');

Insert into usuarios (nome, email, senha, idPerfil) values ('Usuario Comum','comum@comum.com','1234', (Select idPerfil from perfis where nomePerfil = 'comum'))
															, ('Usuario Moderador','moderador@moderador.com','1234', (Select idPerfil from perfis where nomePerfil = 'moderador'));

insert into postagens (postagem, titulo, idUsuario) 
					values ('Para quem n??o sabe, biscoito ou bolacha, como voc?? preferir, se trata de um alimento muito antigo e nem sempre foi t??o gostosinho como a vers??o que conhecemos hoje em dia.\r\n\r\nConforme historiadores, esse alimento h?? muitos s??culo, quando algu??m teve a brilhante ideia de come??ar a triturar os cereais, acrescentar ??gua e assar essa mistura duas vezes para ficar bem sequinho e crocante. Com a pr??tica, al??m de mais f??cil para comer, as pessoas perceberam que os cereais duravam mais tempo e podiam ser estocados de uma forma mais f??cil.','Biscoito ou bolacha?',2)
							,('O Nokia 105 (2022) ?? um celular simples, voltado para quem quer fazer liga????es e trocar algumas mensagens. Ap??s o lan??amento no exterior, o telefone da HMD Global recebeu o seu certificado de homologa????o da Anatel (Ag??ncia Nacional de Telecomunica????es), autorizando a sua venda no Brasil. Entre os destaques, est??o o famoso jogo da cobrinha (Snake) e a bateria de longa dura????o.','Nokia 105 (2022) passa na Anatel e j?? pode ser vendido no Brasil',2)
							,('Se voc?? pensa em trocar de celular, com certeza est?? ansioso pela Black Friday. Mas, nas semanas anteriores j?? acontecem algumas ofertas bem interessantes, como essa do Samsung Galaxy S21+ por R$ 2.799,20 com cashback Ame. Esse ?? o pre??o mais baixo que j?? vimos sendo cobrado por ele, e talvez n??o abaixe muito mais que isso t??o cedo. Portanto, confira nas pr??ximas linhas como e se vale a pena aproveitar agora.','Galaxy S21+ atinge menor pre??o hist??rico em oferta com cashback generoso',2)
                            ,('?? tudo uma quest??o de nome do modelo. Veja abaixo, como saber a gera????o do processador AMD identificando as caracter??sticas marcantes e cheias de informa????es sobre o modelo do chip em cada parte dos seus extensos nomes. A sequ??ncia de n??meros que acompanha sua identifica????o n??o est?? ali ?? toa, tem sempre um prop??sito.','Como saber a gera????o do processador AMD',2)
                            ,('Para quem busca um console port??til com uma biblioteca bastante competente e variada, o Nintendo Switch Lite ?? uma op????o muito interessante. Na Amazon, o sistema na vers??o coral est?? custando R$ 1.299, um desconto de 32%, que resulta no menor pre??o j?? visto at?? ent??o. Essa ?? a melhor oportunidade para voc?? ter o videogame mais popular da Big N dos ??ltimos anos.\r\n\r\n','Nintendo Switch Lite atinge menor pre??o hist??rico em oferta na Amazon',2)
                            ,('No come??o de 2022, o Google anunciou o Play Games para PC, que leva jogos famosos do Android para desktops com Windows 10 e Windows 11. O servi??o conta com 85 t??tulos e ainda est?? em fase beta, mas temos uma boa not??cia: agora d?? para acess??-lo no Brasil.\r\nO Google Play Games foi anunciado em janeiro de 2022. Inicialmente, ele estava dispon??vel apenas para usu??rios da Coreia do Sul, Hong Kong e Taiwan. Mais tarde, Austr??lia e Tail??ndia foram adicionados ?? lista.','Google Play Games para Windows chega ao Brasil com 85 jogos de Android',2)
                            ,('God of War ?? uma das franquias mais importantes da Sony. Desde o momento em que o ???Bom de Guerra??? chegou ao PlayStation 2 em 2005, a s??rie se tornou um sucesso e recebeu muitas sequ??ncias que expandiram seu universo. Entretanto, nem todos os games seguem uma ordem direta. Conhe??a a cronologia de God of War e saiba mais sobre o universo da s??rie.','A cronologia de God of War; entenda a ordem dos jogos',2)
                            ,('Ap??s tr??s anos de vida, o Google comunicou que vai encerrar o seu servi??o de jogos em nuvem. O Stadia vai chegar oficialmente ao seu fim no dia 18 de janeiro de 2023. A partir da??, a plataforma e qualquer game adquirido pelos usu??rios n??o poder??o mais ser acessados. No entanto, a empresa prometeu um reembolso de todo o dinheiro gasto em hardware, jogos e add-ons como DLCs pelos jogadores.','Google Stadia ser?? encerrado em janeiro de 2023',2)
                            ,('Dispositivos do tipo TV box s??o o terror de canais de TV por assinatura e servi??os de streaming, certo? Certo. Mas pode n??o ser assim o tempo todo. Um estudo conduzido por pesquisadores de duas universidades dos Estados Unidos indica que aparelhos de IPTV, mesmo quando ilegais, aumentam o uso leg??timo de servi??os como Netflix e YouTube.','TV box pirata pode aumentar uso leg??timo de Netflix, sugere estudo',2)
							,('Voc?? faz apostas na Mega-Sena toda semana? Pois, saiba que n??o ?? mais preciso ir a uma Lot??rica para isso: a Caixa Econ??mica Federal lan??ou o site Loterias Online, que permite (com algumas restri????es) que qualquer pessoa maior de 18 anos, e n??o mais apenas quem ?? cliente do banco, jogue na loteria pela internet ou pelo aplicativo em todas as modalidades. Veja como apostar a seguir.','Como apostar online na Mega-Sena e outras loterias da Caixa',2)
                            ,('O pacote Office deixar?? de existir. Quer dizer, mais ou menos. A marca, uma das mais importantes da hist??ria da Microsoft, deixar?? de ser usada, tornando-se apenas Microsoft 365. ?? a primeira vez em mais de tr??s d??cadas que o Office passa por uma reformula????o t??o dr??stica. Quais ser??o os motivos por tr??s dela?','O Office morreu, mas passa bem',2);
                                                            
insert into comentarios(status,mensagem,idPostagem,idUsuario) values (0,'asdfas',21,2);




