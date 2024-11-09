create table fornecedor (
    cgc char(12) primary key,
    nome char(30),
    endereco char(100),
    cidade char(30),
    estado char(2),
    pais char(20)
);

create table fornecimento (
    codigo char(30) primary key,
    cgc char(12) references fornecedor(cgc),
    cgcloja char(12),
    datacompra date,
    valorcompra decimal(15, 2),
    valorimposto decimal(15, 2)
);

create table loja (
    cgcloja char(12) primary key,
    endereco char(100),
    cidade char(30),
    estado char(2),
    pais char(20)
);

create table veiculo (
    codigo char(30) primary key,
    cgc char(12),
    nome char(30),
    modelo char(10),
    datainiciofabricacao date,
    datafimfabricacao date
);

create table transporte (
    codigo char(30) primary key,
    cgctransportadora char(12),
    cgcloja char(12),
    datatransporte date,
    valorfrete decimal(15, 2)
);

create table transportadoras (
    cgctransportadora char(12) primary key,
    nome char(30),
    cidade char(30),
    estado char(2),
    pais char(20)
);

create table venda (
    numerochassi char(30) primary key,
    cgcloja char(12),
    cpf char(12),
    datacompra date,
    valorcompra decimal(15, 2),
    valorimposto decimal(15, 2),
    valorimpostoicms decimal(15, 2)
);

create table cliente (
    cpf char(12) primary key,
    nome char(30),
    endereco char(100),
    cidade char(30),
    bairro char(10),
    estado char(2),
    pais char(20),
    renda decimal(15, 2)
);


create table financiamento (
    cpf char(12),
    cgcloja char(12),
    cgcfabricante char(12),
    numerochassi char(30),
    valorfinanciamento decimal(15, 2),
    taxajuros decimal(5, 2),
    estado char(2),
    pais char(20),
    primary key (cpf, cgcfabricante, numerochassi)
);

create table financeira (
    cgcfabricante char(12) primary key,
    nome char(30),
    endereco char(100),
    bairro char(10),
    estado char(2),
    pais char(20)
);

create table aluguel (
    codigo char(30) primary key,
    cgcloja char(12),
    cpf char(12),
    datacompra date,
    horaaluguel date,
    dataretorno date,
    horaretorno date,
    valordiaria decimal(15, 2),
    valorcompra decimal(15, 2),
    valorimpostoicms decimal(15, 2)
);

-- Inserções na tabela fornecedor
insert into fornecedor (cgc, nome, endereco, cidade, estado, pais) 
values ('123456789012', 'Fornecedor A', 'Rua Exemplo, 100', 'Cidade A', 'SP', 'Brasil');

insert into fornecedor (cgc, nome, endereco, cidade, estado, pais) 
values ('987654321098', 'Fornecedor B', 'Av Exemplo, 200', 'Cidade B', 'RJ', 'Brasil');

-- Inserções na tabela fornecimento
insert into fornecimento (codigo, cgc, cgcloja, datacompra, valorcompra, valorimposto) 
values ('001', '123456789012', '111111111111', '2024-01-01', 1000.00, 100.00);

insert into fornecimento (codigo, cgc, cgcloja, datacompra, valorcompra, valorimposto) 
values ('002', '987654321098', '222222222222', '2024-02-01', 2000.00, 200.00);

-- Inserções na tabela loja
insert into loja (cgcloja, endereco, cidade, estado, pais) 
values ('111111111111', 'Rua Loja 1, 300', 'Cidade C', 'SP', 'Brasil');

insert into loja (cgcloja, endereco, cidade, estado, pais) 
values ('222222222222', 'Av Loja 2, 400', 'Cidade D', 'MG', 'Brasil');

-- Inserções na tabela veiculo
insert into veiculo (codigo, cgc, nome, modelo, datainiciofabricacao, datafimfabricacao) 
values ('A001', '123456789012', 'Veículo A', 'Modelo X', '2023-01-01', '2024-01-01');

insert into veiculo (codigo, cgc, nome, modelo, datainiciofabricacao, datafimfabricacao) 
values ('B002', '987654321098', 'Veículo B', 'Modelo Y', '2022-05-01', '2023-05-01');

-- Inserções na tabela transporte
insert into transporte (codigo, cgctransportadora, cgcloja, datatransporte, valorfrete) 
values ('TR001', '123123123123', '111111111111', '2024-03-01', 150.00);

insert into transporte (codigo, cgctransportadora, cgcloja, datatransporte, valorfrete) 
values ('TR002', '321321321321', '222222222222', '2024-04-01', 200.00);

-- Inserções na tabela transportadoras
insert into transportadoras (cgctransportadora, nome, cidade, estado, pais) 
values ('123123123123', 'Transportadora A', 'Cidade E', 'SP', 'Brasil');

