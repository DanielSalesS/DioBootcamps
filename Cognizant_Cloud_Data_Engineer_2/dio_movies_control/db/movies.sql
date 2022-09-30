DROP TABLE IF EXISTS `movies`;

-- Criando a tabela movies
CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type INT,
    name VARCHAR(30) NOT NULL,
    total_ep INT,
    atual_ep INT,
    last_view DATETIME DEFAULT current_timestamp()
)

-- Inserindo dados 
INSERT INTO movies(type, name, total_ep, atual_ep)
values(0, 'The English Game', 6, 4);

INSERT INTO movies(type, name, last_view)
values (1, 'King Richard: Criando Campeãs', '2022-03-16 17:00:00');

-- Modificar um registro
UPDATE movies SET last_view = '2022-10-11'
WHERE id = 1;

-- inserindo mais dados 
INSERT INTO movies(type, name, total_ep, atual_ep)
values(0, 'The Crown', 10, 7);

INSERT INTO movies(type, name, last_view)
values (1, 'Duna', '2022-10-22 14:00:00');

insert into movies(type, name, last_view)
values (1, 'O Homem que Copiava', '2022-07-13 16:00:00');

-- Deletando um filme
DELETE FROM movies WHERE id = 4;

-- Selecionando todos
SELECT * FROM movies;