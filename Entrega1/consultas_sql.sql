/* 1. ALTER TABLE
Descrição: Atualizar o campo telefone da tabela telefone_fornecedor, para usar varchar ao invés de string para facilitar filtros como buscar por DDD. */
ALTER TABLE telefone_fornecedor
MODIFY (numero_de_telefone VARCHAR(11));

/* 2.CREATE INDEX
Descrição: Criar um índice para o atributo supervisionado_por na tabela funcionario, para possibilitar consultas rapidas de subordinados. */ 
CREATE INDEX indice_supervisionado_por
ON functionario (supervisionado_por);

/* 3. INSERT INTO
Descrição: Inserção de uma nova pessoa na tabela pessoa. */
INSERT INTO pessoa VALUES ('111.111.111-21', 'Fulano', to_date('01/01/2001', 'dd/mm/yyyy'));

/* 4. UPDATE
Descrição: Atualizar o campo renda de um funcionário na tabela funcionário. */
UPDATE funcionario
SET renda=10000.00
WHERE cpf_p='111.111.111-12';

/* 5. DELETE 
Descrição: Deletar todas as ocorrências na tabela produtos, cujo cnpj seja igual a  '11.111.111/0001-11',
caso a empresa tenha parado de usar os serviços. */
DELETE FROM produto
WHERE (cnpj_fornecedor = '11.111.111/0001-11');



SELECT data_do_pedido, id_ FROM identificador_pedido
WHERE TO_TIMESTAMP(data_do_pedido)
BETWEEN TO_TIMESTAMP('01-JAN-22 12.00.00.000000 PM') AND TO_TIMESTAMP('01-FEB-22 12.00.00.000000 PM');


/* 6 e 7. SELECT-FROM-WHERE & BETWEEN 
Descrição: Selecionar a data de admissão e o cpf da pessoa das ocorrências da tabela funcionario
 onde a data de admissão está entre 12:00 de 01 de janeiro de 2021 e 12:00 de 01 de janeiro de 2022. */
SELECT cpf_p, data_de_admissao FROM funcionario
WHERE TO_TIMESTAMP(data_de_admissao)
BETWEEN TO_TIMESTAMP('01-JAN-21 12.00.00.000000 PM') AND TO_TIMESTAMP('01-JAN-22 12.00.00.000000 PM');

/* 8. IN
Descrição: Selecionar os CPFs das dos funcionarios das ocorrências da tabela funcionario,
 tais que o funcionário tenha tenha um supervisor com o CPF '111.111.111-12' ou '111.111.111-13' */
SELECT cpf_p, supervisionado_por FROM funcionario
WHERE supervisionado_por IN ('111.111.111-12', '111.111.111-13')

/* 9. LIKE 
Selecionar, na tabela Pessoa, o nome de todas as pessoas que tem o nome começando com ‘A’. */
SELECT nome FROM pessoa
WHERE nome LIKE 'A&';

/* 10. IS NULL OU IS NOT NULL
Descrição: Buscar o nome dos funcionários que não possuem nenhum supervisor. */
SELECT P.nome from funcionario F, pessoa P
WHERE F.cpf = P.cpf AND F.cpf_supervisor IS NULL;

/* 11. INNER JOIN
Descrição: Buscar o nome na tabela pessoa e CPF
dos funcionários supervisores na tabela funcionario, sem admitir valores duplicados. */
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
SELECT F.cpf, D.cep
FROM funcionario F LEFT OUTER JOIN destinatario D
ON F.cpf_l = D.cpf_p;

/* 21. ORDER BY
Descrição: Listar o nome e preco de todos os produtos em ordem crescente. */
SELECT nome_do_produto, preco FROM produto
ORDER BY preco;

/* 26. GRANT & REVOKE 
Descrição: Garantir privilégios de DELETE e INSERT na tabela fornecedor, para o acesso PUBLIC (todos os usuários),
 e depois utilizar o REVOKE para remover o privilégio de remoção (DELETE). */
GRANT DELETE, INSERT ON fornecedor TO PUBLIC;
REVOKE DELETE ON fornecedor FROM PUBLIC; 

/* ----------- Referência -------------- */

/* 17 & 18. SUBCONSULTA COM OPERADOR RELACIONAL & SUBCONSULTA COM IN
Descrição: Buscar o CPF de todos os funcionários que trabalharão
como supervisores às 12:00 de 02 de outubro de 2021 ou 12:00 de 03 outubro de 2021. */
SELECT F.cpf FROM Funcionario F
WHERE F.cpf IN (SELECT cpf_funcionario
FROM AGENDAMENTO WHERE to_timestamp(dt_agendamento) = to_timestamp('02-OCT-21 12.00.00.000000 AM') OR
to_timestamp(dt_agendamento) = to_timestamp('03-OCT-21 12.00.00.000000 AM'));

/* 19. SUBCONSULTA COM ANY
Descrição: Listar o cpf dos funcionários que possuem salário maior
ou igual do que o salário de pelo menos um funcionário que é supervisor. */
SELECT cpf FROM Funcionario WHERE
salario >= ANY
(SELECT salario FROM Funcionario WHERE cpf IN 
(SELECT cpf_supervisor FROM Funcionario) );

/* 20. SUBCONSULTA COM ALL
Descrição: Listar o cpf dos funcionários supervisores que possuem um salário
 maior ou igual do que o salário de todos os outros funcionários. */
SELECT cpf FROM Funcionario WHERE
cpf IN (SELECT cpf_supervisor FROM Funcionario) AND
salario >= ALL (SELECT salario from Funcionario);

/* 22. GROUP BY
Descrição: Mostrar quantos funcionários possuem salário maior que a média salarial
de todos os funcionários, agrupados por sexo */
SELECT COUNT(salario), P.sexo FROM Funcionario F, Pessoa P
WHERE F.salario > (SELECT AVG(salario) from Funcionario) AND F.cpf = P.cpf
GROUP BY P.sexo;

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


