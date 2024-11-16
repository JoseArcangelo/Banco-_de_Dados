--NOMES: Bernardo Couto Pereira e José Arcangelo

create table clientes(
cliente_id serial,
nome varchar(255),
endereco varchar(255),
cidade varchar(255),
estado char(2),
primary key(cliente_id)
);

create table Centros(
centro_id serial,
nome varchar(255),
endereco varchar(255),
cidade varchar(255),
estado char(2),
primary key(centro_id)
);

create table pedidos (
pedido_id serial,
data_pedido date,
cliente_id int,
centro_saida_id int,
centro_destino_id int,
quantidade int,
valor_total int,
primary key(pedido_id),
foreign key(cliente_id) references clientes(cliente_id)

);


create table Entregas(
entrega_id serial,
pedido_id int,
data_saida date,
data_chegada date,
quilometragem int,
primary key(entrega_id),
foreign key(pedido_id) references pedidos(pedido_id)

);


INSERT INTO clientes (nome, endereco, cidade, estado) VALUES 
('João Silva', 'Rua A, 123', 'São Paulo', 'SP'),
('Maria Oliveira', 'Avenida B, 456', 'Rio de Janeiro', 'RJ'),
('Carlos Pereira', 'Rua C, 789', 'Belo Horizonte', 'MG'),
('Ana Costa', 'Travessa D, 101', 'Curitiba', 'PR'),
('Fernanda Souza', 'Alameda E, 202', 'Porto Alegre', 'RS');

INSERT INTO Centros (nome, endereco, cidade, estado) VALUES 
('Centro Norte', 'Rua X, 12', 'São Paulo', 'SP'),
('Centro Leste', 'Avenida Y, 34', 'Rio de Janeiro', 'RJ'),
('Centro Oeste', 'Rua Z, 56', 'Belo Horizonte', 'MG'),
('Centro Sul', 'Travessa W, 78', 'Curitiba', 'PR'),
('Centro Nordeste', 'Alameda V, 90', 'Salvador', 'BA');

INSERT INTO pedidos (data_pedido, cliente_id, centro_saida_id, centro_destino_id, quantidade, valor_total) VALUES 
('2024-11-01', 1, 1, 2, 100, 5000),
('2024-11-02', 2, 3, 4, 200, 10000),
('2024-11-03', 3, 4, 1, 150, 7500),
('2024-11-04', 4, 2, 5, 250, 12500),
('2024-11-05', 5, 5, 3, 300, 15000);


INSERT INTO Entregas (pedido_id, data_saida, data_chegada, quilometragem) VALUES 
(1, '2024-11-02', '2024-11-05', 500),
(2, '2024-11-03', '2024-11-07', 1000),
(3, '2024-11-04', '2024-11-08', 750),
(4, '2024-11-05', '2024-11-10', 1250),
(5, '2024-11-06', '2024-11-12', 1500);

INSERT INTO Entregas (pedido_id, data_saida, data_chegada, quilometragem) VALUES 
(1, '2024-11-02', '2024-11-05', 500),
(2, '2024-11-03', '2024-11-07', 1000),
(3, '2024-11-04', '2024-11-08', 750),
(4, '2024-11-05', '2024-11-10', 1250),
(5, '2024-11-06', '2024-11-12', 1500);

--MODELO/DIAGRAMA: FOI IDENTIFICADO QUE VARIOS DADOS DA TABELA PEDIDOS E DA TABELA ENTREGAS SERIAM MELHOR SEREM COLOCADAS DIRETAMENTE NA TABELA DE FATOS, ENQUANTO OS DADOS DA TABELA DE CENTROS, 
--JUNTO A UMA SK E VALIDACAO FORAM ADICIONADAS A TABELA DE DIMENÇÕES dim_centros, OS DADOS DA TABELA CLIENTE FORAM ADICIONADOS A TABELA DE DIMENSÃO dim_cliente (JUNTO A UMA SK E UMA VALIDAÇÃO)
-- E A TABELA DE DIMENSÕES dim_tempo É SIMPLIFICADA EM UMA INSERÇÃO DE DATA QUE SE RELACIONA COM AS DATAS DE CHEGADA E SAIDA QUE FAZEM PARTE DA TABELA DE FATOS

-- Tabelas de dimensoes

