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
					values ('Para quem não sabe, biscoito ou bolacha, como você preferir, se trata de um alimento muito antigo e nem sempre foi tão gostosinho como a versão que conhecemos hoje em dia.\r\n\r\nConforme historiadores, esse alimento há muitos século, quando alguém teve a brilhante ideia de começar a triturar os cereais, acrescentar água e assar essa mistura duas vezes para ficar bem sequinho e crocante. Com a prática, além de mais fácil para comer, as pessoas perceberam que os cereais duravam mais tempo e podiam ser estocados de uma forma mais fácil.','Biscoito ou bolacha?',2)
							,('O Nokia 105 (2022) é um celular simples, voltado para quem quer fazer ligações e trocar algumas mensagens. Após o lançamento no exterior, o telefone da HMD Global recebeu o seu certificado de homologação da Anatel (Agência Nacional de Telecomunicações), autorizando a sua venda no Brasil. Entre os destaques, estão o famoso jogo da cobrinha (Snake) e a bateria de longa duração.','Nokia 105 (2022) passa na Anatel e já pode ser vendido no Brasil',2)
							,('Se você pensa em trocar de celular, com certeza está ansioso pela Black Friday. Mas, nas semanas anteriores já acontecem algumas ofertas bem interessantes, como essa do Samsung Galaxy S21+ por R$ 2.799,20 com cashback Ame. Esse é o preço mais baixo que já vimos sendo cobrado por ele, e talvez não abaixe muito mais que isso tão cedo. Portanto, confira nas próximas linhas como e se vale a pena aproveitar agora.','Galaxy S21+ atinge menor preço histórico em oferta com cashback generoso',2)
                            ,('É tudo uma questão de nome do modelo. Veja abaixo, como saber a geração do processador AMD identificando as características marcantes e cheias de informações sobre o modelo do chip em cada parte dos seus extensos nomes. A sequência de números que acompanha sua identificação não está ali à toa, tem sempre um propósito.','Como saber a geração do processador AMD',2)
                            ,('Para quem busca um console portátil com uma biblioteca bastante competente e variada, o Nintendo Switch Lite é uma opção muito interessante. Na Amazon, o sistema na versão coral está custando R$ 1.299, um desconto de 32%, que resulta no menor preço já visto até então. Essa é a melhor oportunidade para você ter o videogame mais popular da Big N dos últimos anos.\r\n\r\n','Nintendo Switch Lite atinge menor preço histórico em oferta na Amazon',2)
                            ,('No começo de 2022, o Google anunciou o Play Games para PC, que leva jogos famosos do Android para desktops com Windows 10 e Windows 11. O serviço conta com 85 títulos e ainda está em fase beta, mas temos uma boa notícia: agora dá para acessá-lo no Brasil.\r\nO Google Play Games foi anunciado em janeiro de 2022. Inicialmente, ele estava disponível apenas para usuários da Coreia do Sul, Hong Kong e Taiwan. Mais tarde, Austrália e Tailândia foram adicionados à lista.','Google Play Games para Windows chega ao Brasil com 85 jogos de Android',2)
                            ,('God of War é uma das franquias mais importantes da Sony. Desde o momento em que o “Bom de Guerra” chegou ao PlayStation 2 em 2005, a série se tornou um sucesso e recebeu muitas sequências que expandiram seu universo. Entretanto, nem todos os games seguem uma ordem direta. Conheça a cronologia de God of War e saiba mais sobre o universo da série.','A cronologia de God of War; entenda a ordem dos jogos',2)
                            ,('Após três anos de vida, o Google comunicou que vai encerrar o seu serviço de jogos em nuvem. O Stadia vai chegar oficialmente ao seu fim no dia 18 de janeiro de 2023. A partir daí, a plataforma e qualquer game adquirido pelos usuários não poderão mais ser acessados. No entanto, a empresa prometeu um reembolso de todo o dinheiro gasto em hardware, jogos e add-ons como DLCs pelos jogadores.','Google Stadia será encerrado em janeiro de 2023',2)
                            ,('Dispositivos do tipo TV box são o terror de canais de TV por assinatura e serviços de streaming, certo? Certo. Mas pode não ser assim o tempo todo. Um estudo conduzido por pesquisadores de duas universidades dos Estados Unidos indica que aparelhos de IPTV, mesmo quando ilegais, aumentam o uso legítimo de serviços como Netflix e YouTube.','TV box pirata pode aumentar uso legítimo de Netflix, sugere estudo',2)
							,('Você faz apostas na Mega-Sena toda semana? Pois, saiba que não é mais preciso ir a uma Lotérica para isso: a Caixa Econômica Federal lançou o site Loterias Online, que permite (com algumas restrições) que qualquer pessoa maior de 18 anos, e não mais apenas quem é cliente do banco, jogue na loteria pela internet ou pelo aplicativo em todas as modalidades. Veja como apostar a seguir.','Como apostar online na Mega-Sena e outras loterias da Caixa',2)
                            ,('O pacote Office deixará de existir. Quer dizer, mais ou menos. A marca, uma das mais importantes da história da Microsoft, deixará de ser usada, tornando-se apenas Microsoft 365. É a primeira vez em mais de três décadas que o Office passa por uma reformulação tão drástica. Quais serão os motivos por trás dela?','O Office morreu, mas passa bem',2);
                                                            
insert into comentarios(status,mensagem,idPostagem,idUsuario) values (0,'asdfas',21,2);




