-- ============================================================================
-- CHOCOLATEMPO - Versão Simplificada para CRUDs
-- Arquivo SQL para MySQL Workbench 8.0 CE - VERSÃO CRUD BÁSICA
-- Data de Criação: 2025-11-03
-- Versão: 1.0 (Apenas estruturas essenciais para CRUD)
-- ============================================================================

-- Configurações iniciais
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

-- ============================================================================
-- CRIAÇÃO DO SCHEMA
-- ============================================================================
DROP SCHEMA IF EXISTS `chocolatempo_crud`;
CREATE SCHEMA IF NOT EXISTS `chocolatempo_crud` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `chocolatempo_crud`;

-- ============================================================================
-- TABELA: usuarios (Para sistema de login)
-- ============================================================================
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `tipo_usuario` ENUM('administrador', 'cliente', 'funcionario') NOT NULL,
  `status` ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
  `data_criacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: clientes (CRUD Clientes)
-- ============================================================================
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_completo` VARCHAR(150) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `endereco` TEXT NULL,
  `data_nascimento` DATE NOT NULL,
  `observacoes` TEXT NULL,
  `status` ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: funcionarios (CRUD Funcionários)
-- ============================================================================
CREATE TABLE IF NOT EXISTS `funcionarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_completo` VARCHAR(150) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `endereco` TEXT NULL,
  `cargo` VARCHAR(100) NOT NULL,
  `salario` DECIMAL(10,2) NOT NULL,
  `data_admissao` DATE NOT NULL,
  `observacoes` TEXT NULL,
  `status` ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: fornecedores (CRUD Fornecedores)
-- ============================================================================
CREATE TABLE IF NOT EXISTS `fornecedores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `razao_social` VARCHAR(200) NOT NULL,
  `nome_fantasia` VARCHAR(200) NULL,
  `cnpj` VARCHAR(18) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `endereco` TEXT NULL,
  `contato_responsavel` VARCHAR(100) NULL,
  `observacoes` TEXT NULL,
  `status` ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: motoboys (CRUD Motoboys)
-- ============================================================================
CREATE TABLE IF NOT EXISTS `motoboys` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_completo` VARCHAR(150) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `cnh` VARCHAR(20) NOT NULL,
  `categoria_cnh` VARCHAR(5) NOT NULL,
  `placa_veiculo` VARCHAR(10) NOT NULL,
  `modelo_veiculo` VARCHAR(100) NULL,
  `cor_veiculo` VARCHAR(50) NULL,
  `endereco` TEXT NULL,
  `observacoes` TEXT NULL,
  `status` ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo',
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  UNIQUE INDEX `cnh_UNIQUE` (`cnh` ASC),
  UNIQUE INDEX `placa_veiculo_UNIQUE` (`placa_veiculo` ASC)
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: produtos (CRUD Produtos)
-- ============================================================================
CREATE TABLE IF NOT EXISTS `produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `categoria` VARCHAR(100) NOT NULL,
  `descricao` TEXT NULL,
  `preco_venda` DECIMAL(10,2) NOT NULL,
  `preco_custo` DECIMAL(10,2) NULL,
  `estoque_atual` INT NOT NULL DEFAULT 0,
  `estoque_minimo` INT NOT NULL DEFAULT 5,
  `unidade_medida` VARCHAR(20) NOT NULL DEFAULT 'unidade',
  `peso_liquido` DECIMAL(8,3) NULL,
  `imagem_url` VARCHAR(500) NULL,
  `ativo` BOOLEAN NOT NULL DEFAULT TRUE,
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- ============================================================================
-- TABELA: vendas (CRUD Vendas - Simplificado)
-- ============================================================================
CREATE TABLE IF NOT EXISTS `vendas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NOT NULL,
  `funcionario_id` INT NULL,
  `motoboy_id` INT NULL,
  `numero_pedido` VARCHAR(20) NOT NULL,
  `data_venda` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `forma_pagamento` VARCHAR(50) NOT NULL,
  `status_pagamento` VARCHAR(50) NOT NULL DEFAULT 'pendente',
  `status_entrega` VARCHAR(50) NOT NULL DEFAULT 'preparando',
  `observacoes` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `numero_pedido_UNIQUE` (`numero_pedido` ASC),
  INDEX `fk_vendas_clientes_idx` (`cliente_id` ASC),
  INDEX `fk_vendas_funcionarios_idx` (`funcionario_id` ASC),
  INDEX `fk_vendas_motoboys_idx` (`motoboy_id` ASC),
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
-- TABELA: itens_venda (Para detalhar produtos vendidos)
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
-- TABELA: compras (CRUD Compras - Simplificado)
-- ============================================================================
CREATE TABLE IF NOT EXISTS `compras` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fornecedor_id` INT NOT NULL,
  `funcionario_id` INT NOT NULL,
  `numero_nota` VARCHAR(50) NULL,
  `data_compra` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `status_pagamento` VARCHAR(50) NOT NULL DEFAULT 'pendente',
  `observacoes` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_compras_fornecedores_idx` (`fornecedor_id` ASC),
  INDEX `fk_compras_funcionarios_idx` (`funcionario_id` ASC),
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
-- TABELA: itens_compra (Para detalhar produtos comprados)
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
-- INSERÇÃO DE DADOS BÁSICOS PARA TESTE
-- ============================================================================

-- Usuário administrador
INSERT INTO `usuarios` (`email`, `senha`, `tipo_usuario`) VALUES
('admin@chocolatempo.com.br', SHA2('admin123', 256), 'administrador');

