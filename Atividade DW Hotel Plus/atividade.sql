--Para adiantar populei as tabelas usando o chat
--TABELAS
create table hotel (
    id_hotel int primary key,
    nome_hotel varchar(100) not null,
    cidade varchar(100),
    pais varchar(100),
    data_inauguracao date
);

create table quarto (
    id_quarto serial primary key,
    id_hotel int,
    tipo_quarto varchar(10) check (tipo_quarto in ('standard', 'luxo', 'suíte')),
    status_manutencao varchar(15) check (status_manutencao in ('disponível', 'em manutenção')),
    data_ultima_reforma date,
    foreign key (id_hotel) references hotel(id_hotel)
);

create table cliente (
    id_cliente serial primary key,
    nome varchar(100),
    data_nascimento date,
    endereco varchar(200),
    categoria_fidelidade varchar(10) check (categoria_fidelidade in ('bronze', 'prata', 'ouro', 'platina')),
    data_ultima_alteracao timestamp default current_timestamp
);


create table receitas (
    id_hotel int,
    data date,
    receita_total_diaria decimal(10, 2),
    despesas_operacionais_diarias decimal(10, 2),
    primary key (id_hotel, data),
    foreign key (id_hotel) references hotel(id_hotel)
);

create table reserva (
    id_reserva int primary key,
    id_cliente int,
    id_hotel int,
    id_quarto int,
    data_checkin date,
    data_checkout date,
    valor_total decimal(10, 2),
    foreign key (id_cliente) references cliente(id_cliente),
    foreign key (id_hotel) references hotel(id_hotel),
    foreign key (id_quarto) references quarto(id_quarto)
);

-- Inserindo dados na tabela CLIENTE
insert into cliente (nome, data_nascimento, endereco, categoria_fidelidade)
values ('João Silva', '1985-05-12', 'Rua das Flores, 123', 'ouro'),
       ('Maria Santos', '1990-08-24', 'Av. Paulista, 456', 'prata'),
       ('Carlos Pereira', '1978-11-30', 'Rua Afonso Pena, 789', 'platina');

-- Inserindo dados na tabela HOTEL
insert into hotel (id_hotel, nome_hotel, cidade, pais, data_inauguracao)
values (1, 'Hotel Central', 'São Paulo', 'Brasil', '2005-06-15'),
       (2, 'Hotel Luxo', 'Rio de Janeiro', 'Brasil', '2010-09-21'),
       (3, 'Hotel Paraíso', 'Florianópolis', 'Brasil', '2018-12-01');

-- Inserindo dados na tabela QUARTO
insert into quarto (id_hotel, tipo_quarto, status_manutencao, data_ultima_reforma)
values (1, 'standard', 'disponível', '2022-05-20'),
       (2, 'luxo', 'em manutenção', '2023-01-10'),
       (3, 'suíte', 'disponível', '2021-11-05');

-- Inserindo dados na tabela RECEITAS
insert into receitas (id_hotel, data, receita_total_diaria, despesas_operacionais_diarias)
values (1, '2024-10-15', 5000.00, 2000.00),
       (2, '2024-10-15', 7500.00, 2500.00),
       (3, '2024-10-15', 6000.00, 1800.00);

-- Inserindo dados na tabela RESERVA
insert into reserva (id_reserva, id_cliente, id_hotel, id_quarto, data_checkin, data_checkout, valor_total)
values (101, 1, 1, 1, '2024-11-01', '2024-11-07', 3500.00),
       (102, 2, 2, 2, '2024-11-10', '2024-11-15', 4500.00),
       (103, 3, 3, 3, '2024-11-20', '2024-11-25', 5000.00);
      
      
select * from reserva;
select * from receitas;
select * from quarto;
select * from hotel;
select * from cliente;


create table dim_cliente (
    id_cliente_surrogate serial primary key,
    id_cliente int,
    nome varchar(100),
    categoria_fidelidade varchar(10) check (categoria_fidelidade in ('bronze', 'prata', 'ouro', 'platina')),
    data_inicio date,
    cliente_ativo boolean default true
);


create table dim_quarto (
    id_quarto_surrogate serial primary key, 
    id_quarto int, 
    tipo_quarto varchar(10) check (tipo_quarto in ('standard', 'luxo', 'suíte')),
    status_manutencao varchar(15) check (status_manutencao in ('disponível', 'em manutenção')),
    data_inicio date, 
    data_fim date, 
    quarto_ativo boolean default true 
);


