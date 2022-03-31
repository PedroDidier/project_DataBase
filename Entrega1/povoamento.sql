--- Povoamento Pessoa

INSERT INTO pessoa VALUES ('111.111.111-11', 'Nilo Bemfica', to_date('01/01/2001', 'dd/mm/yyyy'));
INSERT INTO pessoa VALUES ('111.111.111-12', 'Nilo Mineiro',  to_date('01/01/2001', 'dd/mm/yyyy'));
INSERT INTO pessoa VALUES ('111.111.111-13', 'Nilo Campos',  to_date('01/01/2001', 'dd/mm/yyyy'));
INSERT INTO pessoa VALUES ('111.111.111-14', 'Nilo Drumond',  to_date('01/01/2001', 'dd/mm/yyyy'));
INSERT INTO pessoa VALUES ('111.111.111-15', 'Pedro',  to_date('01/01/2001', 'dd/mm/yyyy'));
INSERT INTO pessoa VALUES ('111.111.111-16', 'Pedro Tenório',  to_date('01/01/2001', 'dd/mm/yyyy'));
INSERT INTO pessoa VALUES ('111.111.111-17', 'Pedro Didier',  to_date('01/01/2001', 'dd/mm/yyyy'));
INSERT INTO pessoa VALUES ('111.111.111-18', 'Pedro Maranhão',  to_date('01/01/2001', 'dd/mm/yyyy'));
INSERT INTO pessoa VALUES ('111.111.111-19', 'Pedro Lemos',  to_date('01/01/2001', 'dd/mm/yyyy'));
INSERT INTO pessoa VALUES ('111.111.111-20', 'Pedro Pedro',  to_date('01/01/2001', 'dd/mm/yyyy'));

--- Povoamento Cnpj_nome_empresa

INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-11', 'Brasil Livros');
INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-12', 'Recife Papelaria');
INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-13', 'Vidraria Dois Irmãos');
INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-14', 'Tupiniquim Importados');
INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-15', 'Pangeia Eletronicos');
INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-16', 'Giga Bebidas');
INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-17', 'Vinil Discos');
INSERT INTO cnpj_nome_empresa VALUES ('11.111.111/0001-18', 'Ronaldo Artigos Esportivos');

--- Povoamento endereço_destinatario

INSERT INTO endereco_destinatario VALUES ('11111-111', 'Rua Brasil', '111', '1');
INSERT INTO endereco_destinatario VALUES ('11111-112', 'Rua Paraguai', '112', '1');
INSERT INTO endereco_destinatario VALUES ('11111-113', 'Rua Uruguai', '113', '1');
INSERT INTO endereco_destinatario VALUES ('11111-114', 'Rua Venezuela', '114', '1');
INSERT INTO endereco_destinatario VALUES ('11111-115', 'Avenida Vietnam', '115', '1');
INSERT INTO endereco_destinatario VALUES ('11111-116', 'Avenida China', '116', '1');
INSERT INTO endereco_destinatario VALUES ('11111-117', 'Avenida Australia', '117', '1');
INSERT INTO endereco_destinatario VALUES ('11111-118', 'Avenida Russia', NULL, '1');

--- Povoamento Endereço_fornecedor

INSERT INTO endereco_fornecedor VALUES ('22222-222', 'rua amora', '222', '1');
INSERT INTO endereco_fornecedor VALUES ('22222-223', 'rua do bonfim', '223', '1');
INSERT INTO endereco_fornecedor VALUES ('22222-224', 'rua condado', '224', '1');
INSERT INTO endereco_fornecedor VALUES ('22222-225', 'rua do futuro', '225', '1');
INSERT INTO endereco_fornecedor VALUES ('22222-226', 'rua estrela', '226', '1');
INSERT INTO endereco_fornecedor VALUES ('22222-227', 'rua olivia', '227', '1');
INSERT INTO endereco_fornecedor VALUES ('22222-228', 'rua menelau', '228', '1');
INSERT INTO endereco_fornecedor VALUES ('22222-229', 'rua padre', '229', '1');

--- Povoamento Identificador_pedido