insert into transportadoras (cgctransportadora, nome, cidade, estado, pais) 
values ('321321321321', 'Transportadora B', 'Cidade F', 'RJ', 'Brasil');

-- Inserções na tabela venda
insert into venda (numerochassi, cgcloja, cpf, datacompra, valorcompra, valorimposto, valorimpostoicms) 
values ('CHASSI123', '111111111111', '123456789012', '2024-05-01', 30000.00, 3000.00, 1500.00);

insert into venda (numerochassi, cgcloja, cpf, datacompra, valorcompra, valorimposto, valorimpostoicms) 
values ('CHASSI456', '222222222222', '987654321098', '2024-06-01', 50000.00, 5000.00, 2500.00);

-- Inserções na tabela cliente
insert into cliente (cpf, nome, endereco, cidade, bairro, estado, pais, renda) 
values ('123456789012', 'Cliente A', 'Rua Cliente, 123', 'Cidade G', 'Bairro A', 'SP', 'Brasil', 7000.00);

insert into cliente (cpf, nome, endereco, cidade, bairro, estado, pais, renda) 
values ('987654321098', 'Cliente B', 'Av Cliente, 456', 'Cidade H', 'Bairro B', 'RJ', 'Brasil', 8000.00);

-- Inserções na tabela financiamento
insert into financiamento (cpf, cgcloja, cgcfabricante, numerochassi, valorfinanciamento, taxajuros, estado, pais) 
values ('123456789012', '111111111111', '321321321321', 'CHASSI123', 15000.00, 3.5, 'SP', 'Brasil');

insert into financiamento (cpf, cgcloja, cgcfabricante, numerochassi, valorfinanciamento, taxajuros, estado, pais) 
values ('987654321098', '222222222222', '123123123123', 'CHASSI456', 25000.00, 4.0, 'RJ', 'Brasil');

-- Inserções na tabela financeira
insert into financeira (cgcfabricante, nome, endereco, bairro, estado, pais) 
values ('321321321321', 'Financeira A', 'Rua Financeira, 789', 'Centro', 'SP', 'Brasil');

insert into financeira (cgcfabricante, nome, endereco, bairro, estado, pais) 
values ('123123123123', 'Financeira B', 'Av Financeira, 101', 'Zona Sul', 'RJ', 'Brasil');

-- Inserções na tabela aluguel
insert into aluguel (codigo, cgcloja, cpf, datacompra, horaaluguel, dataretorno, horaretorno, valordiaria, valorcompra, valorimpostoicms) 
values ('ALG001', '111111111111', '123456789012', '2024-07-01', '2024-07-01 10:00', '2024-07-03', '2024-07-03 10:00', 200.00, 1000.00, 100.00);

insert into aluguel (codigo, cgcloja, cpf, datacompra, horaaluguel, dataretorno, horaretorno, valordiaria, valorcompra, valorimpostoicms) 
values ('ALG002', '222222222222', '987654321098', '2024-08-01', '2024-08-01 15:00', '2024-08-05', '2024-08-05 15:00', 250.00, 1200.00, 120.00);

--------------------------------
create table dim_cliente (
    cliente_key serial primary key,
    cpf char(12) unique not null references cliente(cpf),
    nome_cliente char(30),
    endereco char(100),
    cidade char(30),
    bairro char(10),
    estado char(2),
    pais char(20),
    renda decimal(15, 2)
);

create table dim_loja (
    loja_key serial primary key,
    cgc char(12) unique not null references loja(cgcloja),  
    endereco char(100),
    cidade char(30),
    estado char(2),
);

create table dim_data (
    data_key serial primary key,
    data date unique not null,
    ano integer,
    mes integer,
    dia integer,
    trimestre integer
);

create table dim_veiculo (
    numero_chassi char(30) unique primary key not null,
    modelo char(30),
    foreign key (numero_chassi) references veiculo(codigo) 
);



create table fato_vendas (
    id_venda serial primary key,
    data_key integer references dim_data(data_key),
    cliente_key integer references dim_cliente(cliente_key),
    loja_key integer references dim_loja(loja_key),
    veiculo_key char(30) references dim_veiculo(numero_chassi),
    valor_compra decimal(15, 2),
    valor_imposto decimal(15, 2),
    valor_impostoicms decimal(15, 2),
    tipo_transacao char(10)
);

