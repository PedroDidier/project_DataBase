--- DROP TABLES ---

--- DROP TYPES --- 
DROP TYPE type_lista_de_telefones
/
DROP TYPE type_telefone
/
DROP TYPE type_endereco
/
--- TIPOS ---

--Endereço (1.CREATE OF REPLACE TYPE)
CREATE OR REPLACE TYPE type_endereco AS OBJECT(
    CEP VARCHAR(100),
    rua VARCHAR(100),
    complemento VARCHAR(100),
    numero VARCHAR(100)
);
/

--Telefone
CREATE OR REPLACE TYPE type_telefone AS OBJECT(
    numero VARCHAR(100)
);
/

--Lista de Telefones
CREATE OR REPLACE TYPE type_lista_de_telefones AS VARRAY(5) OF type_telefone;
/

--Pessoa (3. MEMBER PROCEDURE, 10. NOT INSTANTIABLE TYPE/MEMBER, 11. HERANÇA DE TIPOS (UNDER/NOT FINAL))
CREATE OR REPLACE TYPE type_pessoa AS OBJECT(
    CPF VARCHAR(11)
    nome VARCHAR(100),
    data_de_nascimento DATE,
    telefones type_lista_de_telefones,
    MEMBER PROCEDURE get_data
)NOT FINAL NOT INSTANTIABLE;
/

--Funcionario (2. CREATE OR REPLACE TYPE BODY, 6. MAP MEMBER FUNCTION, 8. OVERRIDING MEMBER, 15. REF, 16. SCOPE IS)
CREATE OR REPLACE TYPE type_funcionario UNDER type_pessoa(
    cargo VARCHAR(100),
    renda NUMBER,
    data_de_admissao DATE,
    supervisor REF type_funcionario,
    MAP MEMBER FUNCTION get_renda RETURN NUMBER,
    OVERRIDING MEMBER PROCEDURE get_data
)FINAL;
/ 

CREATE OR REPLACE BODY TYPE type_funcionario AS
    MAP MEMBER FUNCTION get_renda return NUMBER IS
    BEGIN
        return renda
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

--Destinatário (5. ORDER MEMBER FUNCTION)
CREATE OR REPLACE TYPE type_destinatario UNDER type_pessoa(
    endereco type_endereco,
    data_primeiro_pedido DATE, 
    OVERRIDING MEMBER PROCEDURE get_data
    ORDER MEMBER FUNCTION mais_antigo(SELF IN OUT NOCOPY type_destinatario, OTHER type_destinatario) RETURN BOOLEAN
)FINAL;
/

CREATE OR REPLACE BODY TYPE type_destinatario AS
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

    ORDER MEMBER FUNCTION mais_antigo(SELF IN OUT NOCOPY type_destinatario, OTHER type_destinatario) RETURN BOOLEAN IS
    BEGIN
        RETURN SELF.data_primeiro_pedido < OTHER.data_primeiro_pedido
    END;
END;
/

--Produto
CREATE OR REPLACE TYPE type_produto AS OBJECT(
    nome VARCHAR(100),
    quantidade NUMBER,
    categoria VARCHAR(100),
    preco NUMBER,
    cpnj_fornecedor VARCHAR(100)
)
/

CREATE OR REPLACE TYPE type_lista_de_produtos AS VARRAY(100) OF type_produto;
/

--Fornecedor (4. MEMBER FUNCTION, 9. FINAL MEMBER)
CREATE OR REPLACE TYPE type_fornecedor AS OBJECT(
    CNPJ VARCHAR(100),
    nome VARCHAR(100),
    telefones type_lista_de_telefones,
    endereco type_endereco,
    produtos_possuidos type_lista_de_produtos,
    MEMBER FUNCTION preco_medio
    FINAL MAP MEMBER FUNCTION quantidade_de_produtos return NUMBER
)
/


CREATE OR REPLACE TYPE BODY type_fornecedor AS
    MEMBER FUNCTION preco_medio IS
    BEGIN
        aux := 0;
        FOR elem in 1 .. produtos_possuidos.COUNT LOOP
            aux := aux + produtos_possuidos(elem).preco
        END LOOP;
        RETURN aux / produtos_possuidos.COUNT
    END;
END;
/

CREATE OR REPLACE TYPE BODY type_fornecedor AS
FINAL MAP MEMBER FUNCTION quantidade_de_produtos return NUMBER IS
    BEGIN
        RETURN COUNT_ELEMENTS(produtos_possuidos)
    END;
END;
/

--Carrinho (7. CONSTRUCTOR FUNCTION, 12. ALTER TYPE)
CREATE OR REPLACE TYPE type_carrinho AS OBJECT(
    id NUMBER,
    quantidade NUMBER,
    produtos_possuidos type_lista_de_produtos,
    MEMBER FUNCTION preco_total
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
    (SELF IN OUT NOCOPY type_carrinho, iid NUMBER, iquantidade NUMBER, iprodutos_possuidos type_lista_de_produtos)
    RETURN SELF AS RESULT IS
    BEGIN
        SELF.id := iid;
        SELF.quantidade := iquantidade;
        SELF.produtos_possuidos := iprodutos;
        SELF.quantidade_itens := iprodutos.COUNT;
        RETURN;
    END;
END;
/

--Pedido
CREATE OR REPLACE TYPE type_pedido AS OBJECT(
    id NUMBER,
    --PKs
    cpf_destinatario VARCHAR(11),
    cpf_entregador VARCHAR(11),
    id_carrinho NUMBER,
    --
    data_entrega DATE,
    data_pedido DATE,
    frete NUMBER,
    forma_de_pagamento CHAR
);
/

--Extravio
CREATE OR REPLACE TYPE type_extravio AS OBJECT(
    codigo NUMBER,
    justificativa VARCHAR(100),
    pedido_associado type_pedido
);
/
