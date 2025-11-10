-- ============================================================================
-- EXEMPLOS DE CONSULTAS CRUD - CHOCOLATEMPO
-- Arquivo com exemplos práticos para usar com JavaScript/PHP
-- ============================================================================

USE chocolatempo_crud;

-- ============================================================================
-- CRUD CLIENTES
-- ============================================================================

-- CREATE (Inserir novo cliente)
INSERT INTO clientes (nome_completo, cpf, telefone, email, endereco, data_nascimento, observacoes) 
VALUES ('Ana Paula Silva', '555.666.777-88', '(11) 95555-6666', 'ana.paula@email.com', 'Rua Nova, 789 - Centro - São Paulo/SP', '1992-03-20', 'Cliente VIP');

-- READ (Listar todos os clientes)
SELECT id, nome_completo, cpf, telefone, email, status, data_cadastro 
FROM clientes 
WHERE status = 'ativo' 
ORDER BY nome_completo;

-- READ (Buscar cliente específico)
SELECT * FROM clientes WHERE id = 1;
SELECT * FROM clientes WHERE cpf = '123.456.789-00';
SELECT * FROM clientes WHERE email = 'joao.silva@email.com';

-- UPDATE (Atualizar cliente)
UPDATE clientes 
SET nome_completo = 'João Silva Santos Junior',
    telefone = '(11) 99999-0000',
    endereco = 'Rua das Flores, 123 - Apt 45 - Centro - São Paulo/SP',
    observacoes = 'Cliente atualizado'
WHERE id = 1;

-- DELETE (Inativar cliente - soft delete)
UPDATE clientes SET status = 'inativo' WHERE id = 1;

-- DELETE (Remover permanentemente - usar com cuidado)
-- DELETE FROM clientes WHERE id = 1;

-- ============================================================================
-- CRUD FUNCIONÁRIOS
-- ============================================================================

-- CREATE (Inserir novo funcionário)
INSERT INTO funcionarios (nome_completo, cpf, telefone, email, endereco, cargo, salario, data_admissao, observacoes) 
VALUES ('Carlos Roberto Oliveira', '777.888.999-00', '(49) 97777-8888', 'carlos.roberto@chocolatempo.com.br', 'Rua dos Funcionários, 456 - Centro - Chapecó/SC', 'Vendedor', 2800.00, '2024-11-01', 'Vendedor experiente');

-- READ (Listar funcionários ativos)
SELECT id, nome_completo, cpf, cargo, salario, status, data_admissao 
FROM funcionarios 
WHERE status = 'ativo' 
ORDER BY nome_completo;

-- READ (Buscar funcionário específico)
SELECT * FROM funcionarios WHERE id = 1;
SELECT * FROM funcionarios WHERE cargo = 'Vendedor';

-- UPDATE (Atualizar funcionário)
UPDATE funcionarios 
SET salario = 3000.00,
    cargo = 'Gerente de Vendas',
    observacoes = 'Promovido para gerente'
WHERE id = 2;

-- DELETE (Inativar funcionário)
UPDATE funcionarios SET status = 'inativo' WHERE id = 1;

-- ============================================================================
-- CRUD FORNECEDORES
-- ============================================================================

-- CREATE (Inserir novo fornecedor)
INSERT INTO fornecedores (razao_social, nome_fantasia, cnpj, telefone, email, endereco, contato_responsavel, observacoes) 
VALUES ('Açúcar Cristal Ltda', 'Doce Cristal', '11.222.333/0001-44', '(48) 3333-5555', 'contato@docecristal.com.br', 'Rua do Açúcar, 300 - Industrial - Florianópolis/SC', 'Roberto Santos', 'Fornecedor de açúcar refinado');

-- READ (Listar fornecedores ativos)
SELECT id, razao_social, nome_fantasia, cnpj, telefone, email, status, data_cadastro 
FROM fornecedores 
WHERE status = 'ativo' 
ORDER BY razao_social;

