-- DROP TABLES --
DROP TABLE tab_destinatario
/
DROP TABLE tab_funcionario
/
DROP TABLE tab_produto
/
DROP TABLE tab_fornecedor
/
DROP TABLE tab_carrinho
/
DROP TABLE tab_pedido
/
DROP TABLE tab_extravio
/

-- DROP TYPES -- 
DROP TYPE type_endereco
/
DROP TYPE type_telefone
/
DROP TYPE type_lista_de_telefone
/
DROP TYPE type_pessoa
/
DROP TYPE type_funcionario
/
DROP TYPE type_destinatario
/
DROP TYPE type_produto
/
DROP TYPE type_nt_produto
/
DROP TYPE type_fornecedor
/
DROP TYPE type_carrinho
/
DROP TYPE type_pedido
/
DROP TYPE type_extravio
/


-- TIPOS --


-- Endereço (1. CREATE OF REPLACE TYPE)
CREATE OR REPLACE TYPE type_endereco AS OBJECT(
    CEP VARCHAR(100),
    rua VARCHAR(100),
    complemento VARCHAR(100),
    numero VARCHAR(100)
);
/


-- Telefone
CREATE OR REPLACE TYPE type_telefone  AS OBJECT(
    numero VARCHAR(100)
);
/

CREATE OR REPLACE TYPE type_lista_de_telefone AS VARRAY(10) OF type_telefone;
/


-- Pessoa (3. MEMBER PROCEDURE, 10. NOT INSTANTIABLE TYPE/MEMBER, 11. HERANÇA DE TIPOS (UNDER/NOT FINAL))
CREATE OR REPLACE TYPE type_pessoa AS OBJECT(
    CPF VARCHAR(11),
    nome VARCHAR(100),
    data_de_nascimento DATE,
    telefones type_lista_de_telefone,
    MEMBER PROCEDURE get_data
)NOT FINAL NOT INSTANTIABLE;
/


-- Funcionario (2. CREATE OR REPLACE TYPE BODY, 6. MAP MEMBER FUNCTION, 8. OVERRIDING MEMBER, 15. REF, 16. SCOPE IS)
CREATE OR REPLACE TYPE type_funcionario UNDER type_pessoa(
    cargo VARCHAR(100),
    renda NUMBER,
    data_de_admissao DATE,
    supervisor REF type_funcionario,
    MEMBER FUNCTION get_renda RETURN NUMBER,
    OVERRIDING MEMBER PROCEDURE get_data
)FINAL;
/

CREATE OR REPLACE TYPE BODY type_funcionario AS
    MEMBER FUNCTION get_renda return NUMBER IS
    BEGIN
        RETURN renda
    END;


    OVERRIDING MEMBER PROCEDURE get_data IS
    BEGIN 
        DBMS_OUTPUT.Put_line('CPF: ' || CPF);
        DBMS_OUTPUT.Put_line('Nome: ' || nome);
        DBMS_OUTPUT.Put_line('Data de Nascimento: ' || data_de_nascimento);
        DBMS_OUTPUT.Put_line('Cargo: ' || cargo);
        DBMS_OUTPUT.Put_line('Renda: ' || TO_CHAR(renda));
        DBMS_OUTPUT.Put_line('Data de Admissão: ' || data_de_admissao);
    END;
END;
/


-- Destinatário (5. ORDER MEMBER FUNCTION)
CREATE OR REPLACE TYPE type_destinatario UNDER type_pessoa(
    endereco type_endereco,
    OVERRIDING MEMBER PROCEDURE get_data
)FINAL;
/

CREATE OR REPLACE TYPE BODY type_destinatario AS
    OVERRIDING MEMBER PROCEDURE get_data IS
    BEGIN
        DBMS_OUTPUT.Put_line('CPF: ' || CPF);
        DBMS_OUTPUT.Put_line('Nome: ' || nome);
        DBMS_OUTPUT.Put_line('Data de Nascimento: ' || data_de_nascimento);
        DBMS_OUTPUT.Put_line('-Endereço');
        DBMS_OUTPUT.Put_line('CEP: ' || endereco.CEP);
        DBMS_OUTPUT.Put_line('Rua: ' || endereco.rua);
        DBMS_OUTPUT.Put_line('Complemento: ' || endereco.complemento);
        DBMS_OUTPUT.Put_line('Número: ' || endereco.numero);
    END;
