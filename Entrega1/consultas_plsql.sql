-- 1.USO DE RECORD + 3.BLOCO ANÔNIMO
-- Vamos utilizar o RECORD para criar um record type_pessoa e a inserir
DECLARE TYPE type_pessoa IS RECORD(
    cpf varchar(14),
    nome varchar(20),
    data_de_nascimento DATE
);
pessoa_1 type_pessoa;
BEGIN
    pessoa_1.cpf := '000.000.000-00';
    pessoa_1.nome := 'Paulo Melo';
    pessoa_1.data_de_nascimento := to_date('06/06/1980','dd/mm/yyyy');
    INSERT INTO pessoa VALUES pessoa_1;
END;



-- 2.ESTRUTURA TIPO TABLE + 7.%ROWTYPE + 8.IF ELSIF + 12. FOR IN LOOP
-- Declararemos uma lista de linhas de funcionario e checaremos se alguém está recebendo menos do que deveria
-- Além disso checamos se a pessoa é o CEO e adicionamos à fila com um salário modificado
DECLARE TYPE linha_de_funcionario IS TABLE OF funcionario%ROWTYPE;

lista linha_de_funcionario := linha_de_funcionario();

BEGIN

    FOR empregado IN (SELECT * FROM funcionario F) LOOP

        lista.EXTEND;

		IF empregado.renda < 1000 THEN

            lista(lista.LAST).cpf_p := individuo.cpf_p;
            lista(lista.LAST).renda := individuo.renda;

		ELSIF individuo.cargo LIKE 'CEO%' THEN

			lista(lista.LAST).cpf_p := cpf_p;
			lista(lista.LAST).renda := 50000.50;

		END IF;
        
    END LOOP;

END;



-- 4. CREATE PROCEDURE + 6.%TYPE + 9.CASE WHEN + 17.CREATE OR RECPLACE PACKAGE + 18.CREATE OR RECPLACE PACKAGE BODY
-- PACKAGE de procedimentos de aumento. Procedure para aumento de gerentes e CEOs e um para aumento de faxineiros e entregadores
CREATE OR REPLACE PACKAGE aumentos AS
    PROCEDURE aumento_lideres(
        gerente_renda := funcionario.renda%TYPE;
        ceo_renda := funcionario.renda%TYPE;
    );
    PROCEDURE aumento_trabalhadores(
        entregador_renda := funcionario.renda%TYPE;
        faxineiro_renda := funcionario.renda%TYPE;
    );
END aumentos;

CREATE OR REPLACE PACKAGE BODY aumentos AS
    PROCEDURE ROCEDURE aumento_lideres(
        gerente_renda := funcionario.renda%TYPE;
        ceo_renda := funcionario.renda%TYPE;
    ) 
        IS BEGIN
            FOR empregado IN (SELECT * FROM funcionario F) LOOP

                CASE empregado.cargo
                    WHEN 'Gerente' THEN
                        empregado.renda := gerente_renda;
                    WHEN 'CEO' THEN
                        empregado.renda := ceo_renda;
                    ELSE
                        empregado.renda := empregado.renda + 100;
                END CASE;

            END LOOP;

        END;

    END aumento_lideres;

    PROCEDURE ROCEDURE aumento_trabalhadores(
        entregador_renda := funcionario.renda%TYPE;
        faxineiro_renda := funcionario.renda%TYPE;
    ) 
        IS BEGIN
            FOR empregado IN (SELECT * FROM funcionario F) LOOP

                CASE empregado.cargo
                    WHEN 'Entregador' THEN
                        empregado.renda := entregador_renda;
                    WHEN 'Faxineiro' THEN
                        empregado.renda := faxineiro_renda;
                    ELSE
                        empregado.renda := empregado.renda + 0;
                END CASE;

            END LOOP;

        END;
        
    END aumento_trabalhadores;

END aumentos;



-- 5.CREATE FUNCTION + 10.LOOP EXIT WHEN + 14.CURSOR (OPEN,FETCH e CLOSE) + EXCEPTION WHEN
-- Função que retorna o valor mais barato de um produto de uma categoria X (input), e imprime todos os outros
DECLARE
    TYPE infos_prod IS RECORD(
        nome_item VARCHAR(30),
        preco DECIMAL(7,2),
        quantidade INT
    );

