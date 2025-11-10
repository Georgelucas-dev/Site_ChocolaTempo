-- ============================================================================
-- CHOCOLATEMPO - Sistema de Gestão de Chocolateria
-- Arquivo SQL para MySQL Workbench 8.0 CE
-- Data de Criação: 2025-11-03
-- Versão: 1.0
-- ============================================================================

-- Configurações iniciais
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

-- ============================================================================
-- CRIAÇÃO DO SCHEMA
-- ============================================================================
DROP SCHEMA IF EXISTS `chocolatempo_db`;
CREATE SCHEMA IF NOT EXISTS `chocolatempo_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `chocolatempo_db`;

-- ============================================================================
-- TABELA: usuarios
-- Gerencia autenticação e controle de acesso ao sistema
-- ============================================================================
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `tipo_usuario` ENUM('administrador', 'cliente', 'funcionario') NOT NULL,
  `data_criacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_ultimo_acesso` DATETIME NULL,
  `status` ENUM('ativo', 'inativo', 'bloqueado') NOT NULL DEFAULT 'ativo',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: enderecos
-- Centraliza informações de endereços para clientes, fornecedores e funcionários
-- ============================================================================
CREATE TABLE IF NOT EXISTS `enderecos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cep` VARCHAR(9) NULL,
  `logradouro` VARCHAR(200) NULL,
  `numero` VARCHAR(10) NULL,
  `complemento` VARCHAR(100) NULL,
  `bairro` VARCHAR(100) NULL,
  `cidade` VARCHAR(100) NULL,
  `estado` VARCHAR(2) NULL,
  `pais` VARCHAR(50) NOT NULL DEFAULT 'Brasil',
  `data_criacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: clientes
-- Cadastro completo de clientes da chocolateria
-- ============================================================================
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `endereco_id` INT NULL,
  `nome_completo` VARCHAR(150) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `observacoes` TEXT NULL,
  `status` ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  INDEX `fk_clientes_usuarios_idx` (`usuario_id` ASC),
  INDEX `fk_clientes_enderecos_idx` (`endereco_id` ASC),
  CONSTRAINT `fk_clientes_usuarios`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuarios` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_clientes_enderecos`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `enderecos` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: funcionarios