END;
/


-- Produto
CREATE OR REPLACE TYPE type_produto AS OBJECT(
    id NUMBER,
    nome VARCHAR(100),
    quantidade NUMBER,
    categoria VARCHAR(100),
    preco NUMBER,
    ORDER MEMBER FUNCTION mais_caro(SELF IN OUT NOCOPY type_produto, PROD type_produto) RETURN DECIMAL
);
/

CREATE OR REPLACE TYPE BODY type_produto AS
ORDER MEMBER FUNCTION mais_caro(SELF IN OUT NOCOPY type_produto, PROD type_produto) RETURN DECIMAL IS
    BEGIN
        IF SELF.preco < PROD.preco THEN
            RETURN -1;               
        ELSIF SELF.preco > PROD.preco THEN 
            RETURN 1;                
        ELSE 
            RETURN 0;
        END IF;
    END;
END;
/

CREATE OR REPLACE TYPE type_nt_produto AS TABLE OF type_produto;
/


-- Fornecedor (4. MEMBER FUNCTION, 9. FINAL MEMBER)
CREATE OR REPLACE TYPE type_fornecedor AS OBJECT(
    CNPJ VARCHAR(100),
    nome VARCHAR(100),
    telefones type_lista_de_telefone,
    endereco type_endereco,
    produtos_possuidos type_nt_produto,
    MEMBER FUNCTION preco_medio RETURN NUMBER,
    FINAL MAP MEMBER FUNCTION quantidade_de_telefones RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY type_fornecedor AS
    MEMBER FUNCTION preco_medio IS
    BEGIN
        RETURN SELECT AVG(preco) FROM produtos_possuidos
    END;
END;
/

CREATE OR REPLACE TYPE BODY type_fornecedor AS
FINAL MAP MEMBER FUNCTION quantidade_de_telefones return NUMBER IS
    BEGIN
        RETURN COUNT_ELEMENTS(telefones)
    END;
END;
/


-- Carrinho (7. CONSTRUCTOR FUNCTION, 12. ALTER TYPE)
CREATE OR REPLACE TYPE type_carrinho AS OBJECT(
    id NUMBER,
    produtos_possuidos type_nt_produto,
    MEMBER FUNCTION preco_total RETURN NUMBER
);
/

ALTER TYPE type_carrinho ADD ATTRIBUTE (quantidade_itens NUMBER)CASCADE;
/

CREATE OR REPLACE TYPE BODY type_carrinho AS
FINAL MAP MEMBER FUNCTION preco_total return NUMBER IS
    BEGIN
        aux := 0;
        FOR elem in 1 .. produtos_possuidos.COUNT LOOP
            aux := aux + produtos_possuidos(elem).preco
        END LOOP;
        RETURN aux
    END;
END;
/

CREATE OR REPLACE TYPE BODY type_carrinho AS
    CONSTRUCTOR FUNCTION type_carrinho
    (SELF IN OUT NOCOPY type_carrinho, iid NUMBER, iprodutos_possuidos type_nt_produto)
    RETURN SELF AS RESULT IS
    BEGIN
        SELF.id := iid;
        SELF.produtos_possuidos := iprodutos;
        SELF.quantidade_itens := SELECT COUNT(*) FROM type_nt_produto;
        RETURN;
    END;
END;
/


-- Pedido
CREATE OR REPLACE TYPE type_pedido AS OBJECT(
    id NUMBER,
    --PKs
    destinatario_ped REF type_destinatario,
    entregador_ped REF type_funcionario,
    carrinho_ped REF type_carrinho,
    --
    data_entrega DATE,
    data_pedido DATE,
    frete NUMBER,
    forma_de_pagamento CHAR
);
/


-- Extravio
CREATE OR REPLACE TYPE type_extravio AS OBJECT(
    codigo NUMBER,
    justificativa VARCHAR(100),
    pedido_associado REF type_pedido
);
/
