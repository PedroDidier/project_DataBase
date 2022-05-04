-- Seleciona o nome e o CEP dos fornecedores
SELECT F.nome, F.endereco.CEP
FROM tab_fornecedor F;

-- (2. SELECT DREF)
-- Seleciona as informacoes principais dos pedidos em que se enviou um produto para Arthur Cassimiro, sendo entregue por Pedro Didier
SELECT PED.id, PED.data_pedido, PED.data_entrega, PED.frete, PED.forma_de_pagamento
FROM tab_pedido PED
WHERE DEREF(PED.entregador_ped).nome = 'Pedro Didier' AND DEREF(PED.destinatario_ped).nome = 'Arthur Cassimiro';

-- (3. CONSULTA À NESTED VARRAY)
-- Seleciona o nome, cnpj e os telefones de um fornecedor
SELECT F.nome, F.CNPJ, T.*
FROM tab_fornecedor F, TABLE(F.telefones) T;

SELECT F.nome, P.quantidade
FROM tab_fornecedor F OUTER APPLY (SELECT COUNT(*) AS quantidade from TABLE(produtos_possuidos)) P