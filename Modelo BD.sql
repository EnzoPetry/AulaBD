-- Criando modelo fisico

CREATE TABLE clientes(
id           BIGINT NOT NULL,
endereco     VARCHAR(200) NOT NULL,
telefone     NUMERIC(10,0) NOT NULL,
uf			 char(2) NOT NULL
);

CREATE TABLE clientes_pjs(
id             BIGINT NOT NULL,
razao_social   VARCHAR(150) NOT NULL,
cnpj           VARCHAR(20) NOT NULL
);

CREATE TABLE clientes_pfs(
id             BIGINT NOT NULL,
nome           VARCHAR(150) NOT NULL,
cpf            VARCHAR(20) NOT NULL 
);

CREATE TABLE tipos_quartos(
id         BIGINT NOT NULL,
descricao  VARCHAR(40) NOT NULL,
valor      NUMERIC(9,2) NOT NULL,
capacidade NUMERIC(5,2) NOT NULL
);

CREATE TABLE quartos(
id      BIGINT NOT NULL,
id_tipo BIGINT NOT NULL,
andar   CHAR(10) NOT NULL,
status  CHAR(5) NOT NULL,
numero  NUMERIC(5,2) NOT NULL
);

CREATE TABLE servicos(
id        BIGINT NOT NULL,
descricao VARCHAR(60) NOT NULL,
valor     NUMERIC(9,2) NOT NULL
);

CREATE TABLE reservas(
id            BIGINT NOT NULL,
id_cliente    BIGINT NOT NULL,
id_quarto     BIGINT NOT NULL,
data_reserva  DATE NOT NULL,
diarias       INTEGER NOT NULL,
data_entrada  DATE NOT NULL,
data_saida    DATE NOT NULL,
status        CHAR(5) NOT NULL
);

CREATE TABLE hospedagens(
id           BIGINT NOT NULL,
id_reserva 	 BIGINT NOT NULL,
data_entrada DATE NOT NULL,
data_saida   DATE,
status       CHAR(5) NOT NULL
);

CREATE TABLE atendimentos(
id              BIGINT NOT NULL,
id_servico      BIGINT NOT NULL,
id_hospedagem   BIGINT NOT NULL,
data_servico    DATE NOT NULL
);


-- Adicionando as chaves Primarias

ALTER TABLE clientes ADD PRIMARY KEY(id);
ALTER TABLE tipos_quartos ADD PRIMARY KEY(id);
ALTER TABLE quartos ADD PRIMARY KEY(id);
ALTER TABLE servicos ADD PRIMARY KEY(id);
ALTER TABLE reservas ADD PRIMARY KEY(id);
ALTER TABLE hospedagens ADD PRIMARY KEY(id);
ALTER TABLE atendimentos ADD PRIMARY KEY(id);


-- Adicionando as chaves Estrangeiras

ALTER TABLE clientes_pjs ADD FOREIGN KEY (id) REFERENCES clientes(id);
ALTER TABLE clientes_pfs ADD FOREIGN KEY(id) REFERENCES clientes(id);
ALTER TABLE quartos ADD FOREIGN KEY (id_tipo) REFERENCES tipos_quartos(id);
ALTER TABLE reservas ADD FOREIGN KEY (id_cliente) REFERENCES clientes(id);
ALTER TABLE reservas ADD FOREIGN KEY (id_quarto) REFERENCES quartos(id);
ALTER TABLE hospedagens ADD FOREIGN KEY (id_reserva) REFERENCES reservas(id);
ALTER TABLE atendimentos ADD FOREIGN KEY (id_servico) REFERENCES servicos(id);
ALTER TABLE atendimentos ADD FOREIGN KEY (id_hospedagem) REFERENCES hospedagens(id);

-- Adicionando chave unica para atributo

ALTER TABLE clientes_pfs ADD UNIQUE(id);
ALTER TABLE clientes_pfs ADD UNIQUE(cpf);
ALTER TABLE clientes_pjs ADD UNIQUE(id);
ALTER TABLE clientes_pjs ADD UNIQUE(cnpj);


-- Criacao de sequencias para cada tabela

CREATE SEQUENCE clientes_id_seq
INCREMENT 1
START 1
CACHE 1;

CREATE SEQUENCE tipos_quartos_id_seq
INCREMENT 1
START 1
CACHE 1;

