-- Seleciona o nome e o CEP dos fornecedores
SELECT F.nome, F.endereco.CEP
FROM tab_fornecedor F;

-- (2. SELECT DREF)
-- Seleciona as informacoes prinicipais dos pedidos em que se enviou um produto para Arthur Cassimiro, sendo entregue por Pedro Didier
SELECT PED.id, PED.data_pedido, PED.data_entrega, PED.frete, PED.forma_de_pagamento
FROM tab_pedido PED
WHERE DEREF(PED.entregador_ped).nome = 'Pedro Didier' AND DEREF(PED.destinatario_ped).nome = 'Arthur Cassimiro';