-- Gestão de funcionários da empresa
-- ============================================================================
CREATE TABLE IF NOT EXISTS `funcionarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `endereco_id` INT NULL,
  `nome_completo` VARCHAR(150) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `cargo` ENUM('administrador', 'gerente', 'vendedor', 'producao', 'financeiro', 'atendimento') NOT NULL,
  `salario` DECIMAL(10,2) NOT NULL,
  `data_admissao` DATE NOT NULL,
  `data_demissao` DATE NULL,
  `observacoes` TEXT NULL,
  `status` ENUM('ativo', 'inativo', 'ferias', 'licenca') NOT NULL DEFAULT 'ativo',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  INDEX `fk_funcionarios_usuarios_idx` (`usuario_id` ASC),
  INDEX `fk_funcionarios_enderecos_idx` (`endereco_id` ASC),
  CONSTRAINT `fk_funcionarios_usuarios`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuarios` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_funcionarios_enderecos`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `enderecos` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: fornecedores
-- Cadastro de fornecedores de matéria-prima e produtos
-- ============================================================================
CREATE TABLE IF NOT EXISTS `fornecedores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `endereco_id` INT NULL,
  `razao_social` VARCHAR(200) NOT NULL,
  `nome_fantasia` VARCHAR(200) NULL,
  `cnpj` VARCHAR(18) NOT NULL,
  `inscricao_estadual` VARCHAR(20) NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `contato_responsavel` VARCHAR(100) NULL,
  `observacoes` TEXT NULL,
  `status` ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_fornecedores_enderecos_idx` (`endereco_id` ASC),
  CONSTRAINT `fk_fornecedores_enderecos`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `enderecos` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: motoboys
-- Cadastro de entregadores/motoboys
-- ============================================================================
CREATE TABLE IF NOT EXISTS `motoboys` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `endereco_id` INT NULL,
  `nome_completo` VARCHAR(150) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `cnh` VARCHAR(20) NOT NULL,
  `categoria_cnh` VARCHAR(5) NOT NULL,
  `placa_veiculo` VARCHAR(10) NOT NULL,
  `modelo_veiculo` VARCHAR(100) NULL,
  `cor_veiculo` VARCHAR(50) NULL,
  `observacoes` TEXT NULL,
  `status` ENUM('ativo', 'inativo', 'ocupado', 'manutencao') NOT NULL DEFAULT 'ativo',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  UNIQUE INDEX `cnh_UNIQUE` (`cnh` ASC),
  UNIQUE INDEX `placa_veiculo_UNIQUE` (`placa_veiculo` ASC),
  INDEX `fk_motoboys_enderecos_idx` (`endereco_id` ASC),
  CONSTRAINT `fk_motoboys_enderecos`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `enderecos` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: categorias_produtos
-- Categorização dos produtos da chocolateria
-- ============================================================================
CREATE TABLE IF NOT EXISTS `categorias_produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` TEXT NULL,
  `ativo` BOOLEAN NOT NULL DEFAULT TRUE,
  `data_criacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC)
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: produtos
-- Catálogo completo de produtos da chocolateria
-- ============================================================================
CREATE TABLE IF NOT EXISTS `produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `categoria_id` INT NOT NULL,
  `nome` VARCHAR(150) NOT NULL,
  `descricao` TEXT NULL,
  `preco_venda` DECIMAL(10,2) NOT NULL,
  `preco_custo` DECIMAL(10,2) NULL,
  `estoque_atual` INT NOT NULL DEFAULT 0,
  `estoque_minimo` INT NOT NULL DEFAULT 5,
  `unidade_medida` ENUM('unidade', 'kg', 'g', 'caixa', 'pacote') NOT NULL DEFAULT 'unidade',
  `peso_liquido` DECIMAL(8,3) NULL,
  `ingredientes` TEXT NULL,
  `informacoes_nutricionais` TEXT NULL,
  `imagem_url` VARCHAR(500) NULL,
  `ativo` BOOLEAN NOT NULL DEFAULT TRUE,
  `mais_vendido` BOOLEAN NOT NULL DEFAULT FALSE,
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_produtos_categorias_idx` (`categoria_id` ASC),
  INDEX `idx_produtos_ativo` (`ativo` ASC),
  INDEX `idx_produtos_mais_vendido` (`mais_vendido` ASC),
  CONSTRAINT `fk_produtos_categorias`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `categorias_produtos` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: vendas
-- Registro de todas as vendas realizadas
-- ============================================================================
CREATE TABLE IF NOT EXISTS `vendas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NOT NULL,
  `funcionario_id` INT NULL,
  `motoboy_id` INT NULL,
  `numero_pedido` VARCHAR(20) NOT NULL,
  `data_venda` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_entrega` DATETIME NULL,
  `valor_subtotal` DECIMAL(10,2) NOT NULL,
  `valor_desconto` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `valor_frete` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `forma_pagamento` ENUM('dinheiro', 'cartao_credito', 'cartao_debito', 'pix', 'transferencia') NOT NULL,
  `status_pagamento` ENUM('pendente', 'aprovado', 'recusado', 'cancelado') NOT NULL DEFAULT 'pendente',
  `status_entrega` ENUM('preparando', 'saiu_entrega', 'entregue', 'cancelado') NOT NULL DEFAULT 'preparando',
  `observacoes` TEXT NULL,
  `data_atualizacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `numero_pedido_UNIQUE` (`numero_pedido` ASC),
  INDEX `fk_vendas_clientes_idx` (`cliente_id` ASC),
  INDEX `fk_vendas_funcionarios_idx` (`funcionario_id` ASC),
  INDEX `fk_vendas_motoboys_idx` (`motoboy_id` ASC),
  INDEX `idx_vendas_data` (`data_venda` ASC),
  INDEX `idx_vendas_status` (`status_pagamento` ASC, `status_entrega` ASC),
  CONSTRAINT `fk_vendas_clientes`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `clientes` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vendas_funcionarios`
    FOREIGN KEY (`funcionario_id`)
    REFERENCES `funcionarios` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vendas_motoboys`
    FOREIGN KEY (`motoboy_id`)
    REFERENCES `motoboys` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: itens_venda
-- Itens específicos de cada venda
-- ============================================================================
CREATE TABLE IF NOT EXISTS `itens_venda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `venda_id` INT NOT NULL,
  `produto_id` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_unitario` DECIMAL(10,2) NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_itens_venda_vendas_idx` (`venda_id` ASC),
  INDEX `fk_itens_venda_produtos_idx` (`produto_id` ASC),
  CONSTRAINT `fk_itens_venda_vendas`
    FOREIGN KEY (`venda_id`)
    REFERENCES `vendas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_itens_venda_produtos`
    FOREIGN KEY (`produto_id`)
    REFERENCES `produtos` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: compras
