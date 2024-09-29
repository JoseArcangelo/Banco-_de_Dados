--Questao 01
CREATE TABLE pessoas (
    nome VARCHAR(20),
    sobrenome VARCHAR(40),
    idade SMALLINT
);

CREATE PROCEDURE adicionar_pessoa(
    nome_param VARCHAR(20),
    sobrenome_param VARCHAR(40),
    idade_param SMALLINT
) 
AS $$
BEGIN 
    INSERT INTO pessoas (nome, sobrenome, idade)
    VALUES (nome_param, sobrenome_param, idade_param);
END;
$$
LANGUAGE plpgsql

CALL adicionar_pessoa('Jose'::VARCHAR, 'Arcangelo'::VARCHAR, 20::SMALLINT);
select * from pessoas;

--Questao 02
Create TABLE produto (
p_cod_produto INT,
p_nome_produto VARCHAR(30),
p_descricao TEXT,
p_preco NUMERIC,
p_qtde_estoque SMALLINT
);

create procedure add_produto(p_cod_produto INT,
nome_produto VARCHAR(30),
descricao TEXT,
preco NUMERIC,
qtde_estoque SMALLINT
)
as $$
begin
	insert into produto (p_cod_produto, p_nome_produto, p_descricao, p_preco, p_qtde_estoque)
	values (p_cod_produto, nome_produto, descricao, preco, qtde_estoque);
end;
$$
language plpgsql

call add_produto(001::int, 'Caneta'::Varchar, 'Caneta esferográfica azul'::text, 2.00::numeric, 10::smallint);
call add_produto(002::int, 'Lapis'::Varchar, 'BIC'::text, 1.50::numeric, 90::smallint);

select * from produto;


--Questao 03
create procedure alterar_preco(codigo int, novo_preco NUMERIC)
as $$
begin 
	update produto set p_preco = novo_preco where p_cod_produto = codigo;
end;
$$
language plpgsql

call alterar_preco(001::INT, 3.00::numeric);
select * from produto;

--Questao 04
CREATE OR REPLACE PROCEDURE buscar_produto(valor_quantidade INT)
LANGUAGE plpgsql AS $$
DECLARE
    nome_produto VARCHAR(30);
BEGIN
    FOR nome_produto IN
        SELECT p_nome_produto 
        FROM produto 
        WHERE p_qtde_estoque < valor_quantidade
    LOOP
        RAISE NOTICE 'Produto: %', nome_produto;
    END LOOP;
END;
$$;

call buscar_produto(50);

--Questao 05
CREATE OR REPLACE PROCEDURE insere_atualiza (cod int, prod varchar(30), descr text, valor
numeric, qtde smallint, desc_perc numeric)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO produto(p_cod_produto, p_nome_produto, p_descricao, p_preco, p_qtde_estoque)
	VALUES (cod, prod, descr, valor, qtde);
	UPDATE produto SET p_preco = p_preco * (100 - desc_perc) / 100;
END;
$$;

drop PROCEDURE insere_atualiza (cod int, prod varchar(30), descr text, valor
numeric, qtde smallint, desc_perc numeric);

CALL insere_atualiza(6,'Alvejante'::varchar(30),'Alvejante de roupas'::text, 12.30, 12::smallint,
10);
select * from produto;

--Questao 06
--C)retorna um número do tipo inteiro.

--Questao 07
create table compania(
	id serial,
	nome text,
	idade int,
	endereco text,
	salario numeric);


INSERT INTO compania (nome, idade, endereco, salario)
VALUES
    ('José', 30, 'Rua A, 123', 3000.50),
    ('Maria', 25, 'Rua B, 456', 4000.00),
    ('Carlos', 35, 'Rua C, 789', 5000.75);
   
CREATE OR REPLACE FUNCTION totalRecords ()
RETURNS integer AS $total$
declare
total integer;
BEGIN
	SELECT count(*) into total FROM compania;
	RETURN total;
END;
$total$ LANGUAGE plpgsql;

select totalRecords();

--Questao 08 

--Usando $n: Referência posicional, como $1 para o primeiro parâmetro.
--Usando o nome do parâmetro: Referência direta pelo nome dado ao parâmetro.
--Usando ALIAS: Criação de pseudônimos para parâmetros usando ALIAS.
--Variáveis locais com o mesmo nome: Variáveis locais podem sombrear o parâmetro se tiverem o mesmo nome.

--Questao 09
CREATE TABLE departamentos (id serial primary key, descricao varchar);

CREATE TABLE empregados(
codigo serial,
nome_emp text,
salario int,
departamento_cod int,
PRIMARY KEY (codigo),
FOREIGN KEY (departamento_cod) REFERENCES departamentos (id));

INSERT INTO departamentos (descricao) VALUES
('Recursos Humanos'),
('Desenvolvimento'),
('Marketing');

INSERT INTO empregados (nome_emp, salario, departamento_cod) VALUES
('Ana Silva', 5000, 1), 
('Carlos Santos', 7000, 2),
('Mariana Oliveira', 6000, 3); 


CREATE OR REPLACE FUNCTION codigo_empregado (valor INTEGER)
RETURNS SETOF INTEGER AS $$
DECLARE
registro RECORD;
retval INTEGER;
BEGIN
FOR registro IN SELECT * FROM empregados WHERE salario >= valor LOOP
RETURN NEXT registro. codigo;
END LOOP;
RETURN;
END;
$$ language 'plpgsql';


SELECT * FROM codigo_empregado(5000);

