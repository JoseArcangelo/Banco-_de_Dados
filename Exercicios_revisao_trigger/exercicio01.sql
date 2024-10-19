create table produto(
	cod_produto int  primary key,
	descricao varchar(255),
	qtd_disponivel int
);

create table itensVenda(
	cod_venda int primary key,
	qtd_vendida int,
	id_produto int references produto(cod_produto)
);

insert into produto (cod_produto, descricao, qtd_disponivel) values (001, 'Chinelo', 10);
insert into produto (cod_produto, descricao, qtd_disponivel) values (002, 'Caneta', 15);
insert into produto (cod_produto, descricao, qtd_disponivel) values (003, 'Lapis', 20);

select * from produto;
select * from itensVenda;

create or replace function atualizarEstoque()
	returns trigger as $$
	begin 
		update produto set qtd_disponivel = qtd_disponivel - new.qtd_vendida
		where cod_produto = new.id_produto;
	return new;
	end;
	$$
	language 'plpgsql';
	

create trigger realizarVenda
after insert on itensVenda 
for each row execute function atualizarEstoque();

insert into itensVenda(cod_venda, qtd_vendida, id_produto) values (52, 5, 002);

select * from produto;
