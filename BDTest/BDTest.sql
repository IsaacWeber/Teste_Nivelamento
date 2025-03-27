create database if not exists operadoras;

use operadoras;

# Cria tabela para operadora
create table if not exists operadora(
    id bigint auto_increment,
    registro_ans varchar(50),
    cnpj varchar(50),
    razao_social varchar(200),
    nome_fantasia varchar(100),
    modalidade varchar(100),
    primary key(id)
);

# Cria tabela para endereço de operadora
create table if not exists endereco(
	id bigint auto_increment,
	logradouro varchar(200),
    numero varchar(50),
    complemento varchar(100),
    bairro varchar(100),
    cidade varchar(100),
    uf varchar(5),
    cep varchar(50),
	operadora_id bigint,
	primary key(id),
    foreign key(operadora_id) references operadora(id)
);

# Cria tabela para contato de operadora
create table if not exists contato(
	id bigint auto_increment,
    ddd varchar(5),
    telefone varchar(50),
    fax varchar(50),
    endereco_eletronico varchar(100),
    operadora_id bigint,
    primary key(id),
    foreign key(operadora_id) references operadora(id)
);

# Cria tabela para representante de operadora
create table if not exists representante(
	id bigint auto_increment,
    nome_completo varchar(100),
    cargo varchar(100),
    regiao_comercial varchar(5),
    data_registro_ans date,
	operadora_id bigint,
    primary key(id),
    foreign key(operadora_id) references operadora(id)
);

# Carrega dados para operadora
load data 
	infile '/var/lib/mysql-files/Relatorio_cadop.csv' 
	into table operadora
    character set UTF8MB4
	fields terminated by ';'
	optionally enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (registro_ans, cnpj, razao_social, nome_fantasia, modalidade, 
    @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
    @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);

# Carrega dados para endereço de operadora
load data 
	infile '/var/lib/mysql-files/Relatorio_cadop.csv' 
	into table endereco
    character set UTF8MB4
	fields terminated by ';'
	optionally enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (@dummy, @dummy, @dummy, @dummy, @dummy, 
    logradouro, numero, complemento, bairro, cidade, uf, cep,
    @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);

# Carrega dados para contato de operadora
load data 
	infile '/var/lib/mysql-files/Relatorio_cadop.csv' 
	into table contato
    character set UTF8MB4
	fields terminated by ';'
	optionally enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (@dummy, @dummy, @dummy, @dummy, @dummy, 
    @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
    ddd, telefone, fax, endereco_eletronico,
    @dummy, @dummy, @dummy, @dummy);

# Carrega dados para representante de operadora
 load data 
	infile '/var/lib/mysql-files/Relatorio_cadop.csv' 
	into table representante
    character set UTF8MB4
	fields terminated by ';'
	optionally enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (@dummy, @dummy, @dummy, @dummy, @dummy, 
    @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
    @dummy, @dummy, @dummy, @dummy,
    nome_completo, cargo, regiao_comercial, @data_registro_ans)
    set data_registro_ans = cast(@data_registro_ans as date);

# Desabilita safe updates para atualizar FKs    
set sql_safe_updates = 0;

# Atualiza endereco FK
update endereco operadora
set operadora_id = operadora.id
where id = operadora.id;

# Atualiza contato FK
update contato operadora
set operadora_id = operadora.id
where id = operadora.id;

# Atualiza representante FK
update representante operadora
set operadora_id = operadora.id
where id = operadora.id;


# Cria tabela de dados do trimestre
create table if not exists dados_trimestre(
	id bigint auto_increment,
	data date,
    registro_ans varchar(50),
    cd_conta_contabil varchar(50),
    descricao varchar(200),
    vl_saldo_inicial varchar(100),
    vl_saldo_final varchar(100),
    primary key(id)
);

# Carrega dado do 1T2023
load data 
	infile '/var/lib/mysql-files/1T2023.csv' 
	into table dados_trimestre
    character set UTF8MB4
	fields terminated by ';'
	optionally enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (@data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    set data = cast(@data as date);

# Carrega dado do 2T2023
load data 
	infile '/var/lib/mysql-files/2T2023.csv' 
	into table dados_trimestre
    character set UTF8MB4
	fields terminated by ';'
	optionally enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (@data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    set data = cast(@data as date);

# Carrega dado do 3T2023
load data 
	infile '/var/lib/mysql-files/3T2023.csv' 
	into table dados_trimestre
    character set UTF8MB4
	fields terminated by ';'
	optionally enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (@data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    set data = cast(@data as date);

# Carrega dado do 4T2023
load data 
	infile '/var/lib/mysql-files/4T2023.csv' 
	into table dados_trimestre
    character set UTF8MB4
	fields terminated by ';'
	optionally enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (@data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    set data = cast(@data as date);

# Carrega dado do 1T2024
load data 
	infile '/var/lib/mysql-files/1T2024.csv' 
	into table dados_trimestre
    character set UTF8MB4
	fields terminated by ';'
	optionally enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (@data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    set data = cast(@data as date);

# Carrega dado do 2T2024
load data 
	infile '/var/lib/mysql-files/2T2024.csv' 
	into table dados_trimestre
    character set UTF8MB4
	fields terminated by ';'
	optionally enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (@data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    set data = cast(@data as date);
# Carrega dado do 3T2024
load data 
	infile '/var/lib/mysql-files/3T2024.csv' 
	into table dados_trimestre
    character set UTF8MB4
	fields terminated by ';'
	optionally enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (@data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    set data = cast(@data as date);

# Carrega dado do 4T2024
load data 
	infile '/var/lib/mysql-files/4T2024.csv' 
	into table dados_trimestre
    character set UTF8MB4
	fields terminated by ';'
	optionally enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (@data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    set data = cast(@data as date);

# -- QUERIES DE SELEÇÃO 3.5

# 10 operadoras com maiores despesas em "EVENTOS/ SINISTROS CONHECIDOS OU
# AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último trimestre?
select op.registro_ans, op.cnpj, op.razao_social from operadora op 
	inner join dados_trimestre dt
		on op.registro_ans = dt.registro_ans
	where dt.data = '2024-10-01' and dt.descricao = "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR"
    order by abs(dt.vl_saldo_inicial - dt.vl_saldo_final)
    limit 10;
    
# 10 operadoras com maiores despesas nessa categoria no último ano
select op.registro_ans, op.cnpj, op.razao_social from operadora op 
	inner join dados_trimestre dt
		on op.registro_ans = dt.registro_ans
	where (dt.data = '2024-10-01' or data = '2024-07-01' or data = '2024-04-01' ) and dt.descricao = "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR"
    order by abs(dt.vl_saldo_inicial - dt.vl_saldo_final)
    limit 10;