CREATE SEQUENCE quartos_id_seq
INCREMENT 1
START 1
CACHE 1;

CREATE SEQUENCE servicos_id_seq
INCREMENT 1
START 1
CACHE 1;
 
CREATE SEQUENCE reservas_id_seq
INCREMENT 1
START 1
CACHE 1;

CREATE SEQUENCE hospedagens_id_seq
INCREMENT 1
START 1
CACHE 1;

CREATE SEQUENCE atendimentos_id_seq
INCREMENT 1
START 1
CACHE 1;

-- Fazendo a chamada da sequencia

ALTER TABLE clientes ALTER COLUMN id SET DEFAULT NEXTVAL('clientes_id_seq');
ALTER TABLE tipos_quartos ALTER COLUMN id SET DEFAULT NEXTVAL('tipos_quartos_id_seq');   
ALTER TABLE quartos ALTER COLUMN id SET DEFAULT NEXTVAL('quartos_id_seq');
ALTER TABLE servicos ALTER COLUMN id SET DEFAULT NEXTVAL('servicos_id_seq');
ALTER TABLE reservas ALTER COLUMN id SET DEFAULT NEXTVAL('reservas_id_seq');
ALTER TABLE hospedagens ALTER COLUMN id SET DEFAULT NEXTVAL('hospedagens_id_seq');
ALTER TABLE atendimentos ALTER COLUMN id SET DEFAULT NEXTVAL('atendimentos_id_seq');

-- Alimentando as tabelas do Banco de dados com registros

insert into clientes(endereco , telefone, uf) values ('Rua tal 1', 111, 'RS');
insert into clientes(endereco , telefone, uf) values ('Rua tal 2', 222, 'RS');
insert into clientes(endereco , telefone, uf) values ('Rua tal 3', 333, 'RS');
insert into clientes(endereco , telefone, uf) values ('Rua tal 4', 444, 'SC');
insert into clientes(endereco , telefone, uf) values ('Rua tal 5', 555, 'SP');
insert into clientes(endereco , telefone, uf) values ('Rua tal 6', 666, 'SP');
insert into clientes(endereco , telefone, uf) values ('Rua tal 7', 777, 'RJ');
insert into clientes(endereco , telefone, uf) values ('Rua tal 8', 888, 'SP');
insert into clientes(endereco , telefone, uf) values ('Rua tal 9', 999, 'SC');
insert into clientes(endereco , telefone, uf) values ('Rua tal 10', 000, 'RS');

insert into clientes_pfs(id, nome , cpf) values (1,'Antonio leaes', 'cpf111');
insert into clientes_pfs(id, nome , cpf) values (2,'Luiz leaes', 'cpf222');
insert into clientes_pfs(id, nome , cpf) values (3,'Mario leaes Silva', 'cpf333');
insert into clientes_pfs(id, nome , cpf) values (4,'Ana leaes', 'cpf444');
insert into clientes_pfs(id, nome , cpf) values (5,'Dagoberto leaes Santos', 'cpf555');

insert into clientes_pjs(id, razao_social , cnpj) values (6,'Empresa Antonio 1', 'cnpj111');
insert into clientes_pjs(id, razao_social , cnpj) values (7,'Empresa Luiz 2', 'cnpj222');
insert into clientes_pjs(id, razao_social , cnpj) values (8,'Antonio Empresa 3', 'cnpj333');
insert into clientes_pjs(id, razao_social , cnpj) values (9,'Empresa Antonio 4 Ltda', 'cnpj444');
insert into clientes_pjs(id, razao_social , cnpj) values (10,'Empresa Antonio s/a 5', 'cnpj555');

insert into tipos_quartos (descricao , valor, capacidade) values ('Luxo', 100.50, 2);
insert into tipos_quartos (descricao , valor, capacidade) values ('Standard', 150.50, 3);
insert into tipos_quartos (descricao , valor, capacidade) values ('Super Luxo', 200, 4);
insert into tipos_quartos (descricao , valor, capacidade) values ('Presidencial', 300.98, 6);
insert into tipos_quartos (descricao , valor, capacidade) values ('Pulgueiro', 9.99, 12);

