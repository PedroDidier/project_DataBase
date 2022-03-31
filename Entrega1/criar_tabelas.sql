DROP TABLE pessoa;
DROP TABLE cnpj_nome_empresa;
DROP TABLE endereco_destinatario;
DROP TABLE endereco_fornecedor;
DROP TABLE identificador_pedido;
DROP TABLE telefone_pessoa;
DROP TABLE extraviado;
DROP TABLE funcionario;
DROP TABLE destinatario;
DROP TABLE fornecedor;
DROP TABLE produto;
DROP TABLE telefone_fornecedor;
DROP TABLE pedido;

CREATE TABLE pessoa ( 
    cpf VARCHAR(14), 
    nome VARCHAR(20) NOT NULL, 
    data_de_nascimento DATE, 

    CONSTRAINT pessoa_pk PRIMARY KEY(cpf) 
);

CREATE TABLE cnpj_nome_empresa (
    cnpj VARCHAR(18),
    nome_da_empresa VARCHAR(30),
    
    CONSTRAINT cnpj_pk PRIMARY KEY(cnpj)
);

CREATE TABLE endereco_destinatario (
    cep VARCHAR(9),
    rua VARCHAR(50),
    numero_do_imovel INT,
    complemento VARCHAR(20),
    
    CONSTRAINT endereco_destinatario_pk PRIMARY KEY(cep)
);

CREATE TABLE endereco_fornecedor (
    cep VARCHAR(9),
    rua VARCHAR(50),
    numero_do_imovel INT,
    complemento VARCHAR(20),
    
    CONSTRAINT endereco_fornecedor_pk PRIMARY KEY(cep)
);

CREATE TABLE identificador_pedido (
    id_ INT,
    data_da_entrega DATE,
    forma_de_pagamento VARCHAR(10),
    data_do_pedido DATE,
    frete DECIMAL(7,2),
    
    CONSTRAINT identificador_pedido_pk PRIMARY KEY(id_)
);

CREATE TABLE extravio (
    codigo_do_extravio INT,
    extraviado INT,
    justificativa VARCHAR(50),
    
    CONSTRAINT extravio_pk PRIMARY KEY(codigo_do_extravio),
    CONSTRAINT extraviado_fk FOREIGN KEY(extraviado) REFERENCES identificador_pedido(id_)
);

CREATE TABLE telefone_pessoa (
    pessoa VARCHAR(14),
    numero_de_telefone VARCHAR(11),
    
    CONSTRAINT telefone_pessoa_pk PRIMARY KEY(pessoa,numero_de_telefone),
    CONSTRAINT telefone_pessoa_cpf_fk FOREIGN KEY(pessoa) REFERENCES pessoa(cpf)
);

CREATE TABLE funcionario ( 
    cpf_p VARCHAR(14), 
    supervisionado_por VARCHAR(14),
    cargo VARCHAR(64),
    renda DECIMAL (7,2) CHECK (renda > 506.50),
    data_de_admissao DATE,

    CONSTRAINT funcionario_pk PRIMARY KEY(cpf_p),
    CONSTRAINT funcionario_cpf_fk FOREIGN KEY(cpf_p) REFERENCES pessoa(cpf),
    CONSTRAINT supervisionado_por_fk FOREIGN KEY(supervisionado_por) REFERENCES funcionario(cpf_p)
);

CREATE TABLE destinatario ( 
    cpf_p VARCHAR(14), 
    cep VARCHAR(9) NOT NULL, 
     
    CONSTRAINT destinatario_pk PRIMARY KEY(cpf_p),
    CONSTRAINT destinatario_cpf_fk FOREIGN KEY(cpf_p) REFERENCES pessoa(cpf),
    CONSTRAINT destinatario_cep_fk FOREIGN KEY(cep) REFERENCES endereco_destinatario(cep)
);

CREATE TABLE fornecedor (
    cnpj VARCHAR(18),
    cep VARCHAR(9) NOT NULL,
    
    CONSTRAINT fornecedor_pk PRIMARY KEY(cnpj),
    CONSTRAINT fornecedor_cnpj_fk FOREIGN KEY(cnpj) REFERENCES cnpj_nome_empresa(cnpj),
    CONSTRAINT fornecedor_cep_fk FOREIGN KEY(cep) REFERENCES endereco_fornecedor(cep)
);

CREATE TABLE produto (
    cnpj_fornecedor VARCHAR(18),
    nome_do_produto VARCHAR(30),
    categoria VARCHAR(20),
    preco DECIMAL(7,2) CHECK (preco > 0.00),
    quantidade INT CHECK (quantidade >= 0),
    
    CONSTRAINT produto_pk PRIMARY KEY(cnpj_fornecedor,nome_do_produto),
    CONSTRAINT produto_fornecedor_cnpj_fk FOREIGN KEY(cnpj_fornecedor) REFERENCES fornecedor(cnpj)
);

CREATE TABLE telefone_fornecedor (
    fornecedor VARCHAR(18),
    numero_de_telefone INT,
    
    CONSTRAINT telefone_fornecedor_pk PRIMARY KEY(fornecedor,numero_de_telefone),
    CONSTRAINT telefone_fornecedor_cnpj_fk FOREIGN KEY(fornecedor) REFERENCES fornecedor(cnpj)
);

CREATE TABLE pedido (
    cpf_d VARCHAR(14),
    cpf_e VARCHAR(14),
    cnpj_fornecedor_produto VARCHAR(18),
    nome_produto VARCHAR(30),
    id_ INT,
    
    CONSTRAINT pedido_pk PRIMARY KEY(cpf_d,cpf_e,cnpj_fornecedor_produto,nome_produto,id_),
    CONSTRAINT pedido_cpf_d_fk FOREIGN KEY(cpf_d) REFERENCES destinatario(cpf_p),
    CONSTRAINT pedido_cpf_e_fk FOREIGN KEY(cpf_e) REFERENCES funcionario(cpf_p),
    CONSTRAINT pedido_fornecedor_fk FOREIGN KEY(cnpj_fornecedor_produto,nome_produto) REFERENCES produto(cnpj_fornecedor,nome_do_produto),
    CONSTRAINT pedido_id_fk FOREIGN KEY(id_) REFERENCES identificador_pedido(id_)
);