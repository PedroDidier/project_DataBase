--- DROP TABLES ---

--- DROP TYPES --- 
DROP TYPE tp_arr_telefone
/
DROP TYPE tp_telefone
/
DROP TYPE tp_endereco
/
--- TIPOS ---

--endereço
CREATE OR REPLACE TYPE tp_endereco AS OBJECT(
    CEP VARCHAR(100),
    rua VARCHAR(100),
    complemento VARCHAR(100),
    numero NUMBER
);

/

--telefones
CREATE OR REPLACE TYPE tp_telefone AS OBJECT(
    numero VARCHAR(100)
);
/
CREATE OR REPLACE TYPE tp_arr_telefone AS VARRAY(5) OF tp_telefone;
/