/* 1.USO DE RECORD & 3.BLOCO ANÔNIMO */
/* Criar um RECORD com estrutura igual à de Pessoa, instanciar um exemplo e inserí-lo na tabela */

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

/* 2.ESTRUTURA TIPO TABLE, 7.%ROWTYPE, 8.IF ELSIF & 12. FOR IN LOOP */
/* Declararemos uma lista de linhas de funcionario e checaremos se alguém está recebendo menos do que deveria
 Além disso checamos se a pessoa é o CEO e adicionamos à fila com um salário modificado */

DECLARE TYPE linha_de_funcionario IS TABLE OF funcionario%ROWTYPE;

lista linha_de_funcionario := linha_de_funcionario();

BEGIN

    FOR empregado IN (SELECT * FROM funcionario F) LOOP

        lista.EXTEND;

		IF empregado.renda < 1000 THEN

            lista(lista.LAST).cpf_p := empregado.cpf_p;
            lista(lista.LAST).renda := empregado.renda;

		ELSIF empregado.cargo LIKE 'CEO%' THEN

			lista(lista.LAST).cpf_p := empregado.cpf_p;
			lista(lista.LAST).renda := 50000.50;

		END IF;
        
    END LOOP;

END;

/* 4. CREATE PROCEDURE + 6.%TYPE + 9.CASE WHEN + 17.CREATE OR RECPLACE PACKAGE + 18.CREATE OR RECPLACE PACKAGE BODY */
/* PACKAGE de procedimentos de aumento. Procedure para aumento de gerentes e CEOs e um para aumento de faxineiros e entregadores */

CREATE OR REPLACE PACKAGE aumentos AS
    PROCEDURE aumento_lideres(
        gerente_renda funcionario.renda%TYPE,
        ceo_renda funcionario.renda%TYPE
    );
    PROCEDURE aumento_trabalhadores(
        entregador_renda funcionario.renda%TYPE,
        faxineiro_renda funcionario.renda%TYPE
    );
END aumentos;

CREATE OR REPLACE PACKAGE BODY aumentos AS
    PROCEDURE aumento_lideres ( gerente_renda funcionario.renda%TYPE, ceo_renda funcionario.renda%TYPE) IS 
    BEGIN
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
    
    END aumento_lideres;

    

    PROCEDURE aumento_trabalhadores(entregador_renda funcionario.renda%TYPE, faxineiro_renda funcionario.renda%TYPE) IS 
    BEGIN
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

    END aumento_trabalhadores;
    
END aumentos;
/* 5.CREATE FUNCTION, 10.LOOP EXIT WHEN, 14.CURSOR (OPEN,FETCH e CLOSE) + 15.EXCEPTION WHEN */
/* Função que retorna o valor mais barato de um produto de uma categoria X (input), e imprime todos os outros */

CREATE OR REPLACE TYPE infos_prod IS OBJECT(
    nome_item VARCHAR(30),
    preco DECIMAL(7,2),
    quantidade INT
);
CREATE OR REPLACE FUNCTION consultar_produto (categoria_prod produto.categoria%TYPE)
    RETURN infos_prod IS
    
    infos_do_produto infos_prod;

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

/* 11.While LOOP & 16.Uso de Parâmetros IN, OUT ou IN OUT */
/* Faz um "print" de uma frase indicando os funcionários que entregaram os produtos 
"Livro Harry potter" e "Caneta bic" com seus respectivos CPFs */
DECLARE
    cnt INTEGER;
    q INTEGER;
    aux_nome pedido.nome_produto%TYPE;
    aux_cpf pedido.cpf_e%TYPE;
    aux_n pessoa.nome%TYPE;
    iter INT;    
BEGIN
    iter := 1;
    cnt := 0;
    SELECT COUNT(*) INTO q FROM pedido;
    WHILE iter <= q LOOP
        
        SELECT p.nome_produto INTO aux_nome
        FROM pedido p
        WHERE p.id_ = iter;
        
        SELECT p.cpf_e INTO aux_cpf
        FROM pedido p
        WHERE p.id_ = iter;

        IF aux_nome IN ('Livro Harry potter', 'Caneta bic') THEN
            SELECT p.nome INTO aux_n
            FROM pessoa p
            WHERE p.cpf = aux_cpf;
            DBMS_OUTPUT.PUT_LINE(''||aux_n||' '||aux_cpf||'');
        END IF;

        iter := iter + 1;

    END LOOP;
END;