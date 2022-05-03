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

--Pessoa (3. MEMBER PROCEDURE)
CREATE OR REPLACE TYPE type_pessoa AS OBJECT(
    CPF VARCHAR(11)
    nome VARCHAR(100),
    data_de_nascimento DATE,
    telefones type_lista_de_telefones,
    MEMBER PROCEDURE get_data
)
/

--Funcionario (2. CREATE OR REPLACE TYPE BODY, 6. MAP MEMBER FUNCTION, 8. OVERRIDING MEMBER & 15. REF)
CREATE OR REPLACE TYPE type_funcionario UNDER type_pessoa(
    cargo VARCHAR(100),
    renda NUMBER,
    data_de_admissao DATE,
    supervisor REF type_funcionario,
    MAP MEMBER FUNCTION get_renda RETURN NUMBER,
    OVERRIDING MEMBER PROCEDURE get_data
)
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

--Destinatário (5. ORDER MEMBER FUNCTION)
CREATE OR REPLACE TYPE type_destinatario UNDER type_pessoa(
    endereco type_endereco,
    data_primeiro_pedido DATE, --*****
    OVERRIDING MEMBER PROCEDURE get_data
    ORDER MEMBER FUNCTION mais_antigo(SELF IN OUT NOCOPY type_destinatario, OTHER type_destinatario) RETURN BOOLEAN
)
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
    preco NUMBER
)
/

CREATE OR REPLACE TYPE type_lista_de_produtos AS VARRAY(100) OF type_produto;
/

--Fornecedor (4. MEMBER FUNCTION)
CREATE OR REPLACE TYPE type_fornecedor AS OBJECT(
    CNPJ VARCHAR(100),
    nome VARCHAR(100),
    telefones type_lista_de_telefones,
    endereco type_endereco,
    produtos_possuidos type_lista_de_produtos,
    MEMBER FUNCTION preco_medio
)
/


CREATE OR REPLACE TYPE BODY type_fornecedor AS
    MEMBER FUNCTION preco_medio IS
    BEGIN
        aux := 0;
        FOR elem in 1 .. produtos_possuidos.COUNT LOOP
            aux := aux + elem.preco
        END LOOP;
        RETURN aux / produtos_possuidos.COUNT
    END;
END;
