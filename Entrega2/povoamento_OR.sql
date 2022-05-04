CREATE SEQUENCE seq_carrinho INCREMENT by 1 START WITH 1; 
/
CREATE SEQUENCE seq_pedido INCREMENT by 1 START WITH 1; 
/

-- Destinatário (17. INSERT INTO, 18. VALUE)
INSERT INTO tab_destinatario VALUES(
    type_destinatario(
        '11132342152',
        'Ricardo Soares',
        to_date('06/02/2001', 'dd/mm/yyyy'),
        type_lista_de_telefone(type_telefone('987225600')),
        type_endereco(
            '52020304',
            'Rua das Flores',
            NULL,
            '221'
        )
    )
);
/

INSERT INTO tab_destinatario VALUES(
    type_destinatario(
        '13421452212',
        'Barney Stinson',
        to_date('06/12/1990', 'dd/mm/yyyy'),
        type_lista_de_telefone(type_telefone('987210550')),
        type_endereco(
            '52020333',
            'Rua das Abóboras',
            NULL,
            '1451'
        )
    )
);
/

INSERT INTO tab_destinatario VALUES(
    type_destinatario(
        '13421454442',
        'Arthur Cassimiro',
        to_date('23/11/1999', 'dd/mm/yyyy'),
        type_lista_de_telefone(type_telefone('983330550')),
        type_endereco(
            '52022233',
            'Avenida das Rosas',
            'apt501',
            '222'
        )
    )
);
/

INSERT INTO tab_destinatario VALUES(
    type_destinatario(
        '13421455312',
        'Bruno Martins',
        to_date('16/05/2000', 'dd/mm/yyyy'),
        type_lista_de_telefone(type_telefone('983330550')),
        type_endereco(
            '52021133',
            'Rua das Linhas',
            'apt1001',
            '602'
        )
    )
);
/

INSERT INTO tab_destinatario VALUES(
    type_destinatario(
        '13567455312',
        'Bruna Mendes',
        to_date('21/08/2000', 'dd/mm/yyyy'),
        type_lista_de_telefone(type_telefone('983322550')),
        type_endereco(
            '52881133',
            'Rua das Portas',
            'apt902',
            '402'
        )
    )
);
/


-- Funcionário

INSERT INTO tab_funcionario VALUES(
    type_funcionario(
        '11111111111',
        'Pedro Lemos',
        to_date('06/09/2001', 'dd/mm/yyyy'),
        type_lista_de_telefone(type_telefone('987210600')),
        'Entregador Chefe',
        7000,
        to_date('06/01/2020', 'dd/mm/yyyy'),
        null
    )
);
/

INSERT INTO tab_funcionario VALUES(
    type_funcionario(
        '11111111112',
        'Pedro Didier',
        to_date('12/05/2001', 'dd/mm/yyyy'),
        type_lista_de_telefone(type_telefone('987210601')),
        'Entregador',
        4500,
        to_date('09/01/2020', 'dd/mm/yyyy'),
        (SELECT REF(F) FROM tab_funcionario F WHERE F.CPF ='11111111111')
    )
);
/

INSERT INTO tab_funcionario VALUES(
    type_funcionario(
        '11111111113',
        'Nilo Drummond',
        to_date('05/11/2000', 'dd/mm/yyyy'),
        type_lista_de_telefone(type_telefone('987210602')),
        'Entregador',
        4500,
        to_date('12/01/2020', 'dd/mm/yyyy'),
        null
    )
);
/

INSERT INTO tab_funcionario VALUES(
    type_funcionario(
        '11111111114',
        'Charles Gabriel',
        to_date('25/04/2000', 'dd/mm/yyyy'),
        type_lista_de_telefone(type_telefone('987210603')),
        'CEO',
        17000,
        to_date('16/01/2020', 'dd/mm/yyyy'),
        null
    )
);
/

INSERT INTO tab_funcionario VALUES(
    type_funcionario(
        '11111111115',
        'Antonio Guimaraes',
        to_date('21/01/1980', 'dd/mm/yyyy'),
        type_lista_de_telefone(type_telefone('987210604')),
        'Entregador',
        4500,
        to_date('12/06/2021', 'dd/mm/yyyy'),
        (SELECT REF(F) FROM tab_funcionario F WHERE F.CPF ='11111111111')
    )
);
/

-- Fornecedor
INSERT INTO tab_fornecedor VALUES(
    type_fornecedor(
        '1111',
        'Máquina de Monstro',
        type_lista_de_telefone(type_telefone('81999997777')),
        type_endereco(
            '43381133',
            'Rua do Silvio',
            NULL,
            '406'
        ),
        type_nt_produto()
    )
);
/

