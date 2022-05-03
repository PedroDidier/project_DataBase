--DROP TABLES-------------------------------------------------------------

--Destinatario
CREATE TABLE tab_destinatario OF type_destinatario(
    CPF PRIMARY KEY,
    nome NOT NULL,
    endereco NOT NULL
)NESTED TABLE telefones STORE AS lista_telefones;
/

--Funcionario
CREATE TABLE tab_funcionario OF type_funcionario(
    CPF PRIMARY KEY,
    nome NOT NULL,
    cargo NOT NULL,
    renda NOT NULL,
    data_de_admissao NOT NULL,
    supervisor WITH ROWID REFERENCES tab_funcionario
)NESTED TABLE telefones STORE AS lista_telefones;
/

--Fornecedor
CREATE TABLE tab_fornecedor OF type_fornecedor(
    CNPJ PRIMARY KEY,
    nome NOT NULL,
    endereco NOT NULL
)NESTED TABLE telefones STORE AS lista_telefones;
/

--Carrinho
CREATE TABLE tab_carrinho OF type_carrinho(
    id PRIMARY KEY
);
/

--Pedido
CREATE TABLE tab_pedido OF type_pedido(
    id NOT NULL,
    -- PKs
    destinatario_ped WITH ROWID REFERENCES tab_destinatario,
    entregador_ped WITH ROWID REFERENCES tab_funcionario,
    carrinho_ped WITH ROWID REFERENCES tab_carrinho,
    data_entrega NOT NULL,
    data_pedido NOT NULL,
    frete NOT NULL,
    forma_de_pagamento NOT NULL,
    
    -- PK declaration
    PRIMARY KEY(destinatario_ped,entregador_ped,carrinho_ped)
);
/

--Extravio
CREATE TABLE tab_extravio OF type_extravio(
    codigo PRIMARY KEY,
    justificativa NOT NULL,
    pedido_associado WITH ROWID REFERENCES tab_pedido NOT NULL,
);
/