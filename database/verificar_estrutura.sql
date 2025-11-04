-- ============================================================================
-- VERIFICAÇÃO DA ESTRUTURA DO BANCO CHOCOLATEMPO
-- Execute estas consultas para verificar se tudo foi criado corretamente
-- ============================================================================

-- 1. Verificar se o schema foi criado
SHOW DATABASES LIKE 'chocolatempo_db';

-- 2. Usar o banco
USE chocolatempo_db;

-- 3. Listar todas as tabelas criadas
SHOW TABLES;

-- 4. Verificar estrutura das principais tabelas
DESCRIBE usuarios;
DESCRIBE produtos;
DESCRIBE vendas;

-- 5. Verificar se os dados foram inseridos
SELECT 'Categorias' AS tabela, COUNT(*) AS registros FROM categorias_produtos
UNION ALL
SELECT 'Usuários', COUNT(*) FROM usuarios
UNION ALL
SELECT 'Produtos', COUNT(*) FROM produtos
UNION ALL
SELECT 'Clientes', COUNT(*) FROM clientes
UNION ALL
SELECT 'Funcionários', COUNT(*) FROM funcionarios
UNION ALL
SELECT 'Fornecedores', COUNT(*) FROM fornecedores
UNION ALL
SELECT 'Motoboys', COUNT(*) FROM motoboys;

-- 6. Verificar se as views foram criadas
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- 7. Verificar se as procedures foram criadas
SHOW PROCEDURE STATUS WHERE Db = 'chocolatempo_db';

-- 8. Verificar se os triggers foram criados
SHOW TRIGGERS;

-- 9. Testar uma view de relatório
SELECT * FROM vw_relatorio_estoque LIMIT 5;

-- 10. Verificar relacionamentos (Foreign Keys)
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE CONSTRAINT_SCHEMA = 'chocolatempo_db'
AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME, COLUMN_NAME;