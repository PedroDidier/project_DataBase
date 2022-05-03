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


CREATE SEQUENCE seq_agendamento INCREMENT by 1 START WITH 1; 
/
CREATE SEQUENCE seq_vacina INCREMENT by 1 START WITH 1;
/
CREATE SEQUENCE seq_campanha INCREMENT by 1 START WITH 1;
/
INSERT INTO tb_ponto_de_vacinacao VALUES(
    tp_ponto_de_vacinacao(
        '1001',
        tp_endereco(
            '101',
            'rua estrela',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999999')),
        tp_nt_trabalha()
    )
);

/

INSERT INTO tb_ponto_de_vacinacao VALUES(
    tp_ponto_de_vacinacao(
        '1002',
        tp_endereco(
            '321',
            'rua lua',
            'Boa Viagem',
            'Recife',
            'PE',
            14
        ),
        tp_arr_telefone(tp_telefone('99999999')),
        tp_nt_trabalha()
    )
);

/

--Povoamento Funcionarios ---------------------------------------------------
INSERT INTO tb_funcionario VALUES(
    tp_funcionario(
        '2',
        'Gabriel Meireles',
        to_date('01/2/2001', 'dd/mm/yy'),
        'M',
        tp_endereco(
            '232',
            'rua aurora',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999998')),
        'gasm@mail.com',
        20000,
        null
    )
);
/

/
INSERT INTO tb_funcionario VALUES(
    tp_funcionario(
        '1',
        'Charles Gabriel',
        to_date('09/11/2001', 'dd/mm/yy'),
        'M',
        tp_endereco(
            '101',
            'rua estrela',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999999'), tp_telefone('99999998'), tp_telefone('99999997')),
        'cgcm@mail.com',
        10000,
        (SELECT REF(P) FROM tb_funcionario P WHERE P.CPF ='2')
    )
);
/
INSERT INTO tb_funcionario VALUES(
    tp_funcionario(
        '3',
        'Anna Luiza',
        to_date('12/10/2000', 'dd/mm/yy'),
        'F',
        tp_endereco(
            '232',
            'rua aurora',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999998'), tp_telefone('99999999')),
        'alcaf@mail.com',
        20000,
        null
    )
);
/
INSERT INTO tb_funcionario VALUES(
    tp_funcionario(
        '4',
        'Pedro Meira',
        to_date('09/11/2001', 'dd/mm/yy'),
        'M',
        tp_endereco(
            '101',
            'rua estrela',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999999')),
        'cgcm@mail.com',
        10000,
        (SELECT REF(P) FROM tb_funcionario P WHERE P.CPF ='3')
    )
);
/
INSERT INTO tb_funcionario VALUES(
    tp_funcionario(
        '5',
        'Paulo Henrique',
        to_date('09/11/2001', 'dd/mm/yy'),
        'M',
        tp_endereco(
            '101',
            'rua estrela',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999999')),
        'cgcm@mail.com',
        10000,
        (SELECT REF(P) FROM tb_funcionario P WHERE P.CPF ='3')
    )
);
/
--Adcionas os funcionarios nos pontos de vacinacoes
UPDATE tb_ponto_de_vacinacao A
SET A.funcionarios = tp_nt_trabalha (
tp_trabalha((SELECT REF(P) FROM tb_funcionario P WHERE P.cpf =2)),
tp_trabalha((SELECT REF(P) FROM tb_funcionario P WHERE P.cpf =1)))
WHERE A.cnpj = '1001' ;
/
UPDATE tb_ponto_de_vacinacao A
SET A.funcionarios = tp_nt_trabalha (
tp_trabalha((SELECT REF(P) FROM tb_funcionario P WHERE P.cpf =3)),
tp_trabalha((SELECT REF(P) FROM tb_funcionario P WHERE P.cpf =4)),
tp_trabalha((SELECT REF(P) FROM tb_funcionario P WHERE P.cpf =5)))
WHERE A.cnpj = '1002' ;
/
--Povoamento Pacientes -----------------------------------------------------
INSERT INTO tb_paciente VALUES(
    tp_paciente(
        '1',
        'Charles Gabriel',
        to_date('09/11/2001', 'dd/mm/yy'),
        'M',
        tp_endereco(
            '101',
            'rua estrela',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999999')),
        'cgcm@mail.com',
        tp_plano_de_saude(
            '0001',
            'bradesco',
            '1111'
        ),
        to_date('09/11/2011', 'dd/mm/yy')
    )
);
/
INSERT INTO tb_paciente VALUES(
    tp_paciente(
        '2',
        'Pedro Didier',
        to_date('09/11/2001', 'dd/mm/yy'),
        'M',
        tp_endereco(
            '101',
            'rua estrela',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999999')),
        'pdm@mail.com',
        tp_plano_de_saude(
            '0002',
            'bradesco',
            '1111'
        ),
        to_date('09/11/2011', 'dd/mm/yy')
    )
);
/
INSERT INTO tb_paciente VALUES(
    tp_paciente(
        '10',
        'Thais Couto',
        to_date('09/11/2001', 'dd/mm/yy'),
        'F',
        tp_endereco(
            '101',
            'rua estrela',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999999')),
        'alcaf@mail.com',
        tp_plano_de_saude(
            '0003',
            'bradesco',
            '1111'
        ),
        to_date('09/11/2011', 'dd/mm/yy')
    )
);
/
INSERT INTO tb_paciente VALUES(
    tp_paciente(
        '11',
        'Caio de Hoanda',
        to_date('09/11/2001', 'dd/mm/yy'),
        'M',
        tp_endereco(
            '101',
            'rua estrela',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999999')),
        'ch@mail.com',
        tp_plano_de_saude(
            '0004',
            'bradesco',
            '1111'
        ),
        to_date('09/11/2011', 'dd/mm/yy')
    )
);
/
INSERT INTO tb_paciente VALUES(
    tp_paciente(
        '12',
        'Thais Couto',
        to_date('09/11/2001', 'dd/mm/yy'),
        'F',
        tp_endereco(
            '101',
            'rua estrela',
            'Casa forte',
            'Recife',
            'PE',
            1
        ),
        tp_arr_telefone(tp_telefone('99999999')),
        'tvc@mail.com',
        tp_plano_de_saude(
            '0005',
            'bradesco',
            '1111'
        ),
        to_date('09/11/2011', 'dd/mm/yy')
    )
);
/

--Campanha de vacinacao
INSERT INTO tb_campanha_de_vacinacao VALUES(
    tp_campanha_de_vacinacao(
        seq_campanha.NEXTVAL,
        'covid19',
        'Governo de PE',
        to_date('09/11/2009', 'dd/mm/yy'),
        to_date('09/11/2010', 'dd/mm/yy')
    )
);
/
INSERT INTO tb_campanha_de_vacinacao VALUES(
    tp_campanha_de_vacinacao(
        seq_campanha.NEXTVAL,
        'Poliomelite',
        'Ministerio da saude',
        to_date('09/11/2009', 'dd/mm/yy'),
        to_date('09/11/2009', 'dd/mm/yy')
    )
);
/
INSERT INTO tb_vacina VALUES(
    tp_vacina(
        seq_vacina.NEXTVAL,
        to_date('09/11/2009', 'dd/mm/yy'),
        'astra',
        10,
        (SELECT REF(P) FROM tb_ponto_de_vacinacao P WHERE P.CNPJ ='1001')
    )
);
/
INSERT INTO tb_vacina VALUES(
    tp_vacina(
        seq_vacina.NEXTVAL,
        to_date('09/11/2009', 'dd/mm/yy'),
        'coronavac',
        10,
        (SELECT REF(P) FROM tb_ponto_de_vacinacao P WHERE P.CNPJ ='1001')
    )
);
/
INSERT INTO tb_vacina VALUES(
    tp_vacina(
        seq_vacina.NEXTVAL,
        to_date('09/11/2009', 'dd/mm/yy'),
        'astra',
        10,
        (SELECT REF(P) FROM tb_ponto_de_vacinacao P WHERE P.CNPJ ='1002')
    )
);
/
--Agendamento
INSERT INTO tb_agendamento VALUES(
    tp_agendamento(
        seq_agendamento.NEXTVAL,
        (SELECT REF(P) FROM tb_paciente P WHERE P.CPF ='1'),
        (SELECT REF(F) FROM tb_funcionario F WHERE F.CPF ='2'),
        (SELECT REF(V) FROM tb_vacina V WHERE V.lote ='1'),
        NULL,
        to_date('09/11/2009', 'dd/mm/yy'),
        '0' 
    )
);

INSERT INTO tb_agendamento VALUES(
    tp_agendamento(
        seq_agendamento.NEXTVAL,
        (SELECT REF(P) FROM tb_paciente P WHERE P.CPF ='10'),
        (SELECT REF(F) FROM tb_funcionario F WHERE F.CPF ='2'),
        (SELECT REF(V) FROM tb_vacina V WHERE V.lote ='1'),
        (SELECT REF(C) FROM tb_campanha_de_vacinacao C WHERE C.id = 2),
        to_date('09/11/2009', 'dd/mm/yy'),
        '0' 
    )
);
/