INSERT INTO identificador_pedido VALUES (1, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11');
INSERT INTO identificador_pedido VALUES (2, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11');
INSERT INTO identificador_pedido VALUES (3, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11');
INSERT INTO identificador_pedido VALUES (4, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11');
INSERT INTO identificador_pedido VALUES (5, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11');
INSERT INTO identificador_pedido VALUES (6, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11');
INSERT INTO identificador_pedido VALUES (7, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11');
INSERT INTO identificador_pedido VALUES (8, to_date('01/01/2001', 'dd/mm/yyyy'), 'pix', to_date('01/01/2001', 'dd/mm/yyyy'), '11');


--- Povoamento Extravio

INSERT INTO extravio VALUES (1, 1, 'Roubo de carga');
INSERT INTO extravio VALUES (2, 2, 'Erro de endereço');
INSERT INTO extravio VALUES (3, 2, 'Produto quebrou');
INSERT INTO extravio VALUES (4, 3, 'Perda de carga');

--- Povoamento Telefone_Pessoa

INSERT INTO telefone_pessoa VALUES ('111.111.111-11', '81999999999');
INSERT INTO telefone_pessoa VALUES ('111.111.111-12', '81999998888');
INSERT INTO telefone_pessoa VALUES ('111.111.111-13', '81999998887');
INSERT INTO telefone_pessoa VALUES ('111.111.111-14', '81999998886');
INSERT INTO telefone_pessoa VALUES ('111.111.111-15', '81999998885');
INSERT INTO telefone_pessoa VALUES ('111.111.111-16', '81999998884');
INSERT INTO telefone_pessoa VALUES ('111.111.111-17', '81999998883');

--- Povoamento Funcionário

INSERT INTO funcionario VALUES ('111.111.111-12', NULL, 'gerente', 1000.00, to_date('01/01/2001', 'dd/mm/yyyy'));
INSERT INTO funcionario VALUES ('111.111.111-13', NULL, 'gerente', 1000.00, to_date('01/01/2001', 'dd/mm/yyyy'));
INSERT INTO funcionario VALUES ('111.111.111-14', '111.111.111-12', 'entregador', 1000.00, to_date('01/01/2001', 'dd/mm/yyyy'));
INSERT INTO funcionario VALUES ('111.111.111-15', '111.111.111-13', 'entregador', 2000.00, to_date('01/01/2001', 'dd/mm/yyyy'));
INSERT INTO funcionario VALUES ('111.111.111-16', '111.111.111-13', 'entregador', 2000.00, to_date('01/01/2001', 'dd/mm/yyyy'));

--- Povoamento Destinatário

INSERT INTO destinatario VALUES ('111.111.111-17','11111-111');
INSERT INTO destinatario VALUES ('111.111.111-18','11111-112');
INSERT INTO destinatario VALUES ('111.111.111-19','11111-113');
INSERT INTO destinatario VALUES ('111.111.111-20','11111-114');

--- Povoamento Fornecedor

INSERT INTO fornecedor VALUES ('11.111.111/0001-11', '22222-222');
INSERT INTO fornecedor VALUES ('11.111.111/0001-12', '22222-223');
INSERT INTO fornecedor VALUES ('11.111.111/0001-13', '22222-224');
INSERT INTO fornecedor VALUES ('11.111.111/0001-14', '22222-225');


--- Povoamento Produto

INSERT INTO produto VALUES ('11.111.111/0001-11', 'Livro Harry potter', 'livro', '70', '12');
INSERT INTO produto VALUES ('11.111.111/0001-11', 'Livro Senhor dos Aneis', 'livro', '72', '3');
INSERT INTO produto VALUES ('11.111.111/0001-11', 'Livro Mochileiro das Galaxias', 'guia', '42', '42');
INSERT INTO produto VALUES ('11.111.111/0001-12', 'Lapis de Cor', 'papelariaLapis', '2.50', '451');
INSERT INTO produto VALUES ('11.111.111/0001-12', 'Caneta bic', 'papelaria', '3', '342');
INSERT INTO produto VALUES ('11.111.111/0001-13', 'Vidro temperado', 'vidraçaria', '670', '1');
INSERT INTO produto VALUES ('11.111.111/0001-14', 'Arco indigena', 'arma tribal', '110', '1');
INSERT INTO produto VALUES ('11.111.111/0001-14', 'Katana', 'arma marcial', '999', '2');


--- Povoamento Telefone_fornecedor

INSERT INTO telefone_fornecedor VALUES ('11.111.111/0001-11', '81978888888');
INSERT INTO telefone_fornecedor VALUES ('11.111.111/0001-12', '81978888887');
INSERT INTO telefone_fornecedor VALUES ('11.111.111/0001-13', '81978888886');
INSERT INTO telefone_fornecedor VALUES ('11.111.111/0001-14', '81978888885');

--- Povoamento Pedido

INSERT INTO pedido VALUES ('111.111.111-17','111.111.111-12','11.111.111/0001-11','Livro Harry potter','1');
INSERT INTO pedido VALUES ('111.111.111-18','111.111.111-13','11.111.111/0001-12','Caneta bic','2');
INSERT INTO pedido VALUES ('111.111.111-19','111.111.111-14','11.111.111/0001-13','Vidro temperado','3');
INSERT INTO pedido VALUES ('111.111.111-20','111.111.111-15','11.111.111/0001-14','Arco indigena','4');