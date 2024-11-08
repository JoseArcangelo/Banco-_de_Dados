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



-- fato_vendas: id_venda, data_key, cliente_key, loja_key, veiculo_key, localidade_key, valor_compra, valor_imposto, valor_impostoicms, tipo_transacao
-- dim_cliente: cliente_key, cpf, nome_cliente, endereco, cidade, bairro, estado, pais, renda
-- dim_loja: loja_key, cgc, endereco, cidade, estado, pais
-- dim_veiculo: veiculo_key, numero_chassi, modelo, fabricante, ano_fabricacao
-- dim_data: data_key, data, ano, mes, dia, trimestre
-- dim_localidade: localidade_key, cidade, estado, pais

create table dim_cliente (
    cliente_key serial primary key,
    cpf char(12) unique not null,
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
    cgc char(12) unique not null,
    endereco char(100),
    cidade char(30),
    estado char(2),
    pais char(20)
);

create table dim_veiculo (
    veiculo_key serial primary key,
    numero_chassi char(30) unique not null,
    modelo char(10),
    fabricante char(12),
    ano_fabricacao integer
);

create table dim_data (
    data_key serial primary key,
    data date unique not null,
    ano integer,
    mes integer,
    dia integer,
    trimestre integer
);

create table dim_localidade (
    localidade_key serial primary key,
    cidade char(30),
    estado char(2),
    pais char(20)
);

create table fato_vendas (
    id_venda serial primary key,
    data_key integer references dim_data(data_key),
    cliente_key integer references dim_cliente(cliente_key),
    loja_key integer references dim_loja(loja_key),
    veiculo_key integer references dim_veiculo(veiculo_key),
    localidade_key integer references dim_localidade(localidade_key),
    valor_compra decimal(15, 2),
    valor_imposto decimal(15, 2),
    valor_impostoicms decimal(15, 2),
    tipo_transacao char(10)
);

--1.Total das vendas de uma determinada loja, num determinado período.
select 
    sum(fv.valor_compra) as total_vendas
from 
    fato_vendas fv
join 
    dim_data dd on fv.data_key = dd.data_key
join 
    dim_loja dl on fv.loja_key = dl.loja_key
where 
    dl.loja_key = 1  
    and dd.ano = 2024 
    and dd.mes
between 1 and 3;  

--2.Lojas que mais venderam num determinado período de tempo.
select 
    dl.loja_key, 
    sum(fv.valor_compra) as total_vendas
from 
    fato_vendas fv
join 
    dim_data dd on fv.data_key = dd.data_key
join 
    dim_loja dl on fv.loja_key = dl.loja_key
where 
    dd.ano = 2024
    and dd.mes between 1 and 3  
group by 
    dl.loja_key
order by 
    total_vendas desc
limit 5;  
   
--3.Lojas que menos venderam num determinado período de tempo.
select 
    dl.loja_key, 
    sum(fv.valor_compra) as total_vendas
from 
    fato_vendas fv
join 
    dim_data dd on fv.data_key = dd.data_key
join 
    dim_loja dl on fv.loja_key = dl.loja_key
where 
    dd.ano = 2024  
    and dd.mes between 1 and 3 
group by 
    dl.loja_key
order by 
    total_vendas asc
limit 5;  


--4.Perfil de clientes que devem-se investir.
select 
    dc.nome_cliente, 
    sum(fv.valor_compra) as total_gasto
from 
    fato_vendas fv
join 
    dim_cliente dc on fv.cliente_key = dc.cliente_key
group by 
    dc.cliente_key, dc.nome_cliente
order by 
    total_gasto desc
limit 5; 

--5.Veículos de maior aceitação numa determinada região
select 
    dv.modelo, 
    dl.cidade, 
    sum(fv.valor_compra) as total_vendas
from 
    fato_vendas fv
join 
    dim_veiculo dv on fv.veiculo_key = dv.veiculo_key
join 
    dim_localidade dl on fv.localidade_key = dl.localidade_key
where 
    dl.cidade = 'Cidade C'  
    and fv.data_key between (select data_key from dim_data where data = '2024-01-01') 
                         and (select data_key from dim_data where data = '2024-12-31')  
group by 
    dv.modelo, dl.cidade
order by 
    total_vendas desc;
