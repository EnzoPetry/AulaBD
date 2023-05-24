CREATE OR REPLACE FUNCTION compara_Valor() RETURNS BIGINT AS
$$
DECLARE
	valor_1 BIGINT;
	valor_2 BIGINT;
BEGIN
	select valor into valor_1 FROM SERVICOS WHERE id = 1;
	select valor into valor_2 FROM SERVICOS WHERE id = 2;
	
	RETURN (SELECT max(x) FROM unnest(ARRAY[valor_1,valor_2]) AS x);
END;
$$
language plpgsql;

select * FROM servicos;

select compara_Valor();

--------------------------------------------------------

ALTER TABLE clientes_pfs ADD idade int

SELECT * FROM clientes_pfs

UPDATE clientes_pfs SET idade =  WHERE id = 1;
UPDATE clientes_pfs SET idade = 35 WHERE id = 2;
UPDATE clientes_pfs SET idade = 20 WHERE id = 3;
UPDATE clientes_pfs SET idade = 18 WHERE id = 4;
UPDATE clientes_pfs SET idade = 79 WHERE id = 5;


CREATE OR REPLACE FUNCTION busca_idade(BIGINT) RETURNS BOOLEAN AS
$$
DECLARE
	idade BIGINT;
	divisor INT := 2;
BEGIN

	select c.idade into idade FROM clientes_pfs c WHERE id = $1;
	
	if idade < 2 THEN
		RETURN FALSE;
	END IF;
	
	WHILE divisor <= SQRT(idade) LOOP
		IF idade % divisor = 0 THEN
			RETURN FALSE;
		END IF;
		divisor := divisor + 1;
	END LOOP;
	RETURN TRUE;
END;
$$
language plpgsql;

select * FROM clientes_pfs;

select busca_idade(5);

----------------------------------------------------------

DROP FUNCTION multiplica_valor(BIGINT,BIGINT)

CREATE OR REPLACE FUNCTION multiplica_valor(BIGINT,BIGINT) RETURNS NUMERIC AS
$$
DECLARE
	id_1 NUMERIC;
	id_2 NUMERIC;
	valorMultiplicacao NUMERIC = 0;
BEGIN
	select valor into id_1 FROM SERVICOS WHERE id = $1;
	select valor into id_2 FROM SERVICOS WHERE id = $2;
	
	WHILE id_2 > 0 LOOP
		id_2 := id_2 - 1;
		valorMultiplicacao := valorMultiplicacao + id_1;
	END LOOP;
	RETURN valorMultiplicacao;
END;
$$
language plpgsql;

select * FROM servicos;

select multiplica_valor(1,3);

---------------------------------------------

DROP FUNCTION potencia_valor(BIGINT,BIGINT)

CREATE OR REPLACE FUNCTION potencia_valor(BIGINT,BIGINT) RETURNS NUMERIC AS
$$
DECLARE
	id_1 NUMERIC := $1;
	id_2 NUMERIC := $2;
	multiplicavel NUMERIC;
	valorMultiplicacao NUMERIC = 0;
BEGIN
	--select valor into id_1 FROM SERVICOS WHERE id = $1;
	--select valor into id_2 FROM SERVICOS WHERE id = $2;
	multiplicavel := id_2;
	
	WHILE id_2 > 1 LOOP
		id_1 := id_1 + id_1;
		id_2 := id_2 - 1;
	END LOOP;
	RETURN id_1;
END;
$$
language plpgsql;

select * FROM servicos;

select potencia_valor(2,8);

------------------------------------------------

CREATE OR REPLACE FUNCTION imprime_hospedagens() RETURNS void AS
$$
DECLARE

    r RECORD;
    cont BIGINT;
    
BEGIN

    cont := 1;

    FOR r IN
        select * from hospedagens
    LOOP
        RAISE NOTICE 'Hospedagem: % - ID: % - Cliente: % - Quarto: % - Entrada: % - Saida: % - Status: %', cont, r.id, r.id_reserva, r.data_entrada, r.data_saida, r.status;
        cont := cont + 1;
    END LOOP;

END;
$$
LANGUAGE plpgsql;

select imprime_hospedagens();


select cpf.nome,tq.descricao from clientes_pfs cpf
INNER JOIN reservas r
ON cpf.id = r.id
INNER JOIN quartos q
ON r.id_quarto = q.id
INNER JOIN tipos_quartos tq
ON q.id_tipo = tq.id

select * FROM reservas;

