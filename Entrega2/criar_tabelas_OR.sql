-- DROP TABLES --
DROP TABLE tab_destinatario
/
DROP TABLE tab_funcionario
/
DROP TABLE tab_fornecedor
/
DROP TABLE tab_carrinho
/
DROP TABLE tab_pedido
/
DROP TABLE tab_extravio
/


-- TABELAS --


-- Destinatario (13. CREATE TABLE OF)
CREATE TABLE tab_destinatario OF type_destinatario(
    CPF PRIMARY KEY,
    nome NOT NULL,
    endereco NOT NULL
);
/

-- Funcionario (14. WITH ROWID REFERENCES)
CREATE TABLE tab_funcionario OF type_funcionario(
    CPF PRIMARY KEY,
    nome NOT NULL,
    cargo NOT NULL,
    renda NOT NULL,
    data_de_admissao NOT NULL,
    supervisor WITH ROWID REFERENCES tab_funcionario
);
/

-- Fornecedor (20. NESTED TABLE)
CREATE TABLE tab_fornecedor OF type_fornecedor(
    CNPJ PRIMARY KEY,
    nome NOT NULL,
    endereco NOT NULL
)NESTED TABLE produtos_possuidos STORE AS produtos_do_fornecedor;
/

-- Carrinho
CREATE TABLE tab_carrinho OF type_carrinho(
    id PRIMARY KEY
)NESTED TABLE produtos_possuidos STORE AS produtos_do_carrinho;
/

-- Pedido
CREATE TABLE tab_pedido OF type_pedido(
    id PRIMARY KEY,
    destinatario_ped WITH ROWID REFERENCES tab_destinatario,
    entregador_ped WITH ROWID REFERENCES tab_funcionario,
    carrinho_ped WITH ROWID REFERENCES tab_carrinho,
    data_entrega NOT NULL,
    data_pedido NOT NULL,
    frete NOT NULL,
    forma_de_pagamento NOT NULL
);
/

-- Extravio
CREATE TABLE tab_extravio OF type_extravio(
    codigo PRIMARY KEY,
    justificativa NOT NULL,
    pedido_associado WITH ROWID REFERENCES tab_pedido NOT NULL
);
/