CREATE OR REPLACE FUNCTION consultar_produto
    (categoria_prod produto.categoria%TYPE)
    RETURN infos_prod AS infos_do_produto

    CURSOR cursor_produto IS
        SELECT P.nome_do_produto, P.preco, P.quantidade
        FROM produto P
        WHERE P.categoria = categoria_prod
        ORDER BY preco DESC;

    BEGIN
        OPEN cursor_produto;
            LOOP
                FETCH cursor_produto INTO infos_do_produto.nome_item, infos_do_produto.preco, infos_do_produto.quantidade;
                EXIT WHEN cursor_produto%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE('Informações do produto (Nome,Preço (BRL), Quant.):' || ' ' || 
                TO_CHAR(infos_do_produto.nome_item) || ' ' || 
                TO_CHAR(infos_do_produto.preco) || ' ' || 
                TO_CHAR(infos_do_produto.quantidade));
            END LOOP;
        CLOSE cursor_produto;
        RETURN infos_do_produto;

        EXCEPTION
            WHEN INVALID_CURSOR THEN
                infos_do_produto.nome_item := ' ';
                infos_do_produto.preco := 0.00;
                infos_do_produto.quantidade := 0;
                RETURN infos_do_produto;

END consultar_produto;



-- 11.While LOOP + 16.Uso de Parâmetros IN, OUT ou  IN OUT
-- Bloco de codigo que checa quantos pedidos existem com um produto de livro ou papelaria
DECLARE
    cnt INTEGER;
    i INTEGER;
    q INTEGER;
    aux_nome pedido.nome_produto%TYPE;
    aux_empresa pedido.cnpj_fornecedor_produto%TYPE;
    aux_cat produto.nome%TYPE;
    aux_q produto.quantidade%TYPE;

BEGIN
    aux_count := 0;
    i := 1;
    SELECT COUNT(*) INTO q FROM produto;
    WHILE i <= q LOOP

        SELECT x.nome_produto INTO aux_nome
        FROM pedido x
        WHERE x.id_ = i;

        SELECT y.cnpj_fornecedor_produto INTO aux_empresa
        FROM pedido y
        WHERE y.id_ = i;

        SELECT z.categoria INTO aux_cat
        FROM produto z
        WHERE z.cnpj_fornecedor = aux_empresa
        AND z.nome_do_produto = aux_nome

        IF aux_cat in ('Livro','Papelaria') THEN

            SELECT z.categoria INTO aux_q
            FROM produto k
            WHERE k.cnpj_fornecedor = aux_empresa
            AND k.nome_do_produto = aux_nome
            AND k.categoria = aux_cat

            cnt := cnt + aux_q;
        END IF;

        i := i + 1;

    END LOOP;
    DBMS_OUTPUT.PUT_LINE('A transportadora está transportando '|| cnt || ' produto(s) de livro ou papelaria');
END aux1;



-- 13.Select INTO + 19.Create or replace trigger (comando)
-- Cria um trigger que alerta quantos produtos já foram registrados na transportadora
CREATE OR REPLACE TRIGGER produto_repetido
    BEFORE INSERT ON produto
        DECLARE produtos INTEGER;
    BEGIN
        SELECT COUNT(*) INTO produtos
        FROM produto;

        produtos := produtos + 1;

        DBMS_OUTPUT.PUT_LINE('A transportadora possui acesso a '|| produtos || ' produto(s)');
    END;


    
-- 20.Create or replace trigger (linha)
-- Cria um trigger que levanta uma exception quando se tenta deletar o CEO da empresa
CREATE OR REPLACE TRIGGER delceo
    BEFORE DELETE ON funcionario
        FOR EACH ROW
            DECLARE deletar_CEO EXCEPTION;
            BEGIN
                IF :OLD.cargo='CEO' THEN
                    RAISE deletar_ceo;
                END IF;
            EXCEPTION
                WHEN deletar_ceo THEN
                    RAISE_APPLICATION_ERROR(-20011, 'Nao se pode deletar um CEO da empresa.');
            END;