create table usuarios(
	id int primary key,
	nome varchar(255),
	senha varchar(40)
);

create table bkp_usuario(
	id int primary key,
	nome varchar(255),
	senha varchar(40)
);


insert into usuarios(id, nome, senha) values (01, 'Jose', '123456');
insert into usuarios(id, nome, senha) values (02, 'Arcangelo', '654321');
insert into usuarios(id, nome, senha) values (03, 'Garlet', '135975');

create or replace function realizarBkp()
	returns trigger as 
	$$
	begin 
		insert into bkp_usuario (id, nome, senha) values (old.id, old.nome, old.senha);
		return old;
	end;
	$$
	language 'plpgsql';
	
create trigger bkpDoUsuario 
after delete on usuarios
for each row execute function realizarBkp();

delete from usuarios where id = 02;

select * from usuarios;
select * from bkp_usuario;
