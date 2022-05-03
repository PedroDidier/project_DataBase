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

-- Carrinho

-- Pedido

-- Extravio
