-- Destinatário

-- Funcionário
INSERT INTO tab_funcionario VALUES(
    type_funcionario(
        '11111111111',
        'Pedro Lemos',
        to_date('06/09/2001', dd/mm/yyyy),
        type_nt_telefone(type_telefone('987210600')),
        'Entregador Chefe',
        7000,
        null
    )
)
INSERT INTO tab_funcionario VALUES(
    type_funcionario(
        '11111111112',
        'Pedro Didier',
        to_date('12/05/2001', dd/mm/yyyy),
        type_nt_telefone(type_telefone('987210601')),
        'Entregador',
        4500,
        (SELECT REF(F) FROM tab_funcionario F WHERE P.CPF ='11111111111')
    )
)
INSERT INTO tab_funcionario VALUES(
    type_funcionario(
        '11111111113',
        'Nilo Drummond',
        to_date('05/11/2000', dd/mm/yyyy),
        type_nt_telefone(type_telefone('987210602')),
        'Entregador',
        4500,
        null
    )
)
INSERT INTO tab_funcionario VALUES(
    type_funcionario(
        '11111111114',
        'Charles Gabriel',
        to_date('25/04/2000', dd/mm/yyyy),
        type_nt_telefone(type_telefone('987210603')),
        'CEO',
        17000,
        null
    )
)
INSERT INTO tab_funcionario VALUES(
    type_funcionario(
        '11111111115',
        'Antonio Guimaraes',
        to_date('21/01/1980', dd/mm/yyyy),
        type_nt_telefone(type_telefone('987210604')),
        'Entregador',
        4500,
        (SELECT REF(F) FROM tab_funcionario F WHERE P.CPF ='11111111111')
    )
)

-- Fornecedor

-- Carrinho

-- Pedido

-- Extravio
