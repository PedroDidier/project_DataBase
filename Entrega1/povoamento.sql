--- Povoamento Pessoa

INSERT INTO pessoa VALUES ('111.111.111-11', 'Nilo Bemfica', to_date('01/01/2001', 'dd/mm/yyyy'))
INSERT INTO pessoa VALUES ('111.111.111-12', 'Nilo Mineiro',  to_date('01/01/2001', 'dd/mm/yyyy'))
INSERT INTO pessoa VALUES ('111.111.111-13', 'Nilo Campos',  to_date('01/01/2001', 'dd/mm/yyyy'))
INSERT INTO pessoa VALUES ('111.111.111-14', 'Nilo Drumond',  to_date('01/01/2001', 'dd/mm/yyyy'))
INSERT INTO pessoa VALUES ('111.111.111-15', 'Pedro',  to_date('01/01/2001', 'dd/mm/yyyy'))
INSERT INTO pessoa VALUES ('111.111.111-16', 'Pedro Tenório',  to_date('01/01/2001', 'dd/mm/yyyy'))
INSERT INTO pessoa VALUES ('111.111.111-17', 'Pedro Didier',  to_date('01/01/2001', 'dd/mm/yyyy'))
INSERT INTO pessoa VALUES ('111.111.111-18', 'Pedro Maranhão',  to_date('01/01/2001', 'dd/mm/yyyy'))
INSERT INTO pessoa VALUES ('111.111.111-19', 'Pedro Lemos',  to_date('01/01/2001', 'dd/mm/yyyy'))
INSERT INTO pessoa VALUES ('111.111.111-20', 'Pedro Pedro',  to_date('01/01/2001', 'dd/mm/yyyy'))

--- Povoamento Cnpj_nome_empresa

INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-11', 'Brasil Livros')
INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-12', 'Recife Papelaria')
INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-13', 'Vidraria Dois Irmãos')
INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-14', 'Tupiniquim Importados')
INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-15', 'Pangeia Eletronicos')
INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-16', 'Giga Bebidas')
INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-17', 'Vinil Discos')
INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-18', 'Ronaldo Artigos Esportivos')

--- Povoamento endereço_destinatario

INSERT INTO endereço_destinatario VALUES ('11111-111', 'Rua Brasil', '111', '1')
INSERT INTO endereço_destinatario VALUES ('11111-112', 'Rua Paraguai', '112', '1')
INSERT INTO endereço_destinatario VALUES ('11111-113', 'Rua Uruguai', '113', '1')
INSERT INTO endereço_destinatario VALUES ('11111-114', 'Rua Venezuela', '114', '1')
INSERT INTO endereço_destinatario VALUES ('11111-115', 'Avenida Vietnam', '115', '1')
INSERT INTO endereço_destinatario VALUES ('11111-116', 'Avenida China', '116', '1')
INSERT INTO endereço_destinatario VALUES ('11111-117', 'Avenida Australia', '117', '1')
INSERT INTO endereço_destinatario VALUES ('11111-118', 'Avenida Russia', '1')

--- Povoamento Endereço_fornecedor

INSERT INTO endereço_fornecedor VALUES ('22222-222', 'rua amora', '222', '1')
INSERT INTO endereço_fornecedor VALUES ('22222-223', 'rua do bonfim', '223', '1')
INSERT INTO endereço_fornecedor VALUES ('22222-224', 'rua condado', '224', '1')
INSERT INTO endereço_fornecedor VALUES ('22222-225', 'rua do futuro', '225', '1')
INSERT INTO endereço_fornecedor VALUES ('22222-226', 'rua estrela', '226', '1')
INSERT INTO endereço_fornecedor VALUES ('22222-227', 'rua olivia', '227', '1')
INSERT INTO endereço_fornecedor VALUES ('22222-228', 'rua menelau', '228', '1')
INSERT INTO endereço_fornecedor VALUES ('22222-229', 'rua padre', '229', '1')

--- Povoamento Identificador_pedido

