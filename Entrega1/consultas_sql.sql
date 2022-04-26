/* 1. ALTER TABLE */
/* Atualizar o campo telefone da tabela telefone_fornecedor, para usar VARCHAR(11) ao invés de INT para facilitar filtros como buscar por DDD. */
ALTER TABLE telefone_fornecedor
MODIFY (numero_de_telefone VARCHAR(11));

/* 2.CREATE INDEX */
/* Criar um índice para o atributo supervisionado_por na tabela funcionario, para possibilitar consultas rapidas de subordinados. */ 
CREATE INDEX indice_supervisionado_por
ON funcionario (supervisionado_por);

/* 3. & 4. INSERT INTO & UPDATE */
/* Inserção de uma nova pessoa na tabela pessoa e em seguida atualização de sua renda. */
INSERT INTO pessoa VALUES ('111.111.111-31', 'Fulano', to_date('01/01/1978', 'dd/mm/yyyy'));
INSERT INTO funcionario VALUES ('111.111.111-31', NULL, 'Gerente', 8000, to_date('01/01/2022', 'dd/mm/yyyy'));
UPDATE funcionario
SET renda=8000.00
WHERE cpf_p='111.111.111-21';

/* 5. DELETE */ 
/* Deletar todas as ocorrências na tabela produtos, cujo cnpj seja igual a  '11.111.111/0001-11',
caso a entregadora tenha parado de usar os serviços. */
DELETE FROM produto
WHERE (cnpj_fornecedor = '11.111.111/0001-11');

/* 6. SELECT-FROM-WHERE, 7. BETWEEN & 21. ORDER BY */ 
/* Selecionar o cpf e a renda dos funcionários que possuem renda entre 5000 e 10000 reais, mostrando a renda em ordem crescente */
SELECT cpf_p, renda FROM funcionario
WHERE renda BETWEEN 5000 AND 10000
ORDER BY renda;

/* 8. IN */ 
/* Selecionar os CPFs dos funcionarios que tenham como supervisor alguém com o CPF '111.111.111-12' ou '111.111.111-21' */
SELECT cpf_p FROM funcionario
WHERE supervisionado_por IN ('111.111.111-12', '111.111.111-21');

/* 9. LIKE */
/* Selecionar o nome, O CNPJ do fornecedor e o preço de todos os produtos que têm o nome começando com a letra L. */
SELECT nome_do_produto, cnpj_fornecedor, preco FROM produto
WHERE nome_do_produto LIKE 'L%';

/* 10. IS NULL ou IS NOT NULL */ 
/* Selecionar o nome e o CPF do supervisor correspondentes aos funcionários com um supervisor ativo. */
SELECT P.nome, F.supervisionado_por 
FROM funcionario F, pessoa P
WHERE F.cpf_p = P.cpf AND F.supervisionado_por IS NOT NULL;

/* 11. INNER JOIN */ 
/* Selecionar o nome dos funcionários que também são supervisores */
SELECT DISTINCT P.nome 
FROM pessoa P
INNER JOIN funcionario F
ON P.cpf = F.supervisionado_por;

/* 12. MAX, 13. MIN & 14. AVG */
/* Calcular a maior, a menor e a renda média dos funcionários. */
SELECT MAX(renda), MIN(renda), AVG(renda)
FROM funcionario;

/* 15. COUNT & 16. LEFT ou RIGHT ou FULL OUTER JOIN */ 
/* Encontrar o número de funcionários que foram contratados em 2022 e também são destinatários(clientes). */
SELECT Count(*) 
FROM funcionario F LEFT OUTER JOIN destinatario D
ON F.cpf_p = D.cpf_p
WHERE (to_date(data_de_admissao) >= to_date('01/01/2022', 'dd/mm/yyyy'));

/* 17 & 18. SUBCONSULTA COM OPERADOR RELACIONAL & SUBCONSULTA COM IN */
/* Selecionar o nome dos fornecedores que possuem o produto 'Livro Harry Potter' numa quantidade maior que 10 unidades. */
SELECT C.nome_da_empresa 
FROM cnpj_nome_empresa C
WHERE C.cnpj IN (
    SELECT cnpj_fornecedor
    FROM produto 
    WHERE (nome_do_produto = 'Livro Harry potter') AND (quantidade > 10)
);

/* 19. SUBCONSULTA COM ANY */ 
/* Selecionar os CPFs e nomes dos funcionários que estão há mais tempo na empresa que algum funcionário supervisor */
SELECT F.cpf_p, P.nome FROM funcionario F, pessoa P
WHERE F.cpf_p = P.cpf AND to_date(data_de_admissao) < ANY (
    SELECT DISTINCT to_date(F.data_de_admissao) 
    FROM funcionario F
    INNER JOIN pessoa P
    ON F.supervisionado_por = P.cpf
);

/* 20. SUBCONSULTA COM ALL */
/* Selecionar os CPFs e nomes dos funcionários que recebem mais que todos com o cargo de 'gerente' */
SELECT F.cpf_p, P.nome FROM funcionario F, pessoa P
WHERE F.cpf_p = P.cpf AND F.renda > ALL (
    SELECT renda
    FROM funcionario
    WHERE (cargo = 'gerente')
);

/* 22. GROUP BY
Descrição: Mostra a média de preço dos produtos de um determinado fornecedor */
SELECT AVG(preco), cnpj_fornecedor
FROM produto
GROUP BY cnpj_fornecedor;

/* 23. HAVING
Mostra o preço máximo de produto de cada fornecedor, desde que tenha a média de preço
maior que 10. */
SELECT MAX(preco), cnpj_fornecedor
FROM produto
GROUP BY cnpj_fornecedor
HAVING AVG(preco) > 10;

/* 24. UNION ou INTERSECT ou MINUS
Encontrar o nome de todos os funcionários que nunca foram destinatários(clientes). */
SELECT nome, cpf FROM pessoa
WHERE cpf IN (
    SELECT cpf_p FROM funcionario 
    MINUS
    SELECT cpf_p FROM destinatario
);

/* 25. CREATE VIEW */
/* Criar uma visão para funcionarios sem supervisor */
CREATE VIEW funcionarios_supervisores AS
SELECT * FROM funcionario
WHERE supervisionado_por = NULL;

/* 26. GRANT & REVOKE */ 

-- Cria usuário Didier para alterar permissões
CREATE USER Didier IDENTIFIED BY Didier;

-- Garante e revoga Permissão de update de fornecedor para Didier
GRANT UPDATE ON fornecedor TO Didier;
REVOKE UPDATE ON fornecedor FROM Didier;