-- Registro de compras de matéria-prima e produtos dos fornecedores
-- ============================================================================
CREATE TABLE IF NOT EXISTS `compras` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fornecedor_id` INT NOT NULL,
  `funcionario_id` INT NOT NULL,
  `numero_nota` VARCHAR(50) NULL,
  `data_compra` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_vencimento` DATE NULL,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `status_pagamento` ENUM('pendente', 'pago', 'vencido', 'cancelado') NOT NULL DEFAULT 'pendente',
  `observacoes` TEXT NULL,
  `data_atualizacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_compras_fornecedores_idx` (`fornecedor_id` ASC),
  INDEX `fk_compras_funcionarios_idx` (`funcionario_id` ASC),
  INDEX `idx_compras_data` (`data_compra` ASC),
  INDEX `idx_compras_status` (`status_pagamento` ASC),
  CONSTRAINT `fk_compras_fornecedores`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `fornecedores` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_compras_funcionarios`
    FOREIGN KEY (`funcionario_id`)
    REFERENCES `funcionarios` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: itens_compra
-- Itens específicos de cada compra
-- ============================================================================
CREATE TABLE IF NOT EXISTS `itens_compra` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `compra_id` INT NOT NULL,
  `produto_id` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_unitario` DECIMAL(10,2) NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_itens_compra_compras_idx` (`compra_id` ASC),
  INDEX `fk_itens_compra_produtos_idx` (`produto_id` ASC),
  CONSTRAINT `fk_itens_compra_compras`
    FOREIGN KEY (`compra_id`)
    REFERENCES `compras` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_itens_compra_produtos`
    FOREIGN KEY (`produto_id`)
    REFERENCES `produtos` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: carrinho_compras
-- Carrinho temporário dos clientes (sessão de compra)
-- ============================================================================
CREATE TABLE IF NOT EXISTS `carrinho_compras` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NOT NULL,
  `produto_id` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_unitario` DECIMAL(10,2) NOT NULL,
  `data_adicao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_carrinho_clientes_idx` (`cliente_id` ASC),
  INDEX `fk_carrinho_produtos_idx` (`produto_id` ASC),
  UNIQUE INDEX `cliente_produto_UNIQUE` (`cliente_id` ASC, `produto_id` ASC),
  CONSTRAINT `fk_carrinho_clientes`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `clientes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_carrinho_produtos`
    FOREIGN KEY (`produto_id`)
    REFERENCES `produtos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: movimentacao_estoque