insert into fato_vendas (data_key, cliente_key, loja_key, veiculo_key, valor_compra, valor_imposto, valor_impostoicms, tipo_transacao)
values 
-- Venda 1
((select data_key from dim_data where data = '2024-01-01'), 1, 1, 'A001', 35000.00, 3500.00, 700.00, 'Compra'),
-- Venda 2
((select data_key from dim_data where data = '2024-02-01'), 2, 2, 'B002', 45000.00, 4500.00, 900.00, 'Compra'),
-- Venda 3
((select data_key from dim_data where data = '2024-03-01'), 1, 2, 'A001', 30000.00, 3000.00, 600.00, 'Compra'),
-- Venda 4
((select data_key from dim_data where data = '2024-04-01'), 2, 1, 'B002', 40000.00, 4000.00, 800.00, 'Compra'),
-- Venda 5
((select data_key from dim_data where data = '2024-05-01'), 1, 1, 'A001', 25000.00, 2500.00, 500.00, 'Compra');



insert into dim_cliente (cpf, nome_cliente, endereco, cidade, bairro, estado, pais, renda) values 
('123456789012', 'Cliente A', 'Rua Cliente, 123', 'Cidade G', 'Bairro A', 'SP', 'Brasil', 7000.00),
('987654321098', 'Cliente B', 'Av Cliente, 456', 'Cidade H', 'Bairro B', 'RJ', 'Brasil', 8000.00);

insert into dim_loja (cgc, endereco, cidade, estado, pais)
values 
('111111111111', 'Rua Loja 1, 300', 'Cidade C', 'SP', 'Brasil'),
('222222222222', 'Av Loja 2, 400', 'Cidade D', 'MG', 'Brasil');

insert into dim_veiculo (numero_chassi, modelo)
values 
('A001', 'Modelo X'),
('B002', 'Modelo Y');

insert into dim_data (data, ano, mes, dia, trimestre)
values 
('2024-01-01', 2024, 1, 1, 1),
('2024-02-01', 2024, 2, 1, 1),
('2024-03-01', 2024, 3, 1, 1),
('2024-04-01', 2024, 4, 1, 2),
('2024-05-01', 2024, 5, 1, 2),
('2024-06-01', 2024, 6, 1, 2),
('2024-07-01', 2024, 7, 1, 3),
('2024-08-01', 2024, 8, 1, 3);

--1. Total das vendas de uma determinada loja, num determinado período.
select 
    sum(fv.valor_compra) as total_vendas
from 
    fato_vendas fv
join 
    dim_loja dl on fv.loja_key = dl.loja_key
join 
    dim_data dd on fv.data_key = dd.data_key
where 
    dl.cgc = '222222222222' --222222222222
    and dd.data between '2024-01-01' and '2024-12-31';  

--2. Lojas que mais venderam num determinado período de tempo.
select 
    dl.cgc,
    dl.endereco,
    dl.cidade,
    dl.estado,
    dl.pais,
    sum(fv.valor_compra) as total_vendas
from 
    fato_vendas fv
join 
    dim_loja dl on fv.loja_key = dl.loja_key
join 
    dim_data dd on fv.data_key = dd.data_key
where 
    dd.data between '2024-01-01' and '2024-12-31'  
group by 
    dl.cgc, dl.endereco, dl.cidade, dl.estado, dl.pais
order by 
    total_vendas desc;  
--OBS: ordenei com base nas lojas que mais venderam
    
    
--3.Lojas que menos venderam num determinado período de tempo.
select 
    dl.cgc,
    dl.endereco,
    dl.cidade,
    dl.estado,
    dl.pais,
    sum(fv.valor_compra) as total_vendas
from 
    fato_vendas fv
join 
    dim_loja dl on fv.loja_key = dl.loja_key
join 
    dim_data dd on fv.data_key = dd.data_key
where 
    dd.data between '2024-01-01' and '2024-12-31'
group by 
    dl.cgc, dl.endereco, dl.cidade, dl.estado, dl.pais
order by 
    total_vendas asc;
--OBS: ordenei com base nas lojas que menos venderam

--4.Perfil de clientes que devem-se investir.
SELECT 
    dc.nome_cliente, 
    dc.endereco, 
    dc.cidade, 
    dc.estado, 
    SUM(fv.valor_compra) AS total_compras
FROM 
    fato_vendas fv
JOIN 
    dim_cliente dc ON fv.cliente_key = dc.cliente_key
GROUP BY 
    dc.nome_cliente, dc.endereco, dc.cidade, dc.estado
ORDER BY 
    total_compras DESC;
   
--5.Veículos de maior aceitação numa determinada região
SELECT 
    dl.estado, 
    dv.modelo, 
    SUM(fv.valor_compra) AS total_vendas
FROM 
    fato_vendas fv
JOIN 
    dim_veiculo dv ON fv.veiculo_key = dv.numero_chassi
JOIN 
    dim_loja dl ON fv.loja_key = dl.loja_key
GROUP BY 
    dl.estado, dv.modelo
ORDER BY 
    dl.estado, total_vendas DESC;
   
select  * from dim_veiculo;
select  * from fato_vendas;
select  * from dim_loja;

   
   
