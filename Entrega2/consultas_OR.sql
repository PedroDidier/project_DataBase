-- Seleciona o nome e o CEP dos fornecedores
SELECT F.nome, F.endereco.CEP
FROM tab_fornecedor F;

-- (1. SELECT REF)
-- Insere uma linha de extravio por meio de uma referência de linha de pedido
DECLARE
    row_pedido1 REF type_pedido;
BEGIN
    SELECT REF(PED)
    INTO row_pedido1
    FROM tab_pedido PED
    WHERE id = 1;
    INSERT INTO tab_extravio VALUES(4, 'Caminhao saqueado', row_pedido1);
END;

-- (2. SELECT DEREF)
-- Seleciona o nome do entregador responsavel pelo pedido, assim como seu CPF e o nome de seu supervisor
SELECT DEREF(PED.entregador_ped).nome AS Entregador_Pedido_1,
       DEREF(PED.entregador_ped).CPF AS CPF,
       DEREF(DEREF(PED.entregador_ped).supervisor).nome AS Supervisor
FROM tab_pedido PED 
WHERE PED.id = 1;
-- Seleciona as informacoes principais dos pedidos em que se enviou um produto para Arthur Cassimiro, sendo entregue por Pedro Didier
SELECT PED.id, PED.data_pedido, PED.data_entrega, PED.frete, PED.forma_de_pagamento
FROM tab_pedido PED
WHERE DEREF(PED.entregador_ped).nome = 'Pedro Didier' AND DEREF(PED.destinatario_ped).nome = 'Arthur Cassimiro';
-- Seleciona o nome e o preco dos produtos que estao nos pedidos vendidos pela empresa PickCells
SELECT DEREF(A.produto_referente).nome AS Nome_produto, DEREF(A.produto_referente).preco AS Preco_produto_reais
FROM TABLE(SELECT X.produtos_possuidos FROM tab_fornecedor X WHERE X.CNPJ = 'PickCells') A;

-- (3. CONSULTA À VARRAY)
-- Seleciona o nome, cnpj e os telefones de um fornecedor
SELECT F.nome, F.CNPJ, T.*
FROM tab_fornecedor F, TABLE(F.telefones) T;

-- (4. CONSULTA À NESTED TABLE)
-- Seleciona o nome e a quantidade de produtos de um fornecedor
SELECT F.nome, P.quantidade
FROM tab_fornecedor F OUTER APPLY (SELECT COUNT(*) AS quantidade from TABLE(produtos_possuidos)) P