insert into quartos (id_tipo , andar, status, numero) values (1, 'Primerio', 'v', 101);
insert into quartos (id_tipo , andar, status, numero) values (2, 'Primerio', 'v', 102);
insert into quartos (id_tipo , andar, status, numero) values (3, 'Primerio', 'v', 103);
insert into quartos (id_tipo , andar, status, numero) values (1, 'Segundo', 'o',101);
insert into quartos (id_tipo , andar, status, numero) values (2, 'Segundo', 'o', 102);
insert into quartos (id_tipo , andar, status, numero) values (3, 'Segundo', 'v', 103);
insert into quartos (id_tipo , andar, status, numero) values (4, 'Terceiro', 'v', 101);
insert into quartos (id_tipo , andar, status, numero) values (4, 'Terceiro', 'o', 102);
insert into quartos (id_tipo , andar, status, numero) values (5, 'Terceiro', 'o', 103);
insert into quartos (id_tipo , andar, status, numero) values (5, 'Terceiro', 'v', 104);

insert into reservas (id_cliente , id_quarto, data_reserva, diarias,data_entrada, data_saida, status) 
values (1, 5, '2022-10-01', 2, '2022-10-10','2022-10-13', 'a');
insert into reservas (id_cliente , id_quarto, data_reserva, diarias,data_entrada,data_saida, status) 
values (2, 4, '2019-10-02', 3, '2019-10-11','2022-10-15', 'a');
insert into reservas (id_cliente , id_quarto, data_reserva, diarias,data_entrada,data_saida, status) 
values (3, 3, '2022-10-03', 2, '2022-10-12','2022-10-12', 'e');
insert into reservas (id_cliente , id_quarto, data_reserva, diarias,data_entrada,data_saida, status) 
values (4, 2, '2021-10-04',2,'2021-10-13','2022-10-12', 'i');
insert into reservas (id_cliente , id_quarto, data_reserva, diarias,data_entrada,data_saida, status) 
values (5, 1, '2022-10-05',1,'2022-10-14','2022-10-11', 'a');

insert into hospedagens (id_reserva, data_entrada, data_saida, status) 
values (1, '2022-10-01','2022-10-03', 'a');
insert into hospedagens (id_reserva, data_entrada, data_saida, status) 
values (2, '2022-10-06','2022-11-10', 'a');
insert into hospedagens (id_reserva, data_entrada, data_saida, status) 
values (3, '2021-10-01','2021-10-05', 'e');
insert into hospedagens (id_reserva, data_entrada, data_saida, status) 
values (4, '2022-10-01','2022-10-03', 'e');

insert into servicos (descricao, valor) values ('Lavanderia', 10);
insert into servicos (descricao, valor) values ('Cafe da Manha na cama', 20.67);
insert into servicos (descricao, valor) values ('Academia', 100);
insert into servicos (descricao, valor) values ('Cofre', 130);
insert into servicos (descricao, valor) values ('Sauna', 200);

insert into atendimentos (id_servico,id_hospedagem, data_servico) values (1,1, '2020-10-10');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (1,1, '2020-10-10');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (2,2, '2020-10-10');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (2,1, '2020-10-10');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (4,3, '2020-10-10');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (4,3, '2020-10-10');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (5,1, '2020-10-10');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (5,4, '2020-10-10');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (5,4, '2020-10-10');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (3,3, '2020-10-10');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (1,1, '2020-10-11');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (1,1, '2020-10-12');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (2,2, '2020-10-13');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (2,1, '2020-10-13');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (4,3, '2020-10-14');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (4,3, '2020-10-14');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (5,1, '2020-10-01');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (5,4, '2020-10-01');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (5,2, '2020-10-02');
insert into atendimentos (id_servico,id_hospedagem, data_servico) values (3,1, '2020-10-02');

-- Consultas de tabelas

select * from clientes;
select * from clientes_pfs;
select * from clientes_pjs;
select * from tipos_quartos;
select * from quartos;
select * from hospedagens;
select * from reservas;
select * from servicos;
select * from atendimentos;

-- Limpa todos os dados da tabela em cascata com tabelas relacionadas

TRUNCATE TABLE clientes, hospedagens, quartos cascade;

-- Apagar todo os esquema de banco de dados Postgres

drop schema public cascade;

-- Apagar todo os esquema de banco de dados Postgres

create schema public;