-- READ (Buscar fornecedor específico)
SELECT * FROM fornecedores WHERE id = 1;
SELECT * FROM fornecedores WHERE cnpj = '12.345.678/0001-90';

-- UPDATE (Atualizar fornecedor)
UPDATE fornecedores 
SET telefone = '(11) 3333-4455',
    email = 'novoemail@cacaupremium.com.br',
    contato_responsavel = 'Carlos Mendes Junior'
WHERE id = 1;

-- DELETE (Inativar fornecedor)
UPDATE fornecedores SET status = 'inativo' WHERE id = 1;

-- ============================================================================
-- CRUD MOTOBOYS
-- ============================================================================

-- CREATE (Inserir novo motoboy)
INSERT INTO motoboys (nome_completo, cpf, telefone, cnh, categoria_cnh, placa_veiculo, modelo_veiculo, cor_veiculo, endereco, observacoes) 
VALUES ('André Luiz Santos', '999.000.111-22', '(49) 96666-7777', '55544433322', 'A', 'DEF-5678', 'Honda Biz 125', 'Preta', 'Rua das Motos, 25 - Bairro Novo - Chapecó/SC', 'Motoboy experiente');

-- READ (Listar motoboys disponíveis)
SELECT id, nome_completo, cpf, telefone, placa_veiculo, modelo_veiculo, status 
FROM motoboys 
WHERE status = 'ativo' 
ORDER BY nome_completo;

-- READ (Buscar motoboy específico)
SELECT * FROM motoboys WHERE id = 1;
SELECT * FROM motoboys WHERE placa_veiculo = 'ABC-1234';

-- UPDATE (Atualizar motoboy)
UPDATE motoboys 
SET telefone = '(49) 98888-9999',
    modelo_veiculo = 'Honda CG 160 Titan',
    cor_veiculo = 'Vermelha e Preta'
WHERE id = 1;

-- DELETE (Inativar motoboy)
UPDATE motoboys SET status = 'inativo' WHERE id = 1;

-- ============================================================================
-- CRUD PRODUTOS
-- ============================================================================

-- CREATE (Inserir novo produto)
INSERT INTO produtos (nome, categoria, descricao, preco_venda, preco_custo, estoque_atual, estoque_minimo, unidade_medida, peso_liquido, imagem_url) 
VALUES ('Trufa de Morango', 'Trufas', 'Trufa artesanal com recheio de morango natural e cobertura de chocolate branco.', 9.50, 4.75, 40, 10, 'unidade', 0.025, './assets/trufa_morango.png');

-- READ (Listar produtos ativos)
SELECT id, nome, categoria, preco_venda, estoque_atual, estoque_minimo, ativo 
FROM produtos 
WHERE ativo = TRUE 
ORDER BY categoria, nome;

-- READ (Buscar produto específico)
SELECT * FROM produtos WHERE id = 1;
SELECT * FROM produtos WHERE categoria = 'Trufas';
SELECT * FROM produtos WHERE nome LIKE '%chocolate%';

-- READ (Produtos com estoque baixo)
SELECT id, nome, categoria, estoque_atual, estoque_minimo 
FROM produtos 
WHERE estoque_atual <= estoque_minimo 
AND ativo = TRUE;

-- UPDATE (Atualizar produto)
UPDATE produtos 
SET preco_venda = 9.90,
    estoque_atual = 45,
    descricao = 'Trufa artesanal de chocolate ao leite — macia, aveludada e irresistível. Perfeita para momentos especiais.'
WHERE id = 1;

-- UPDATE (Atualizar estoque)
UPDATE produtos SET estoque_atual = estoque_atual - 5 WHERE id = 1; -- Saída
UPDATE produtos SET estoque_atual = estoque_atual + 20 WHERE id = 1; -- Entrada

-- DELETE (Inativar produto)
UPDATE produtos SET ativo = FALSE WHERE id = 1;