-- Dados de exemplo para testes CRUD
INSERT INTO `clientes` (`nome_completo`, `cpf`, `telefone`, `email`, `endereco`, `data_nascimento`) VALUES
('João Silva Santos', '123.456.789-00', '(11) 99999-9999', 'joao.silva@email.com', 'Rua das Flores, 123 - Centro - São Paulo/SP', '1990-01-01'),
('Maria Oliveira Costa', '987.654.321-00', '(11) 88888-8888', 'maria.oliveira@email.com', 'Av. Paulista, 456 - Bela Vista - São Paulo/SP', '1985-05-15');

INSERT INTO `funcionarios` (`nome_completo`, `cpf`, `telefone`, `email`, `endereco`, `cargo`, `salario`, `data_admissao`) VALUES
('Administrador Sistema', '111.111.111-11', '(49) 98836-3000', 'admin@chocolatempo.com.br', 'Av. Nereu Ramos, 156 - Centro - Chapecó/SC', 'Administrador', 5000.00, '2024-01-01'),
('Maria Santos Silva', '222.222.222-22', '(49) 99999-1234', 'maria.santos@chocolatempo.com.br', 'Rua Presidente Vargas, 789 - Efapi - Chapecó/SC', 'Vendedor', 2500.00, '2024-06-01');

INSERT INTO `fornecedores` (`razao_social`, `nome_fantasia`, `cnpj`, `telefone`, `email`, `endereco`, `contato_responsavel`) VALUES
('Cacau Premium Ltda', 'Cacau Premium', '12.345.678/0001-90', '(11) 3333-4444', 'contato@cacaupremium.com.br', 'Rua do Cacau, 100 - Industrial - São Paulo/SP', 'Carlos Mendes'),
('Doces Ingredientes S.A.', 'Doces & Cia', '98.765.432/0001-10', '(47) 2222-3333', 'vendas@docescia.com.br', 'Av. das Indústrias, 200 - Distrito Industrial - Blumenau/SC', 'Ana Paula');

INSERT INTO `motoboys` (`nome_completo`, `cpf`, `telefone`, `cnh`, `categoria_cnh`, `placa_veiculo`, `modelo_veiculo`, `cor_veiculo`, `endereco`) VALUES
('Pedro Oliveira Costa', '333.333.333-33', '(49) 98888-7777', '12345678901', 'A', 'ABC-1234', 'Honda CG 160', 'Vermelha', 'Rua dos Motoqueiros, 50 - São Cristóvão - Chapecó/SC'),
('Lucas Ferreira Lima', '444.444.444-44', '(49) 97777-6666', '10987654321', 'A', 'XYZ-9876', 'Yamaha Factor 125', 'Azul', 'Av. das Entregas, 75 - Passo dos Fortes - Chapecó/SC');

INSERT INTO `produtos` (`nome`, `categoria`, `descricao`, `preco_venda`, `preco_custo`, `estoque_atual`, `estoque_minimo`, `peso_liquido`, `imagem_url`) VALUES
('Trufa Clássica', 'Trufas', 'Trufa artesanal de chocolate ao leite — macia e aveludada. Perfeita para momentos especiais.', 8.90, 4.50, 50, 10, 0.025, './assets/trufaclassica.png'),
('Tablete 70% Cacau', 'Tabletes', 'Intensidade e notas frutadas. Para paladares exigentes que apreciam o verdadeiro chocolate.', 12.50, 6.00, 30, 5, 0.100, './assets/tablete70cacau.png'),
('Bombom Caramelo', 'Bombons', 'Recheio cremoso com toque de flor de sal. Uma explosão de sabor a cada mordida.', 6.50, 3.20, 75, 15, 0.020, './assets/trufacaramelo.jpg'),
('Box 6 Sortidos', 'Box', 'Seleção especial — presente perfeito. 6 unidades dos nossos melhores chocolates.', 49.90, 25.00, 15, 3, 0.150, './assets/box6sortidos.jpg'),
('Chocolate Branco', 'Tabletes', 'O clássico chocolate branco, suave e cremoso. Ideal para quem prefere sabores mais doces.', 9.90, 5.00, 25, 8, 0.100, './assets/chocolatebranco.jpg');

-- ============================================================================
-- CONFIGURAÇÕES FINAIS
-- ============================================================================

-- Restaurar configurações
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- ============================================================================
-- COMENTÁRIOS FINAIS
-- ============================================================================

/*
BANCO DE DADOS CHOCOLATEMPO - VERSÃO CRUD SIMPLIFICADA

Esta versão contém apenas as estruturas essenciais para:

1. CRUD CLIENTES
   - Cadastrar, listar, editar, excluir clientes
   - Campos essenciais: nome, CPF, telefone, email, endereço

2. CRUD FUNCIONÁRIOS  
   - Gestão básica de funcionários
   - Campos: nome, CPF, cargo, salário, dados contato

3. CRUD FORNECEDORES
   - Cadastro de fornecedores
   - Campos: razão social, CNPJ, contato, endereço

4. CRUD MOTOBOYS
   - Gestão de entregadores
   - Campos: nome, CPF, CNH, veículo

5. CRUD PRODUTOS
   - Catálogo de produtos
   - Campos: nome, categoria, preço, estoque

6. CRUD VENDAS/COMPRAS (Básico)
   - Registro simples de vendas e compras
   - Sem automações complexas

VANTAGENS DESTA VERSÃO:
- Mais simples de entender
- Fácil de implementar
- Sem dependências complexas
- Ideal para começar o desenvolvimento
- Pode ser expandida posteriormente

PARA USAR:
1. Execute este script no MySQL Workbench
2. Será criado o schema 'chocolatempo_crud'
3. Pronto para conectar com suas páginas HTML/JS
*/