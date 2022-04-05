/* 1. ALTER TABLE
Descrição: Atualizar o campo telefone da tabela telefone_fornecedor, para usar VARCHAR(11) ao invés de INT para facilitar filtros como buscar por DDD. */
ALTER TABLE telefone_fornecedor
MODIFY (numero_de_telefone VARCHAR(11));

/* 2.CREATE INDEX
Descrição: Criar um índice para o atributo supervisionado_por na tabela funcionario, para possibilitar consultas rapidas de subordinados. */ 
CREATE INDEX indice_supervisionado_por
ON funcionario (supervisionado_por);

/* 3. INSERT INTO
Descrição: Inserção de uma nova pessoa na tabela pessoa. */
INSERT INTO pessoa VALUES ('111.111.111-21', 'Fulano', to_date('01/01/1978', 'dd/mm/yyyy'));
INSERT INTO funcionario VALUES ('111.111.111-21', NULL, 'Gerente', 600, to_date('01/01/2001', 'dd/mm/yyyy'));

/* 4. UPDATE
Descrição: Atualizar o campo renda de um funcionário na tabela funcionário. */
UPDATE funcionario
SET renda=10000.00
WHERE cpf_p='111.111.111-21';

/* 5. DELETE 
Descrição: Deletar todas as ocorrências na tabela produtos, cujo cnpj seja igual a  '11.111.111/0001-11',
caso a entregadora tenha parado de usar os serviços. */
DELETE FROM produto
WHERE (cnpj_fornecedor = '11.111.111/0001-11');

/* 6 e 7. SELECT-FROM-WHERE & BETWEEN 
Descrição: Selecionar a data de admissão e o cpf da pessoa das ocorrências da tabela funcionario
 onde a data de admissão está entre 12:00 de 01 de janeiro de 2021 e 12:00 de 01 de janeiro de 2022. */
SELECT cpf_p, data_de_admissao FROM funcionario
WHERE TO_TIMESTAMP(data_de_admissao)
BETWEEN TO_TIMESTAMP('01-JAN-2000 12.00.00.000000 PM') AND TO_TIMESTAMP('01-JAN-2002 12.00.00.000000 PM');

/* 8. IN
Descrição: Selecionar os CPFs das dos funcionarios das ocorrências da tabela funcionario,
 tais que o funcionário tenha tenha um supervisor com o CPF '111.111.111-12' ou '111.111.111-13' */
SELECT cpf_p, supervisionado_por FROM funcionario
WHERE supervisionado_por IN ('111.111.111-12', '111.111.111-21');

/* 9. LIKE 
Selecionar, na tabela Pessoa, o nome e data de nascimento de todas as pessoas que tem o nome começando com ‘F’. */
SELECT nome, data_de_nascimento FROM pessoa
WHERE nome LIKE 'F%';

/* 10. IS NULL OU IS NOT NULL
Descrição: Buscar o nome dos funcionários que não possuem nenhum supervisor. */
SELECT P.nome from funcionario F, pessoa P
WHERE F.cpf_p = P.cpf AND F.supervisionado_por IS NULL;

/* 11. INNER JOIN
Descrição: Buscar o nome na tabela pessoa e CPF
dos funcionários que supervionam na tabela funcionario, sem admitir valores duplicados. */
SELECT DISTINCT P.nome FROM pessoa P
INNER JOIN funcionario F
ON P.cpf = F.supervisionado_por;

/* 12 & 13 & 14 . MAX, MIN, AVG
Descrição: Encontrar a maior renda, a menor renda,
e a renda média entre todos os funcionários da tabela funcionario. */
SELECT MAX(renda), MIN(renda), AVG(renda)
FROM funcionario;

/* 15. COUNT
Descrição: Encontrar, na tabela funcionario, o número de funcionários que possuem uma renda acima da media. */
SELECT COUNT(*)
FROM funcionario
WHERE (renda > (SELECT AVG(renda) from funcionario));

/* 16. LEFT OU RIGHT OU FULL OUTER JOIN
Descrição: Consultar todos os funcionários, mostrando seu CPF,
e mostrar o CEP de entrega daqueles que também são destinatarios. */
SELECT F.cpf_p, D.cep
FROM funcionario F LEFT OUTER JOIN destinatario D
ON F.cpf_p = D.cpf_p;

/* 17 & 18. SUBCONSULTA COM OPERADOR RELACIONAL & SUBCONSULTA COM IN
Descrição: Buscar o CPF de todos os funcionários que nasceram em 01/01/1978 ou
em 23/04/1979. */
SELECT F.cpf_p FROM funcionario F
WHERE F.cpf_p IN (SELECT cpf
FROM pessoa WHERE to_date(data_de_nascimento) = to_date('01/01/1978', 'dd/mm/yyyy') OR
to_date(data_de_nascimento) = to_date('23/04/1979', 'dd/mm/yyyy'));

/* 19. SUBCONSULTA COM ANY
Descrição: Listar o cpf dos funcionários que possuem salário maior
ou igual do que o salário de pelo menos um funcionário que é supervisor. */
SELECT cpf_p FROM funcionario WHERE
renda >= ANY
(SELECT renda FROM funcionario WHERE cpf_p IN 
(SELECT supervisionado_por FROM funcionario));

/* 20. SUBCONSULTA COM ALL
Descrição: Listar o cpf dos funcionários supervisores que possuem um salário
 maior ou igual do que o salário de todos os outros funcionários. */
SELECT cpf_p FROM funcionario WHERE
cpf_p IN (SELECT supervisionado_por FROM funcionario) AND
renda >= ALL (SELECT renda FROM funcionario);

/* 21. ORDER BY
Descrição: Listar o nome e preco de todos os produtos em ordem crescente. */
SELECT nome_do_produto, preco FROM produto
ORDER BY preco;

/* 22. GROUP BY
Descrição: Mostra a média de preço dos produtos de um determinado fornecedor */
SELECT AVG(preco), cnpj_fornecedor
FROM produto
GROUP BY cnpj_fornecedor

/* 23. HAVING
Descrição: Mostrar quantos funcionários possuem salário menor que a média salarial
de todos os funcionários, agrupados por sexo, com a condição de que o número de funcionários,
por sexo, com média menor que a média salarial, deve ser superior a 1. */
SELECT COUNT(salario), P.sexo FROM Funcionario F, Pessoa P
WHERE F.salario < (SELECT AVG(salario) from Funcionario) AND F.cpf = P.cpf
GROUP BY P.sexo
HAVING COUNT(salario) > 1;

/* 24. UNION ou INTERSECT ou MINUS
Descrição: Encontrar o nome de todas as pessoas que são funcionários e pacientes ao mesmo tempo. */
SELECT nome FROM Pessoa
WHERE cpf IN (SELECT cpf FROM Funcionario INTERSECT SELECT cpf FROM Paciente);

/* 25. CREATE VIEW
Descrição: Criar uma visão para pessoas do sexo feminino. */
CREATE VIEW visao_pessoas AS
SELECT * FROM Pessoa
WHERE sexo = 'F';

/* 26. GRANT & REVOKE 
Descrição: Garantir privilégios de DELETE e INSERT na tabela fornecedor, para o acesso PUBLIC (todos os usuários),
 e depois utilizar o REVOKE para remover o privilégio de remoção (DELETE). */
GRANT DELETE, INSERT ON fornecedor TO PUBLIC;
REVOKE DELETE ON fornecedor FROM PUBLIC; 