-- Histórico de todas as movimentações de estoque
-- ============================================================================
CREATE TABLE IF NOT EXISTS `movimentacao_estoque` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `produto_id` INT NOT NULL,
  `funcionario_id` INT NOT NULL,
  `tipo_movimentacao` ENUM('entrada', 'saida', 'ajuste', 'perda') NOT NULL,
  `quantidade` INT NOT NULL,
  `estoque_anterior` INT NOT NULL,
  `estoque_atual` INT NOT NULL,
  `motivo` VARCHAR(200) NOT NULL,
  `observacoes` TEXT NULL,
  `data_movimentacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_movimentacao_produtos_idx` (`produto_id` ASC),
  INDEX `fk_movimentacao_funcionarios_idx` (`funcionario_id` ASC),
  INDEX `idx_movimentacao_data` (`data_movimentacao` ASC),
  INDEX `idx_movimentacao_tipo` (`tipo_movimentacao` ASC),
  CONSTRAINT `fk_movimentacao_produtos`
    FOREIGN KEY (`produto_id`)
    REFERENCES `produtos` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_movimentacao_funcionarios`
    FOREIGN KEY (`funcionario_id`)
    REFERENCES `funcionarios` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ============================================================================
-- INSERÇÃO DE DADOS INICIAIS
-- ============================================================================

-- Categorias de Produtos
INSERT INTO `categorias_produtos` (`nome`, `descricao`) VALUES
('Trufas', 'Trufas artesanais com recheios variados'),
('Tabletes', 'Barras de chocolate de diferentes concentrações'),
('Bombons', 'Bombons gourmet com recheios especiais'),
('Box', 'Caixas presente com seleções especiais'),
('Seasonal', 'Produtos sazonais e edições limitadas');

-- Usuários do Sistema
INSERT INTO `usuarios` (`email`, `senha`, `tipo_usuario`) VALUES
('admin@chocolatempo.com.br', SHA2('admin123', 256), 'administrador'),
('joao.silva@email.com', SHA2('cliente123', 256), 'cliente'),
('maria.santos@chocolatempo.com.br', SHA2('func123', 256), 'funcionario');

-- Endereços
INSERT INTO `enderecos` (`cep`, `logradouro`, `numero`, `bairro`, `cidade`, `estado`) VALUES
('89801-123', 'Avenida Nereu Ramos', '156', 'Centro', 'Chapecó', 'SC'),
('01234-567', 'Rua das Flores', '123', 'Centro', 'São Paulo', 'SP'),
('89805-456', 'Rua Presidente Vargas', '789', 'Efapi', 'Chapecó', 'SC');

-- Clientes
INSERT INTO `clientes` (`usuario_id`, `endereco_id`, `nome_completo`, `cpf`, `telefone`, `data_nascimento`, `observacoes`) VALUES
(2, 2, 'João Silva Santos', '123.456.789-00', '(11) 99999-9999', '1990-01-01', 'Cliente da loja física');

-- Funcionários
INSERT INTO `funcionarios` (`usuario_id`, `endereco_id`, `nome_completo`, `cpf`, `telefone`, `cargo`, `salario`, `data_admissao`) VALUES
(1, 1, 'Administrador Sistema', '111.111.111-11', '(49) 98836-3000', 'administrador', 5000.00, '2024-01-01'),
(3, 3, 'Maria Santos Silva', '222.222.222-22', '(49) 99999-1234', 'vendedor', 2500.00, '2024-06-01');

-- Fornecedores
INSERT INTO `fornecedores` (`endereco_id`, `razao_social`, `nome_fantasia`, `cnpj`, `telefone`, `email`, `contato_responsavel`) VALUES
(NULL, 'Cacau Premium Ltda', 'Cacau Premium', '12.345.678/0001-90', '(11) 3333-4444', 'contato@cacaupremium.com.br', 'Carlos Mendes'),
(NULL, 'Doces Ingredientes S.A.', 'Doces & Cia', '98.765.432/0001-10', '(47) 2222-3333', 'vendas@docescia.com.br', 'Ana Paula');

-- Motoboys
INSERT INTO `motoboys` (`nome_completo`, `cpf`, `telefone`, `cnh`, `categoria_cnh`, `placa_veiculo`, `modelo_veiculo`, `cor_veiculo`) VALUES
('Pedro Oliveira Costa', '333.333.333-33', '(49) 98888-7777', '12345678901', 'A', 'ABC-1234', 'Honda CG 160', 'Vermelha'),
('Lucas Ferreira Lima', '444.444.444-44', '(49) 97777-6666', '10987654321', 'A', 'XYZ-9876', 'Yamaha Factor 125', 'Azul');

-- Produtos
INSERT INTO `produtos` (`categoria_id`, `nome`, `descricao`, `preco_venda`, `preco_custo`, `estoque_atual`, `estoque_minimo`, `peso_liquido`, `imagem_url`, `mais_vendido`) VALUES
(1, 'Trufa Clássica', 'Trufa artesanal de chocolate ao leite — macia e aveludada. Perfeita para momentos especiais.', 8.90, 4.50, 50, 10, 0.025, './assets/trufaclassica.png', TRUE),
(2, 'Tablete 70% Cacau', 'Intensidade e notas frutadas. Para paladares exigentes que apreciam o verdadeiro chocolate.', 12.50, 6.00, 30, 5, 0.100, './assets/tablete70cacau.png', FALSE),
(3, 'Bombom Caramelo', 'Recheio cremoso com toque de flor de sal. Uma explosão de sabor a cada mordida.', 6.50, 3.20, 75, 15, 0.020, './assets/trufacaramelo.jpg', TRUE),
(2, 'Chocolate Branco', 'O clássico chocolate branco, suave e cremoso. Ideal para quem prefere sabores mais doces.', 9.90, 5.00, 25, 8, 0.100, './assets/chocolatebranco.jpg', FALSE),
(1, 'Trufa Bela', 'Trufa de chocolate branco com raspas de limão. Refrescante e sofisticada.', 9.50, 4.80, 40, 10, 0.025, './assets/trufabela.png', FALSE),
(4, 'Box 6 Sortidos', 'Seleção especial — presente perfeito. 6 unidades dos nossos melhores chocolates.', 49.90, 25.00, 15, 3, 0.150, './assets/box6sortidos.jpg', TRUE),
(2, 'Tablete Ao Leite', 'Chocolate clássico, cremoso e reconfortante. O preferido das crianças.', 7.90, 4.00, 60, 12, 0.100, './assets/tabletechocolate.png', FALSE),
(3, 'Bombom Amendoim', 'Crocância e doçura na medida certa. Textura única que derrete na boca.', 5.90, 2.90, 80, 20, 0.018, './assets/bombomamendoim.png', FALSE);

-- ============================================================================
-- CRIAÇÃO DE VIEWS PARA RELATÓRIOS
-- ============================================================================

-- View: Relatório de Vendas
CREATE VIEW `vw_relatorio_vendas` AS
SELECT 
    v.id,
    v.numero_pedido,
    v.data_venda,
    c.nome_completo AS cliente,
    c.telefone AS telefone_cliente,
    f.nome_completo AS funcionario,
    m.nome_completo AS motoboy,
    v.valor_total,
    v.forma_pagamento,
    v.status_pagamento,
    v.status_entrega,
    COUNT(iv.id) AS total_itens
FROM vendas v
JOIN clientes c ON v.cliente_id = c.id
LEFT JOIN funcionarios f ON v.funcionario_id = f.id
LEFT JOIN motoboys m ON v.motoboy_id = m.id
LEFT JOIN itens_venda iv ON v.id = iv.venda_id
GROUP BY v.id;

-- View: Relatório de Estoque
CREATE VIEW `vw_relatorio_estoque` AS
SELECT 
    p.id,
    p.nome,
    cp.nome AS categoria,
    p.estoque_atual,
    p.estoque_minimo,
    p.preco_venda,
    p.preco_custo,
    CASE 
        WHEN p.estoque_atual <= p.estoque_minimo THEN 'Crítico'
        WHEN p.estoque_atual <= (p.estoque_minimo * 2) THEN 'Baixo'
        ELSE 'Normal'
    END AS status_estoque,
    p.ativo
FROM produtos p
JOIN categorias_produtos cp ON p.categoria_id = cp.id;

-- View: Relatório de Compras
CREATE VIEW `vw_relatorio_compras` AS
SELECT 
    c.id,
    c.numero_nota,
    c.data_compra,
    f.razao_social AS fornecedor,
    fu.nome_completo AS funcionario_responsavel,
    c.valor_total,
    c.status_pagamento,
    c.data_vencimento,
    COUNT(ic.id) AS total_itens
FROM compras c
JOIN fornecedores f ON c.fornecedor_id = f.id
JOIN funcionarios fu ON c.funcionario_id = fu.id
LEFT JOIN itens_compra ic ON c.id = ic.compra_id
GROUP BY c.id;

-- ============================================================================
-- CRIAÇÃO DE TRIGGERS
-- ============================================================================

-- Trigger: Atualizar estoque após venda
DELIMITER $$
CREATE TRIGGER `tr_vendas_atualizar_estoque` 
AFTER INSERT ON `itens_venda`
FOR EACH ROW
BEGIN
    DECLARE estoque_anterior INT;
    
    SELECT estoque_atual INTO estoque_anterior 
    FROM produtos WHERE id = NEW.produto_id;
    
    UPDATE produtos 
    SET estoque_atual = estoque_atual - NEW.quantidade 
    WHERE id = NEW.produto_id;
    
    INSERT INTO movimentacao_estoque 
    (produto_id, funcionario_id, tipo_movimentacao, quantidade, estoque_anterior, estoque_atual, motivo)
    VALUES 
    (NEW.produto_id, 1, 'saida', NEW.quantidade, estoque_anterior, estoque_anterior - NEW.quantidade, 'Venda');
END$$

-- Trigger: Atualizar estoque após compra
CREATE TRIGGER `tr_compras_atualizar_estoque` 
AFTER INSERT ON `itens_compra`
FOR EACH ROW
BEGIN
    DECLARE estoque_anterior INT;
    
    SELECT estoque_atual INTO estoque_anterior 
    FROM produtos WHERE id = NEW.produto_id;
    
    UPDATE produtos 
    SET estoque_atual = estoque_atual + NEW.quantidade 
    WHERE id = NEW.produto_id;
    
    INSERT INTO movimentacao_estoque 
    (produto_id, funcionario_id, tipo_movimentacao, quantidade, estoque_anterior, estoque_atual, motivo)
    VALUES 
    (NEW.produto_id, 1, 'entrada', NEW.quantidade, estoque_anterior, estoque_anterior + NEW.quantidade, 'Compra');
END$$

-- Trigger: Atualizar subtotal em itens de venda
CREATE TRIGGER `tr_itens_venda_subtotal` 
BEFORE INSERT ON `itens_venda`
FOR EACH ROW
BEGIN
    SET NEW.subtotal = NEW.quantidade * NEW.preco_unitario;
END$$

-- Trigger: Atualizar subtotal em itens de compra
CREATE TRIGGER `tr_itens_compra_subtotal` 
BEFORE INSERT ON `itens_compra`
FOR EACH ROW
BEGIN
    SET NEW.subtotal = NEW.quantidade * NEW.preco_unitario;
END$$

DELIMITER ;

-- ============================================================================
-- CRIAÇÃO DE PROCEDURES
-- ============================================================================

-- Procedure: Finalizar Venda
DELIMITER $$
CREATE PROCEDURE `sp_finalizar_venda`(
    IN p_cliente_id INT,
    IN p_funcionario_id INT,
    IN p_forma_pagamento VARCHAR(20),
    IN p_valor_frete DECIMAL(10,2),
    IN p_valor_desconto DECIMAL(10,2),
    OUT p_venda_id INT
)
BEGIN
    DECLARE v_numero_pedido VARCHAR(20);
    DECLARE v_valor_subtotal DECIMAL(10,2) DEFAULT 0;
    DECLARE v_valor_total DECIMAL(10,2);
    
    -- Gerar número do pedido
    SET v_numero_pedido = CONCAT('PED', LPAD(LAST_INSERT_ID(), 8, '0'));
    
    -- Calcular subtotal do carrinho
    SELECT SUM(quantidade * preco_unitario) INTO v_valor_subtotal
    FROM carrinho_compras
    WHERE cliente_id = p_cliente_id;
    
    -- Calcular valor total
    SET v_valor_total = v_valor_subtotal + p_valor_frete - p_valor_desconto;
    
    -- Criar venda
    INSERT INTO vendas (cliente_id, funcionario_id, numero_pedido, valor_subtotal, valor_desconto, valor_frete, valor_total, forma_pagamento)
    VALUES (p_cliente_id, p_funcionario_id, v_numero_pedido, v_valor_subtotal, p_valor_desconto, p_valor_frete, v_valor_total, p_forma_pagamento);
    
    SET p_venda_id = LAST_INSERT_ID();
    
    -- Transferir itens do carrinho para a venda
    INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario)
    SELECT p_venda_id, produto_id, quantidade, preco_unitario
    FROM carrinho_compras
    WHERE cliente_id = p_cliente_id;
    
    -- Limpar carrinho
    DELETE FROM carrinho_compras WHERE cliente_id = p_cliente_id;
    
END$$

-- Procedure: Relatório de Vendas por Período
CREATE PROCEDURE `sp_relatorio_vendas_periodo`(
    IN p_data_inicio DATE,
    IN p_data_fim DATE
)
BEGIN
    SELECT 
        DATE(v.data_venda) AS data_venda,
        COUNT(v.id) AS total_vendas,
        SUM(v.valor_total) AS faturamento_total,
        AVG(v.valor_total) AS ticket_medio,
        SUM(iv.quantidade) AS produtos_vendidos
    FROM vendas v
    LEFT JOIN itens_venda iv ON v.id = iv.venda_id
    WHERE DATE(v.data_venda) BETWEEN p_data_inicio AND p_data_fim
    AND v.status_pagamento = 'aprovado'
    GROUP BY DATE(v.data_venda)
    ORDER BY data_venda;
END$$

DELIMITER ;

-- ============================================================================
-- CRIAÇÃO DE ÍNDICES PARA PERFORMANCE
-- ============================================================================

-- Índices para otimizar consultas de relatórios
CREATE INDEX `idx_vendas_periodo` ON `vendas` (`data_venda`, `status_pagamento`);
CREATE INDEX `idx_produtos_categoria_ativo` ON `produtos` (`categoria_id`, `ativo`);
CREATE INDEX `idx_movimentacao_produto_data` ON `movimentacao_estoque` (`produto_id`, `data_movimentacao`);
CREATE INDEX `idx_compras_fornecedor_data` ON `compras` (`fornecedor_id`, `data_compra`);

-- ============================================================================
-- CONFIGURAÇÕES FINAIS
-- ============================================================================

-- Restaurar configurações
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- ============================================================================
-- COMENTÁRIOS FINAIS
-- ============================================================================

/*
ESTRUTURA DO BANCO DE DADOS CHOCOLATEMPO

Este banco de dados foi projetado para atender a todos os requisitos do sistema:

1. GESTÃO DE USUÁRIOS E AUTENTICAÇÃO
   - Controle de acesso por tipo de usuário
   - Senhas criptografadas com SHA2

2. CADASTROS PRINCIPAIS
   - Clientes: CPF único, integração com usuários
   - Funcionários: Gestão de cargos e salários
   - Fornecedores: CNPJ único, dados fiscais
   - Motoboys: CNH e veículos cadastrados

3. GESTÃO DE PRODUTOS
   - Categorização flexível
   - Controle de estoque com mínimos
   - Histórico de movimentações

4. PROCESSO DE VENDAS
   - Carrinho de compras temporário
   - Vendas com múltiplos itens
   - Controle de status de pagamento e entrega

5. GESTÃO DE COMPRAS
   - Registro de compras de fornecedores
   - Controle de pagamentos a fornecedores

6. RELATÓRIOS
   - Views pré-configuradas para relatórios
   - Procedures para consultas complexas

7. INTEGRIDADE E PERFORMANCE
   - Triggers para manter consistência
   - Índices para otimizar consultas
   - Constraints de integridade referencial

Para usar este arquivo no MySQL Workbench:
1. Abra o MySQL Workbench 8.0 CE
2. Conecte-se ao servidor MySQL
3. Abra este arquivo .sql
4. Execute o script completo
5. Verifique a criação do schema 'chocolatempo_db'

*/