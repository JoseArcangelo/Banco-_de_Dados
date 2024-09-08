create database sqlmagazine;

CREATE TABLE Clientes (
    Id SERIAL PRIMARY KEY,  
    Nome VARCHAR(100),
    Saldo DECIMAL(10,2)
);


CREATE TABLE Contas (
    Id SERIAL PRIMARY KEY,  -- Também pode usar SERIAL aqui se quiser auto-incremento
    FkCliente INT,
    descricao VARCHAR(255),
    Saldo DECIMAL(10,2),
    FOREIGN KEY (FkCliente) REFERENCES Clientes(Id)
);

CREATE TABLE Movimentos (
    Id SERIAL PRIMARY KEY,  
    FkConta INT,
    Histórico VARCHAR(255),
    Debito DECIMAL(10,2),
    Credito DECIMAL(10,2),
    FOREIGN KEY (FkConta) REFERENCES Contas(Id)
);



INSERT INTO Clientes (Id, Nome, Saldo) VALUES
(1, 'João Silva', 2000.00),
(2, 'Maria Oliveira', 1500.00),
(3, 'Pedro Santos', 3000.00),
(4, 'Ana Costa', 1200.00),
(5, 'Carlos Almeida', 2500.00);

INSERT INTO Contas (Id, FkCliente, descricao , Saldo) VALUES
(1, 1, 'Conta Corrente Principal', 1000.00),
(2, 1, 'Conta Poupança', 1000.00),
(3, 2, 'Conta Corrente', 1500.00),
(4, 3, 'Conta Salário', 2500.00),
(5, 4, 'Conta Empresarial', 1200.00);

INSERT INTO Movimentos (Id, FkConta, Histórico, Debito, Credito) VALUES
(1, 1, 'Pagamento de Serviços', 200.00, 0.00),
(2, 1, 'Depósito Salário', 0.00, 1000.00),
(3, 2, 'Transferência Interna', 500.00, 0.00),
(4, 2, 'Juros Poupança', 0.00, 10.00),
(5, 3, 'Compra no Supermercado', 50.00, 0.00);

--Parte 1 criação de funcoes

CREATE FUNCTION incrementar(INTEGER)
RETURNS INTEGER AS '
    SELECT $1 + 1;
'
LANGUAGE SQL;

SELECT incrementar(10);

CREATE FUNCTION ncontas(INTEGER)
    RETURNS INT8 AS '
      SELECT COUNT(*) FROM contas
         WHERE fkcliente = $1;
    '
    LANGUAGE SQL;

 SELECT ncontas(2);

CREATE FUNCTION cliente_contadesc(VARCHAR(30), VARCHAR(30))
     RETURNS INT8 AS '
              INSERT INTO clientes(nome) VALUES($1);
              INSERT INTO contas(fkcliente, descricao)
              	VALUES(CURRVAL(''clientes_id_seq''),$2);
              SELECT CURRVAL(''clientes_id_seq'');
     '
     LANGUAGE SQL;
    

drop function cliente_contadesc(VARCHAR(30), VARCHAR(30));

CREATE FUNCTION quemdeve() RETURNS SETOF INTEGER AS '
              SELECT clientes.id FROM clientes
              INNER JOIN contas ON clientes.id = contas.fkcliente
              INNER JOIN movimentos ON contas.id = movimentos.fkconta
              GROUP BY clientes.id
              HAVING SUM(movimentos.credito - movimentos.debito) < 0;
     '
     LANGUAGE SQL;
    
select quemdeve();

CREATE FUNCTION devedores()
     RETURNS SETOF clientes AS '
              SELECT * FROM clientes WHERE id IN
              (
                        SELECT clientes.id FROM clientes
                        INNER JOIN contas ON clientes.id = contas.fkcliente
                        INNER JOIN movimentos ON contas.id = movimentos.fkconta
                        GROUP BY clientes.id
                        HAVING SUM(movimentos.credito - movimentos.debito) < 0
              );
     '
     LANGUAGE SQL;

select id, nome from devedores();

CREATE FUNCTION MaioresClientes(NUMERIC(15,2))
     RETURNS SETOF clientes AS '
              SELECT * FROM clientes WHERE id IN
              (
                        SELECT clientes.id FROM clientes
                        INNER JOIN contas ON clientes.id = contas.fkcliente
                        INNER JOIN movimentos ON contas.id = movimentos.fkconta
                        GROUP BY clientes.id
                        HAVING SUM(movimentos.credito) >= $1
              );
     '
     LANGUAGE SQL;

select id, nome from MaioresClientes (1000);

SELECT proname, prosrc FROM pg_proc WHERE proname = 'quemdeve';


--parte 2 Funções e Triggers

--processo de cricao
--sintaxe de criacao



CREATE OR REPLACE FUNCTION select_dinamico(p_tabela TEXT) 
RETURNS VOID AS $$
DECLARE
    vSQL TEXT;
BEGIN
    vSQL := 'SELECT * FROM ' || quote_ident(p_tabela);
    EXECUTE vSQL;
END;
$$ LANGUAGE plpgsql;

--Implementação de Function em PL/PgSQL
CREATE OR REPLACE FUNCTION id_nome_cliente(p_id INTEGER) 
RETURNS TEXT AS $$
DECLARE
    r RECORD;
BEGIN
    SELECT * INTO r FROM clientes WHERE id = p_id;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Cliente % não existente!', p_id;
    END IF;
    RETURN r.nome;
END;
$$ LANGUAGE plpgsql;


SELECT id_nome_cliente(2);
--SELECT id_nome_cliente(2000);
 --    ERROR: Cliente 2000 não existente !


-- Criação de uma Function para implementação de uma Trigger
-- Criação das tabelas
CREATE TABLE teste (
    id INT4,
    nome TEXT
);

CREATE TABLE teste2 (
    id_teste INT4,
    nome TEXT
);

-- Criação da função
CREATE OR REPLACE FUNCTION ftr_ins_teste()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.id IS NOT NULL THEN
        INSERT INTO teste2(id_teste, nome) VALUES (NEW.id, NEW.nome);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criação do tigger que chamara a funcao
CREATE TRIGGER trg_insert_teste
AFTER INSERT ON teste
FOR EACH ROW
EXECUTE FUNCTION ftr_ins_teste();