INSERT INTO tab_fornecedor VALUES(
    type_fornecedor(
        '2222',
        'PickCells',
        type_lista_de_telefone(
            type_telefone('81999998888'),
            type_telefone('8132254361' )
        ),
        type_endereco(
            '42881133',
            'Rua do Paguso',
            NULL,
            '2201'
        ),
        type_nt_produto()
    )
);
/

INSERT INTO tab_fornecedor VALUES(
    type_fornecedor(
        '3333',
        'Kabum',
        type_lista_de_telefone(type_telefone('81999996666')),
        type_endereco(
            '42822133',
            'Rua da Valeria',
            NULL,
            '2468'
        ),
        type_nt_produto()
    )
);
/


/* Produto
Maquina de monstrons, inicial da ID = 110 */
INSERT INTO tab_produto VALUES(
    type_produto(
        1101,
        'Whey protein Super',
        51,
        'Suplemento',
        110.50
    )
);
/

INSERT INTO tab_produto VALUES(
    type_produto(
        1102,
        'Chocolate light com Whey',
        103,
        'Doce Fit',
        5.90
    )
);
/

INSERT INTO tab_produto VALUES(
    type_produto(
        1103,
        'Anilha 2kg',
        15,
        'Equipamento de treino',
        49.90
    )
);
/

INSERT INTO tab_produto VALUES(
    type_produto(
        1104,
        'Anilha 5kg',
        9,
        'Equipamento de treino',
        69.90
    )
);
/

INSERT INTO tab_produto VALUES(
    type_produto(
        1105,
        'Anilha 8kg',
        6,
        'Equipamento de treino',
        89.90
    )
);
/

UPDATE tab_fornecedor M
SET M.produtos_possuidos = type_nt_produto (
type_e_produto((SELECT REF(P) FROM tab_produto P WHERE P.id=1101)),
type_e_produto((SELECT REF(P) FROM tab_produto P WHERE P.id=1102)),
type_e_produto((SELECT REF(P) FROM tab_produto P WHERE P.id=1103)),
type_e_produto((SELECT REF(P) FROM tab_produto P WHERE P.id=1104)),
type_e_produto((SELECT REF(P) FROM tab_produto P WHERE P.id=1105))
)
WHERE M.CNPJ = '1111';
/

-- PickCells, inicial da ID = 220
INSERT INTO tab_produto VALUES(
    type_produto(
        2201,
        'Microscopio automatizado',
        10,
        'Hardware',
        50000.00
    )
);
/

INSERT INTO tab_produto VALUES(
    type_produto(
        2202,
        'Software para identificacao de parasitos em exames parasitologicos',
        1000,
        'Software/IA',
        100000.00
    )
);
/

INSERT INTO tab_produto VALUES(
    type_produto(
        2203,
        'Manual de construcao de DataLake',
        27,
        'PDF',
        20000.00
    )
);
/

UPDATE tab_fornecedor pick
SET pick.produtos_possuidos = type_nt_produto (
type_e_produto((SELECT REF(P) FROM tab_produto P WHERE P.id=2201)),
type_e_produto((SELECT REF(P) FROM tab_produto P WHERE P.id=2202)),
type_e_produto((SELECT REF(P) FROM tab_produto P WHERE P.id=2203))
)
WHERE pick.CNPJ = '2222';
/

-- Kabum, inicial da ID = 330
INSERT INTO tab_produto VALUES(
    type_produto(
        3301,
        'Fone Razer',
        20,
        'Fone Gamer',
        2000.00
    )
);
/

INSERT INTO tab_produto VALUES(
    type_produto(
        3302,
        'Fone Corsair',
        17,
        'Fone Gamer',
        1000.00
    )
);
/

INSERT INTO tab_produto VALUES(
    type_produto(
        3303,
        'Teclado Razer',
        37,
        'Teclado Gamer',
        500.00
    )
);
/

INSERT INTO tab_produto VALUES(
    type_produto(
        3304,
        'Teclado Corsair',
        12,
        'Teclado Gamer',
        250.00
    )
);
/

INSERT INTO tab_produto VALUES(
    type_produto(
        3305,
        'Mouse Razer',
        8,
        'Mouse Gamer',
        600.00
    )
);
/

INSERT INTO tab_produto VALUES(
    type_produto(
        3306,
        'Mouse Corsair',
        6,
        'Mouse Gamer',
        300.00
    )
);
/