create table dim_tempo(
data_id serial,
data_ocorrido date,
primary key(data_id)

);

create table dim_cliente(
cliente_id int,
sk int,
nome varchar(255),
endereco varchar(255),
data_registro date,
data_fim date,
validacao boolean,
primary key(cliente_id)

);


create table dim_centros(
centro_id int,
sk int,
nome varchar(255),
endereco varchar(255),
data_registro date,
cidade varchar(255),
estado char(2),
validacao boolean,
primary key(centro_id)
);

--Tabela de fatos

create table fato_Entregas(
pedido_id int,
cliente_id int,
centro_id int,
data_pedido_id int,
data_saida_id int,
data_chegada_id int,
quilometragem int,
quantidade int,
valor_total int,

primary key(pedido_id, cliente_id, centro_id),
foreign key(cliente_id) references dim_cliente(cliente_id),
foreign key(centro_id) references dim_centros(centro_id),
foreign key(data_saida_id) references dim_tempo(data_id),
foreign key(data_chegada_id) references dim_tempo(data_id)

);


--POPULANDO TABELAS dimensoes:
INSERT INTO dim_cliente (cliente_id, sk, nome, endereco, data_registro, validacao)
SELECT cliente_id, cliente_id AS sk, nome, endereco, CURRENT_DATE, TRUE
FROM clientes;

INSERT INTO dim_centros (centro_id, sk, nome, endereco, data_registro, cidade, estado, validacao)
SELECT centro_id, centro_id AS sk, nome, endereco, CURRENT_DATE, cidade, estado, TRUE
FROM Centros;

INSERT INTO dim_tempo (data_ocorrido)
SELECT DISTINCT data_pedido FROM pedidos
UNION
SELECT DISTINCT data_saida FROM Entregas
UNION
SELECT DISTINCT data_chegada FROM Entregas;


INSERT INTO fato_Entregas (
    pedido_id, cliente_id, centro_id, data_pedido_id, data_saida_id, data_chegada_id, quilometragem, quantidade, valor_total
)
SELECT 
    p.pedido_id,
    p.cliente_id,
    p.centro_saida_id AS centro_id,
    (SELECT data_id FROM dim_tempo WHERE data_ocorrido = p.data_pedido) AS data_pedido_id,
    (SELECT data_id FROM dim_tempo WHERE data_ocorrido = e.data_saida) AS data_saida_id,
    (SELECT data_id FROM dim_tempo WHERE data_ocorrido = e.data_chegada) AS data_chegada_id,
    e.quilometragem,
    p.quantidade,
    p.valor_total
FROM pedidos p
JOIN Entregas e ON p.pedido_id = e.pedido_id;



--3

--CONSULTA TOTAL DE PRODUTOS TRANSPORTADOS

select sum(quantidade) AS total_produtos_transportados
from fato_Entregas;

--CONSULTA TEMPO DE ENTREGA
   
   
 select
 fato_Entregas.pedido_id,
 fato_Entregas.cliente_id,
 fato_Entregas.centro_id,
 dim_tempo_chegada.data_ocorrido as data_chegada,
 dim_tempo_saida.data_ocorrido as data_saida,
 dim_tempo_chegada.data_ocorrido - dim_tempo_saida.data_ocorrido as tempo_total_de_entrega_dias
 from fato_Entregas
 inner join dim_tempo dim_tempo_saida on fato_Entregas.data_saida_id = dim_tempo_saida.data_id
 inner join dim_tempo dim_tempo_chegada on fato_Entregas.data_chegada_id = dim_tempo_chegada.data_id;

--CONSULTA MEDIA DE TEMPO DE UM PEDIDO

select
AVG(dim_tempo_chegada.data_ocorrido - dim_tempo_saida.data_ocorrido) AS tempo_medio_entrega_dias
from    fato_Entregas
inner join    dim_tempo dim_tempo_saida ON fato_Entregas.data_saida_id = dim_tempo_saida.data_id
inner join    dim_tempo dim_tempo_chegada ON fato_Entregas.data_chegada_id = dim_tempo_chegada.data_id;
   
   
--CONSULTA CUSTO MEDIO POR QUILOMETRO

select
AVG(fato_Entregas.valor_total / fato_Entregas.quilometragem) AS custo_medio_por_quilometro
from fato_Entregas;   
   
   