INSERT INTO identificador_pedido VALUES (1, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11')
INSERT INTO identificador_pedido VALUES (2, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11')
INSERT INTO identificador_pedido VALUES (3, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11')
INSERT INTO identificador_pedido VALUES (4, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11')
INSERT INTO identificador_pedido VALUES (5, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11')
INSERT INTO identificador_pedido VALUES (6, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11')
INSERT INTO identificador_pedido VALUES (7, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11')
INSERT INTO identificador_pedido VALUES (8, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11')


--- Povoamento Extravio

INSERT INTO extravio VALUES (1, 1, "Caguei no pau")
INSERT INTO extravio VALUES (2, 2, "Caguei no pau")
INSERT INTO extravio VALUES (3, 2, "Caguei no pau")
INSERT INTO extravio VALUES (3, 3, "Caguei no pau")

--- Povoamento Telefone_Pessoa

INSERT INTO telefone_pessoa VALUES ('111.111.111-11', "81 999999999")
INSERT INTO telefone_pessoa VALUES ('111.111.111-12', "81 999998888")
INSERT INTO telefone_pessoa VALUES ('111.111.111-13', "81 999998887")
INSERT INTO telefone_pessoa VALUES ('111.111.111-14', "81 999998886")
INSERT INTO telefone_pessoa VALUES ('111.111.111-15', "81 999998885")
INSERT INTO telefone_pessoa VALUES ('111.111.111-16', "81 999998884")
INSERT INTO telefone_pessoa VALUES ('111.111.111-17', "81 999998883")

--- Povoamento Funcionário

INSERT INTO funcionario VALUES ('111.111.111-12', '111.111.111-11', 'entregador', 1000.00, to_date('01/01/2001', 'dd/mm/yyyy'))
INSERT INTO funcionario VALUES ('111.111.111-13', '111.111.111-11', 'entregador', 1000.00, to_date('01/01/2001', 'dd/mm/yyyy'))
INSERT INTO funcionario VALUES ('111.111.111-14', '111.111.111-11', 'entregador', 1000.00, to_date('01/01/2001', 'dd/mm/yyyy'))
INSERT INTO funcionario VALUES ('111.111.111-15', '111.111.111-11', 'secretário', 2000.00, to_date('01/01/2001', 'dd/mm/yyyy'))

--- Povoamento Destinatário

INSERT INTO destinatario VALUES ('222.222.222-22','11111-111')
INSERT INTO destinatario VALUES ('222.222.222-23','11111-112')
INSERT INTO destinatario VALUES ('222.222.222-24','11111-113')
INSERT INTO destinatario VALUES ('222.222.222-25','11111-114')
INSERT INTO destinatario VALUES ('222.222.222-26','11111-115')
INSERT INTO destinatario VALUES ('222.222.222-27','11111-116')
INSERT INTO destinatario VALUES ('222.222.222-28','11111-117')
INSERT INTO destinatario VALUES ('222.222.222-29','11111-118')

--- Povoamento Fornecedor

INSERT INTO fornecedor VALUES ('11.111.111/0001-11', '22222-222')
INSERT INTO fornecedor VALUES ('11.111.111/0001-12', '22222-223')
INSERT INTO fornecedor VALUES ('11.111.111/0001-13', '22222-224')
INSERT INTO fornecedor VALUES ('11.111.111/0001-14', '22222-225')

--- Povoamento Produto

INSERT INTO produto VALUES ('11.111.111/0001-11', 'Livro Harry potter', 'livro', '70', '1')
INSERT INTO produto VALUES ('11.111.111/0001-12', 'Caneta bic', 'papelaria', '3', '1')
INSERT INTO produto VALUES ('11.111.111/0001-13', 'Vidro temperado', 'vidraçaria', '670', '1')
INSERT INTO produto VALUES ('11.111.111/0001-14', 'Arco indigena', 'arma tribal', '110', '1')


--- Povoamento Telefone_fornecedor

INSERT INTO fornecedor VALUES ('11.111.111/0001-11', '81 998888888')
INSERT INTO fornecedor VALUES ('11.111.111/0001-12', '81 998888887')
INSERT INTO fornecedor VALUES ('11.111.111/0001-13', '81 998888886')
INSERT INTO fornecedor VALUES ('11.111.111/0001-14', '81 998888885')
INSERT INTO fornecedor VALUES ('11.111.111/0001-15', '81 998888884')

--- Povoamento Pedido

INSERT INTO fornecedor VALUES ('222.222.222-22','111.111.111-12','11.111.111/0001-11','Livro Harry potter','1')
INSERT INTO fornecedor VALUES ('222.222.222-23','111.111.111-13','11.111.111/0001-12','Caneta bic','2')
INSERT INTO fornecedor VALUES ('222.222.222-24','111.111.111-14','11.111.111/0001-13','Vidro temperado','3')
INSERT INTO fornecedor VALUES ('222.222.222-25','111.111.111-15','11.111.111/0001-14','Arco indigena','4')