create table dim_receita (
    id_hotel int,
    data date,
    receita_total_diaria numeric(10, 2),
    despesas_operacionais_diarias numeric(10, 2),
    primary key (id_hotel, data),
    foreign key (id_hotel) references hotel(id_hotel)
);

create table dim_hotel (
    id_hotel_surrogate serial primary key, 
    id_hotel int, 
    nome_hotel varchar(100),
    cidade varchar(100),
    pais varchar(100),
    data_inauguracao date
);


create table fato_reserva (
    id_reserva serial primary key,
    id_cliente_surrogate int references dim_cliente(id_cliente_surrogate),
    id_hotel int references hotel(id_hotel),
    id_quarto_surrogate int references dim_quarto(id_quarto_surrogate),
    data_checkin date,
    data_checkout date,
    valor_total_reserva numeric(10, 2)
);



insert into dim_cliente (id_cliente, nome, categoria_fidelidade, data_inicio, cliente_ativo)
select id_cliente, nome, categoria_fidelidade, current_date, true
from cliente;

insert into dim_quarto (id_quarto, tipo_quarto, status_manutencao, data_inicio, data_fim, quarto_ativo)
select id_quarto, tipo_quarto, status_manutencao, current_date, null, true
from quarto;
select * from dim_quarto;

insert into dim_receita (id_hotel, data, receita_total_diaria, despesas_operacionais_diarias)
select id_hotel, data, receita_total_diaria, despesas_operacionais_diarias
from receitas;
select * from dim_receita;

insert into dim_hotel (id_hotel, nome_hotel, cidade, pais, data_inauguracao)
select id_hotel, nome_hotel, cidade, pais, data_inauguracao
from hotel;
select * from dim_hotel;

insert into fato_reserva (id_cliente_surrogate, id_hotel, id_quarto_surrogate, data_checkin, data_checkout, valor_total_reserva)
select dc.id_cliente_surrogate, r.id_hotel, dq.id_quarto_surrogate, r.data_checkin, r.data_checkout, r.valor_total
from reserva r
join dim_cliente dc on r.id_cliente = dc.id_cliente
join dim_quarto dq on r.id_quarto = dq.id_quarto;
select * from fato_reserva;


--1. Qual é a receita média por cliente em cada categoria de fidelidade?
select 
	dc.categoria_fidelidade,
	avg(fr.valor_total_reserva) as receita_media_por_cliente
from 
	fato_reserva fr
join 
	dim_cliente dc on fr.id_cliente_surrogate = dc.id_cliente_surrogate
group by 
	dc.categoria_fidelidade;
   
--2. Quais hotéis possuem as taxas de ocupação mais altas em um período específico?
select 
    h.id_hotel,
    h.nome_hotel,
    count(r.id_reserva) as reservas,
    (count(r.id_reserva) * 1.0 / (select count(*) from quarto q where q.id_hotel = h.id_hotel)) as taxa_ocupacao
from 
    reserva r
join 
    hotel h on r.id_hotel = h.id_hotel
where 
    r.data_checkin >= '2024-11-01' and r.data_checkout <= '2024-11-30'
group by 
    h.id_hotel, h.nome_hotel
order by 
    taxa_ocupacao desc;

--3. Qual a média de tempo que os clientes de uma determinada categoria de fidelidade permanecem nos hotéis?
select 
    dc.categoria_fidelidade,
    avg(r.data_checkout - r.data_checkin) as media_permanencia_dias
from 
    reserva r
join 
    dim_cliente dc on r.id_cliente = dc.id_cliente
group by 
    dc.categoria_fidelidade;

--4. Quais quartos são mais frequentemente reformados, e com que frequência?
 select 
	dq.id_quarto,
	count(dq.data_inicio) as num_reformas
from 
	dim_quarto dq
group by 
	dq.id_quarto
order by 
	num_reformas desc;


--5. Qual o perfil dos clientes com maior gasto em reservas por país e categoria de fidelidade?
select 
	dh.pais,
	dc.categoria_fidelidade,
	sum(fr.valor_total_reserva) as gasto_total_por_cliente
from 
	fato_reserva fr
join 
	dim_cliente dc on fr.id_cliente_surrogate = dc.id_cliente_surrogate
join 
	dim_hotel dh on fr.id_hotel = dh.id_hotel
group by 
	dh.pais, dc.categoria_fidelidade
order by 
	gasto_total_por_cliente desc;