-- ============================================================================
-- CRUD VENDAS (Básico)
-- ============================================================================

-- CREATE (Nova venda)
INSERT INTO vendas (cliente_id, funcionario_id, numero_pedido, valor_total, forma_pagamento, status_pagamento, observacoes) 
VALUES (1, 2, 'PED000001', 89.50, 'cartao_credito', 'aprovado', 'Primeira compra do cliente');

-- CREATE (Itens da venda)
INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario, subtotal) 
VALUES 
(1, 1, 5, 8.90, 44.50),
(1, 6, 1, 49.90, 49.90);

-- READ (Listar vendas)
SELECT v.id, v.numero_pedido, v.data_venda, c.nome_completo as cliente, 
       v.valor_total, v.forma_pagamento, v.status_pagamento 
FROM vendas v 
JOIN clientes c ON v.cliente_id = c.id 
ORDER BY v.data_venda DESC;

-- READ (Detalhes de uma venda)
SELECT v.*, c.nome_completo as cliente, f.nome_completo as funcionario 
FROM vendas v 
JOIN clientes c ON v.cliente_id = c.id 
LEFT JOIN funcionarios f ON v.funcionario_id = f.id 
WHERE v.id = 1;

-- READ (Itens de uma venda)
SELECT iv.*, p.nome as produto 
FROM itens_venda iv 
JOIN produtos p ON iv.produto_id = p.id 
WHERE iv.venda_id = 1;

-- UPDATE (Atualizar status da venda)
UPDATE vendas SET status_entrega = 'entregue' WHERE id = 1;

-- ============================================================================
-- CRUD COMPRAS (Básico)
-- ============================================================================

-- CREATE (Nova compra)
INSERT INTO compras (fornecedor_id, funcionario_id, numero_nota, valor_total, status_pagamento, observacoes) 
VALUES (1, 1, 'NF123456', 500.00, 'pendente', 'Compra de cacau premium');

-- CREATE (Itens da compra)
INSERT INTO itens_compra (compra_id, produto_id, quantidade, preco_unitario, subtotal) 
VALUES (1, 2, 50, 10.00, 500.00);

-- READ (Listar compras)
SELECT c.id, c.numero_nota, c.data_compra, f.razao_social as fornecedor, 
       c.valor_total, c.status_pagamento 
FROM compras c 
JOIN fornecedores f ON c.fornecedor_id = f.id 
ORDER BY c.data_compra DESC;

-- UPDATE (Atualizar status da compra)
UPDATE compras SET status_pagamento = 'pago' WHERE id = 1;

-- ============================================================================
-- CONSULTAS ÚTEIS PARA RELATÓRIOS
-- ============================================================================

-- Relatório de vendas por período
SELECT DATE(data_venda) as data, COUNT(*) as total_vendas, SUM(valor_total) as faturamento 
FROM vendas 
WHERE data_venda BETWEEN '2024-01-01' AND '2024-12-31' 
GROUP BY DATE(data_venda) 
ORDER BY data;

-- Produtos mais vendidos
SELECT p.nome, SUM(iv.quantidade) as total_vendido 
FROM itens_venda iv 
JOIN produtos p ON iv.produto_id = p.id 
JOIN vendas v ON iv.venda_id = v.id 
WHERE v.status_pagamento = 'aprovado' 
GROUP BY p.id, p.nome 
ORDER BY total_vendido DESC 
LIMIT 10;

-- Relatório de estoque
SELECT nome, categoria, estoque_atual, estoque_minimo,
       CASE 
           WHEN estoque_atual <= estoque_minimo THEN 'Crítico'
           WHEN estoque_atual <= (estoque_minimo * 2) THEN 'Baixo'
           ELSE 'Normal'
       END as status_estoque
FROM produtos 
WHERE ativo = TRUE 
ORDER BY categoria, nome;