UPDATE tab_fornecedor K
SET K.produtos_possuidos = type_nt_produto (
type_e_produto((SELECT REF(P) FROM tab_produto P WHERE P.id=3301)),
type_e_produto((SELECT REF(P) FROM tab_produto P WHERE P.id=3302)),
type_e_produto((SELECT REF(P) FROM tab_produto P WHERE P.id=3303)),
type_e_produto((SELECT REF(P) FROM tab_produto P WHERE P.id=3304)),
type_e_produto((SELECT REF(P) FROM tab_produto P WHERE P.id=3305)),
type_e_produto((SELECT REF(P) FROM tab_produto P WHERE P.id=3306))
)
WHERE K.CNPJ = '3333';
/


-- Carrinho

-- Funcao para adicionar produto no carrinho e subtrair da tabela produto
CREATE OR REPLACE FUNCTION ADICIONAR_PRODUTO(id_produto IN tab_produto.id%TYPE, 
                                            quantidade_produto IN tab_produto.quantidade%TYPE)
    RETURN type_produto AS
    out_var type_produto := type_produto(NULL,NULL,quantidade_produto,NULL,NULL);
    CURSOR buffer_cur IS
    SELECT P.id, P.nome, P.categoria, P.preco FROM tab_produto P WHERE P.id = id_produto;

BEGIN 
    
    OPEN buffer_cur;
        FETCH buffer_cur INTO out_var.id, out_var.nome, out_var.categoria, out_var.preco;
    CLOSE buffer_cur;
    
    UPDATE tab_produto
    SET quantidade = quantidade - quantidade_produto
    WHERE id=id_produto;

    RETURN out_var;

END ADICIONAR_PRODUTO;
/

INSERT INTO tab_carrinho VALUES(
    type_carrinho(
        seq_carrinho.NEXTVAL,
        type_lista_de_produtos(
            ADICIONAR_PRODUTO(1101,2),
            ADICIONAR_PRODUTO(1102,1)
        ),
        2
    )
);
/

INSERT INTO tab_carrinho VALUES(
    type_carrinho(
        seq_carrinho.NEXTVAL,
        type_lista_de_produtos(
            ADICIONAR_PRODUTO(2201,2),
            ADICIONAR_PRODUTO(2202,3),
            ADICIONAR_PRODUTO(2203,5)
        ),
        3
    )
);
/

INSERT INTO tab_carrinho VALUES(
    type_carrinho(
        seq_carrinho.NEXTVAL,
        type_lista_de_produtos(
            ADICIONAR_PRODUTO(3301,1),
            ADICIONAR_PRODUTO(3302,1),
            ADICIONAR_PRODUTO(3303,1),
            ADICIONAR_PRODUTO(3306,2)
        ),
        4
    )
);
/


-- Pedido
INSERT INTO tab_pedido VALUES (
    seq_pedido.NEXTVAL,
    (SELECT REF(D) FROM tab_destinatario D WHERE D.cpf='11132342152'),
    (SELECT REF(F) FROM tab_funcionario F WHERE F.cpf='11111111111'),
    (SELECT REF(C) FROM tab_carrinho C WHERE C.id=1),
    to_date('13/02/2022', 'dd/mm/yyyy'),
    to_date('06/02/2022', 'dd/mm/yyyy'),
    32,
    'C'
);
/

INSERT INTO tab_pedido VALUES (
    seq_pedido.NEXTVAL,
    (SELECT REF(D) FROM tab_destinatario D WHERE D.cpf='13421454442'),
    (SELECT REF(F) FROM tab_funcionario F WHERE F.cpf='11111111112'),
    (SELECT REF(C) FROM tab_carrinho C WHERE C.id=2),
    to_date('17/02/2022', 'dd/mm/yyyy'),
    to_date('05/02/2022', 'dd/mm/yyyy'),
    7,
    'C'
);
/

INSERT INTO tab_pedido VALUES (
    seq_pedido.NEXTVAL,
    (SELECT REF(D) FROM tab_destinatario D WHERE D.cpf='13421452212'),
    (SELECT REF(F) FROM tab_funcionario F WHERE F.cpf='11111111113'),
    (SELECT REF(C) FROM tab_carrinho C WHERE C.id=3),
    to_date('18/03/2022', 'dd/mm/yyyy'),
    to_date('26/02/2022', 'dd/mm/yyyy'),
    148,
    'B'
);
/


-- Extravio
INSERT INTO tab_extravio VALUES (
    type_extravio(
        1,
        'Caminhão roubado',
        (SELECT REF(P) FROM tab_pedido P WHERE P.id = 1)
    )
);
/

INSERT INTO tab_extravio VALUES (
    type_extravio(
        2,
        'Caminhão assaltado',
        (SELECT REF(P) FROM tab_pedido P WHERE P.id = 2)
    )
);
/

INSERT INTO tab_extravio VALUES (
    type_extravio(
        3,
        'Caminhão danificado',
        (SELECT REF(P) FROM tab_pedido P WHERE P.id = 3)
    )
);
/
