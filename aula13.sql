-- FUNCOES

CREATE OR REPLACE FUNCTION cadastro_hospedagem(BIGINT, DATE, DATE, CHAR(5)) RETURNS VOID AS 
$$
	INSERT INTO hospedagens (id_reserva, data_entrada, data_saida, status) 
	VALUES ($1, $2, $3, $4);
$$
LANGUAGE SQL;


-- Como executar a funcao
select cadastro_hospedagem(2, '2021-10-10', '2021-10-12','e');

----------------------------

CREATE FUNCTION cadastro_hosp_serv(BIGINT, DATE, DATE, CHAR, VARCHAR, NUMERIC) RETURNS VOID AS 
$$
INSERT INTO hospedagens (id_reserva, data_entrada, data_saida, status) VALUES ($1, $2, $3, $4);
INSERT INTO servicos (descricao, valor) VALUES ($5, $6);
$$
LANGUAGE SQL;

-- Como executar a funcao
select cadastro_hosp_serv(2, '2021-10-10', '2021-10-12','e', 'Desc 1', 110.22);


--------------------

CREATE FUNCTION consulta_valores() RETURNS SETOF NUMERIC AS 
$$
	SELECT valor FROM servicos;
$$
LANGUAGE SQL;

select consulta_valores();

--------------------

CREATE FUNCTION qtda_reservas(INTEGER) RETURNS SETOF BIGINT AS 
$$	
	SELECT COUNT(*) FROM hospedagens WHERE id_reserva = $1;
$$
LANGUAGE SQL;

SELECT qtda_reservas(2);

----------------------------

CREATE FUNCTION del_servico(BIGINT) RETURNS VOID AS 
$$
	DELETE FROM servicos WHERE id = $1;
$$
LANGUAGE SQL;

SELECT del_servico(6);

----------------------------

CREATE OR REPLACE FUNCTION cli_hosp_por_quarto(BIGINT) RETURNS SETOF clientes AS 
$$
   	SELECT * FROM clientes WHERE id IN
   	(
	SELECT clientes.id FROM clientes, hospedagens
	WHERE clientes.id = hospedagens.id
	AND   hospedagens.id_reservas = $1
	);
$$
LANGUAGE SQL;

select cli_hosp_por_quarto(2);

----------------------------

CREATE FUNCTION incremento(INTEGER) RETURNS INTEGER AS 
$$
	SELECT $1 + 1 ;
$$
LANGUAGE plpgsql;

SELECT incremento(10);

----------------------------
----------------------------
----------------------------


CREATE TABLE estoques (
	id      	BIGINT NOT NULL,
	produto 	VARCHAR(30),
	quantidade  BIGINT,
	limite 		BIGINT NOT NULL default '0',
	PRIMARY KEY (id)
);

CREATE TABLE avisos (
	id  BIGINT NOT NULL,
	mensagem VARCHAR(50),
	PRIMARY KEY (id)
);

CREATE SEQUENCE estoques_id_seq
INCREMENT 1
START 1
CACHE 1;

CREATE SEQUENCE avisos_id_seq
INCREMENT 1
START 1
CACHE 1;

ALTER TABLE estoques ALTER COLUMN id SET DEFAULT NEXTVAL('estoques_id_seq');
ALTER TABLE avisos ALTER COLUMN id SET DEFAULT NEXTVAL('avisos_id_seq');

insert into estoques (produto, quantidade, limite) values ('teste0', 17, 50);
insert into estoques (produto, quantidade, limite) values ('teste1', 23, 50);
insert into estoques (produto, quantidade, limite) values ('teste2', 11, 50);
insert into estoques (produto, quantidade, limite) values ('teste3', 6, 50);
insert into estoques (produto, quantidade, limite) values ('teste4', 9, 50);

select * from estoques;

UPDATE estoques
SET    quantidade = 13
WHERE  id = 2;

select * from avisos;

CREATE OR REPLACE FUNCTION verifica_estoques() RETURNS TRIGGER AS
$$
BEGIN
	IF NEW.quantidade < NEW.limite THEN
		INSERT INTO avisos (mensagem) VALUES( 'Estoque de ' || NEW.produto || ' baixo.');
	ELSE
		INSERT INTO avisos (mensagem) VALUES( 'Estoque de ' || NEW.produto || ' Alto.');	
	END IF;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER verifica_estoques BEFORE UPDATE ON estoques
FOR EACH ROW EXECUTE FUNCTION verifica_estoques();


-- A variável NEW, no caso do INSERT, armazena o registro que está sendo inserido. 
-- No caso do UPDATE, armazena a nova versão do registro depois da atualização.
-- A variável OLD, no caso do DELETE, armazena o registro que está sendo excluído.
-- No caso do UPDATE, armazena a antiga versão do registro depois da atualização.

DROP FUNCTION desconto_valor (numeric);
CREATE OR REPLACE FUNCTION desconto_valor(valor numeric) RETURNS numeric AS
$$
BEGIN
	RETURN valor * 0.06;
END;
$$
LANGUAGE plpgsql;

select desconto_valor(100);


DROP FUNCTION aumento_salario(numeric);

CREATE OR REPLACE FUNCTION aumento_salario(valor numeric) RETURNS numeric AS
$$
BEGIN
	RETURN valor * 1.25;
END;
$$
LANGUAGE plpgsql;

select aumento_salario(100);

DROP FUNCTION multi_consulta( OUT soma , OUT media )
CREATE OR REPLACE FUNCTION multi_consulta(IN num numeric, OUT soma numeric, OUT media numeric) AS
$$
BEGIN
	SELECT sum(valor) + num from servicos into soma;
	SELECT avg(valor) + num from servicos into media;
END;
$$
LANGUAGE plpgsql;
SELECT * FROM multi_consulta(45);

CREATE OR REPLACE FUNCTION multi_consulta_cod(OUT soma numeric, OUT media numeric, IN cod bigint) AS
$$
BEGIN
	SELECT sum(valor) from servicos where id > cod into soma;
	SELECT avg(valor) from servicos where id > cod into media;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM multi_consulta_cod(2);


CREATE OR REPLACE PROCEDURE proc_deletar() AS
$$
	DELETE FROM servicos WHERE id = 7;
$$
LANGUAGE SQL;

insert into servicos(descricao, valor) values ('descricao nova', 20.0);

select * FROM servicos;

CALL proc_deletar();

CREATE OR REPLACE PROCEDURE proc_deletar_id(IN cod int) AS
$$
	DELETE FROM servicos WHERE id = cod;
$$
LANGUAGE SQL;

insert into servicos(descricao, valor) values ('descricao nova 0', 20.0);
insert into servicos(descricao, valor) values ('descricao nova 1', 204.0);
insert into servicos(descricao, valor) values ('descricao nova 2', 206.0);
insert into servicos(descricao, valor) values ('descricao nova 3', 209.0);
insert into servicos(descricao, valor) values ('descricao nova 4', 201.0);

select * FROM servicos;

CALL proc_deletar_id(13);
CALL proc_deletar_id(12);
CALL proc_deletar_id(11);
CALL proc_deletar_id(10);
