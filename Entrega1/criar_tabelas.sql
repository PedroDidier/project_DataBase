CREATE TABLE pessoa ( 
    cpf VARCHAR(14), 
    nome VARCHAR(20) NOT NULL, 
    data_de_nascimento DATE, 

    PRIMARY KEY(cpf) 
);

CREATE TABLE cnpj_nome_empresa (
    cnpj VARCHAR(18),
    nome_da_empresa VARCHAR(30),
    
    PRIMARY KEY(cnpj)
);

CREATE TABLE endereco_destinatario (
    cep INT,
    rua VARCHAR(50),
    numero_do_imovel INT,
    complemento VARCHAR(20),
    
    PRIMARY KEY(cep)
);

CREATE TABLE endereco_fornecedor (
    cep INT,
    rua VARCHAR(50),
    numero_do_imovel INT,
    complemento VARCHAR(20),
    
    PRIMARY KEY(cep)
);

CREATE TABLE identificador_pedido (
    id_ INT,
    data_da_entrega DATE,
    forma_de_pagamento VARCHAR(10),
    data_do_pedido DATE,
    frete DECIMAL(7,2),
    
    PRIMARY KEY(id_)
);

CREATE TABLE telefone_pessoa (
    pessoa VARCHAR(14),
    numero_de_telefone INT,
    
    PRIMARY KEY(pessoa,numero_de_telefone),
    FOREIGN KEY(pessoa) REFERENCES pessoa(cpf)
);

CREATE TABLE telefone_fornecedor (
    fornecedor VARCHAR(18),
    numero_de_telefone INT,
    
    PRIMARY KEY(fornecedor,numero_de_telefone),
    FOREIGN KEY(fornecedor) REFERENCES fornecedor(cnpj)
);

CREATE TABLE extravio ( 
    codigo_do_extravio INT, 
    extraviado INT, 
    justificativa VARCHAR(50), 
     
    PRIMARY KEY(codigo_do_extravio),
    ADD FOREIGN KEY(extraviado) REFERENCES identificador_pedido(id_)
);

CREATE TABLE funcionario ( 
    cpf_p VARCHAR(14), 
    supervisionado_por VARCHAR(14),
    cargo VARCHAR(10),
    renda DECIMAL (7,2),
    data_de_admissao DATE,

    PRIMARY KEY(cpf_p),
    ADD FOREIGN KEY(cpf_p) REFERENCES pessoa(cpf),
    ADD FOREIGN KEY(supervisionado_por) REFERENCES funcionario(cpf_p)
);

CREATE TABLE destinatario ( 
    cpf_p VARCHAR(14), 
    cep INT NOT NULL, 
     
    PRIMARY KEY(cpf_p),
    ADD FOREIGN KEY(cpf_p) REFERENCES pessoa(cpf),
    ADD FOREIGN KEY(cep) REFERENCES endereco_destinatario(cep)
);

CREATE TABLE fornecedor (
    cnpj VARCHAR(18),
    cep INT NOT NULL,
    
    PRIMARY KEY(cnpj),
    ADD FOREIGN KEY(cnpj) REFERENCES cnpj_nome_empresa(cnpj),
    ADD FOREIGN KEY(cep) REFERENCES endereco_fornecedor(cep)
);

CREATE TABLE produto (
    cnpj_fornecedor VARCHAR(18),
    nome_do_produto VARCHAR(20),
    categoria VARCHAR(20),
    preco DECIMAL(7,2),
    quantidade INT,
    
    PRIMARY KEY(cnpj_fornecedor,nome_do_produto),
    ADD FOREIGN KEY(cnpj_fornecedor) REFERENCES fornecedor(cnpj)
);

CREATE TABLE pedido (
    cpf_d VARCHAR(14),
    cpf_e VARCHAR(14),
    cnpj_fornecedor_produto VARCHAR(18),
    nome_produto VARCHAR(30),
    id_ INT,
    
    PRIMARY KEY(cpf_d,cpf_e,cnpj_fornecedor_produto,nome_produto,id_),
    ADD FOREIGN KEY(cpf_d) REFERENCES destinatario(cpf_p),
    ADD FOREIGN KEY(cpf_e) REFERENCES funcionario(cpf_p),
    ADD FOREIGN KEY(cnpj_fornecedor_produto,nome_produto) REFERENCES produto(cnpj_fornecedor,nome_do_produto),
    ADD FOREIGN KEY(id_) REFERENCES identificador_pedido(id_)
);