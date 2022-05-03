-- Destinatário

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
)

INSERT INTO tab_extravio VALUES (
    type_extravio(
        2,
        'Caminhão assaltado',
        (SELECT REF(P) FROM tab_pedido P WHERE P.id = 2)
    )
)

INSERT INTO tab_extravio VALUES (
    type_extravio(
        3,
        'Caminhão danificado',
        (SELECT REF(P) FROM tab_pedido P WHERE P.id = 3)
    )
)