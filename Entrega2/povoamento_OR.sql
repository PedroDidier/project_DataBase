-- Destinatário

INSERT INTO tab_destinatario VALUES(
    type_funcionario(
        '11132342152',
        'Ricardo Soares',
        to_date('06/02/2001', dd/mm/yyyy),
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
    type_funcionario(
        '13421452212',
        'Barney Stinson',
        to_date('06/12/1990', dd/mm/yyyy),
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
    type_funcionario(
        '13421454442',
        'Arthur Cassimiro',
        to_date('23/11/1999', dd/mm/yyyy),
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
    type_funcionario(
        '13421455312',
        'Bruno Martins',
        to_date('16/05/2000', dd/mm/yyyy),
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
    type_funcionario(
        '13567455312',
        'Bruna Mendes',
        to_date('21/08/2000', dd/mm/yyyy),
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

-- Fornecedor


INSERT INTO tab_fornecedor VALUES(
    type_fornecedor(
        '1111',
        'Máquina de Monstro',
        type_lista_de_telefone(
            type_telefone(
                '81999997777'
            )
        ),
        type_lista_de_produtos(
            type_produto(
                'Whey Chocolate',
                '5000',
                'Whey',
                110
            ),
            type_produto(
                'Whey Baunilha',
                '3000',
                'Whey',
                110
            ),
            type_produto(
                'Barra Proteica',
                '500',
                'Barra Nutricional',
                12,
            )
        )
    )
)/

INSERT INTO tab_fornecedor VALUES(
    type_fornecedor(
        '2222',
        'Pickcells',
        type_lista_de_telefone(
            type_telefone(
                '81999998888'
            ),
            type_telefone(
                '8132254361'
            )
        ),
        type_lista_de_produtos(
            type_produto(
                'Software de identificação de parasitas',
                '100',
                'Software',
                1200
            )
        )
    )
)/


INSERT INTO tab_fornecedor VALUES(
    type_fornecedor(
        '33333',
        'Kabum',
        type_lista_de_telefone(
            type_telefone(
                '81999996666'
            ),
        ),
        type_lista_de_produtos(
            type_produto(
                'Mouse Razer',
                '50',
                'Mouse',
                999
            ),
            type_produto(
                'Mouse Logitech',
                '100',
                'Mouse',
                150
            ),
            type_produto(
                'Teclado Logitech',
                '85',
                'Teclado',
                180,
            )
        )
    )
)/

-- Carrinho

-- Pedido

-- Extravio

INSERT INTO tab_extravio VALUES (
    type_extravio(
        1,
        'Caminhão roubado',
        (SELECT REF(P) FROM tab_pedido P WHERE P.id = 1)
    )
)/

INSERT INTO tab_extravio VALUES (
    type_extravio(
        2,
        'Caminhão assaltado',
        (SELECT REF(P) FROM tab_pedido P WHERE P.id = 2)
    )
)/

INSERT INTO tab_extravio VALUES (
    type_extravio(
        3,
        'Caminhão danificado',
        (SELECT REF(P) FROM tab_pedido P WHERE P.id = 3)
    )
)/
