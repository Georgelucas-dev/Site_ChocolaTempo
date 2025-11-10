# 📊 PASSO A PASSO: Diagrama de Entidade-Relacionamento (ER) - ChocolaTempo

## 📋 Índice
1. [Preparação](#preparação)
2. [Entidades Principais](#entidades-principais)
3. [Relacionamentos](#relacionamentos)
4. [Criação Manual](#criação-manual)
5. [Criação com MySQL Workbench](#criação-com-mysql-workbench)
6. [Validação Final](#validação-final)

---

## 🛠️ Preparação

### Ferramentas Recomendadas:
- **MySQL Workbench** (ideal para modelagem)
- **Draw.io/Lucidchart** (alternativa online)
- **BR Modelo** (ferramenta brasileira)
- **Papel e caneta** (para esboço inicial)

### Símbolos Padrão:
- 🔹 **Retângulo**: Entidades
- 🔸 **Losango**: Relacionamentos
- 🔹 **Elipse**: Atributos
- 🔹 **Elipse dupla**: Atributos multivalorados
- 🔸 **Linha sublinhada**: Chave primária
- 🔸 **Linha pontilhada**: Chave estrangeira

---

## 📦 ENTIDADES PRINCIPAIS

### 1. Entidade: **USUÁRIOS**
```
┌─────────────────┐
│    USUARIOS     │
├─────────────────┤
│ 🔑 id           │ (Chave Primária)
│ • email         │ (Único)
│ • senha         │
│ • tipo_usuario  │ (ENUM: administrador, cliente, funcionario)
│ • data_criacao  │
│ • status        │ (ENUM: ativo, inativo, bloqueado)
└─────────────────┘
```

### 2. Entidade: **ENDERECOS**
```
┌─────────────────┐
│   ENDERECOS     │
├─────────────────┤
│ 🔑 id           │ (Chave Primária)
│ • cep           │
│ • logradouro    │
│ • numero        │
│ • complemento   │
│ • bairro        │
│ • cidade        │
│ • estado        │
│ • pais          │
└─────────────────┘
```

### 3. Entidade: **CLIENTES**
```
┌─────────────────┐
│    CLIENTES     │
├─────────────────┤
│ 🔑 id           │ (Chave Primária)
│ 🔗 usuario_id   │ (Chave Estrangeira → usuarios.id)
│ 🔗 endereco_id  │ (Chave Estrangeira → enderecos.id)
│ • nome_completo │
│ • cpf           │ (Único)
│ • telefone      │
│ • data_nascimento │
│ • observacoes   │
│ • status        │
│ • data_cadastro │
└─────────────────┘
```

### 4. Entidade: **FUNCIONARIOS**
```
┌─────────────────┐
│  FUNCIONARIOS   │
├─────────────────┤
│ 🔑 id           │ (Chave Primária)
│ 🔗 usuario_id   │ (Chave Estrangeira → usuarios.id)
│ 🔗 endereco_id  │ (Chave Estrangeira → enderecos.id)
│ • nome_completo │
│ • cpf           │ (Único)
│ • telefone      │
│ • cargo         │
│ • salario       │
│ • data_admissao │
│ • status        │
└─────────────────┘
```

### 5. Entidade: **FORNECEDORES**
```
┌─────────────────┐
│  FORNECEDORES   │
├─────────────────┤
│ 🔑 id           │ (Chave Primária)
│ 🔗 endereco_id  │ (Chave Estrangeira → enderecos.id)
│ • razao_social  │
│ • nome_fantasia │
│ • cnpj          │ (Único)
│ • inscricao_estadual │
│ • telefone      │
│ • email         │ (Único)
│ • contato_responsavel │
│ • status        │
└─────────────────┘
```

### 6. Entidade: **MOTOBOYS**
```
┌─────────────────┐
│    MOTOBOYS     │
├─────────────────┤
│ 🔑 id           │ (Chave Primária)
│ 🔗 endereco_id  │ (Chave Estrangeira → enderecos.id)
│ • nome_completo │
│ • cpf           │ (Único)
│ • telefone      │
│ • cnh           │ (Único)
│ • categoria_cnh │
│ • placa_veiculo │ (Único)
│ • modelo_veiculo │
│ • cor_veiculo   │
│ • status        │
└─────────────────┘
```

### 7. Entidade: **CATEGORIAS_PRODUTOS**
```
┌─────────────────┐
│ CATEGORIAS_PRODUTOS │
├─────────────────┤
│ 🔑 id           │ (Chave Primária)
│ • nome          │ (Único)
│ • descricao     │
│ • ativo         │
│ • data_criacao  │
└─────────────────┘
```

### 8. Entidade: **PRODUTOS**
```
┌─────────────────┐
│    PRODUTOS     │
├─────────────────┤
│ 🔑 id           │ (Chave Primária)
│ 🔗 categoria_id │ (Chave Estrangeira → categorias_produtos.id)
│ • nome          │
│ • descricao     │
│ • preco_venda   │
│ • preco_custo   │
│ • estoque_atual │
│ • estoque_minimo │
│ • unidade_medida │
│ • peso_liquido  │
│ • ingredientes  │
│ • imagem_url    │
│ • ativo         │
│ • mais_vendido  │
└─────────────────┘
```

### 9. Entidade: **VENDAS**
```
┌─────────────────┐
│     VENDAS      │
├─────────────────┤
│ 🔑 id           │ (Chave Primária)
│ 🔗 cliente_id   │ (Chave Estrangeira → clientes.id)
│ 🔗 funcionario_id │ (Chave Estrangeira → funcionarios.id)
│ 🔗 motoboy_id   │ (Chave Estrangeira → motoboys.id)
│ • numero_pedido │ (Único)
│ • data_venda    │
│ • data_entrega  │
│ • valor_subtotal │
│ • valor_desconto │
│ • valor_frete   │
│ • valor_total   │
│ • forma_pagamento │
│ • status_pagamento │
│ • status_entrega │
│ • observacoes   │
└─────────────────┘
```

### 10. Entidade: **ITENS_VENDA**
```
┌─────────────────┐
│   ITENS_VENDA   │
├─────────────────┤
│ 🔑 id           │ (Chave Primária)
│ 🔗 venda_id     │ (Chave Estrangeira → vendas.id)
│ 🔗 produto_id   │ (Chave Estrangeira → produtos.id)
│ • quantidade    │
│ • preco_unitario │
│ • subtotal      │
└─────────────────┘
```

### 11. Entidade: **COMPRAS**
```
┌─────────────────┐
│     COMPRAS     │
├─────────────────┤
│ 🔑 id           │ (Chave Primária)
│ 🔗 fornecedor_id │ (Chave Estrangeira → fornecedores.id)
│ 🔗 funcionario_id │ (Chave Estrangeira → funcionarios.id)
│ • numero_nota   │
│ • data_compra   │
│ • data_vencimento │
│ • valor_total   │
│ • status_pagamento │
│ • observacoes   │
└─────────────────┘
```

### 12. Entidade: **ITENS_COMPRA**
```
┌─────────────────┐
│  ITENS_COMPRA   │
├─────────────────┤
│ 🔑 id           │ (Chave Primária)
│ 🔗 compra_id    │ (Chave Estrangeira → compras.id)
│ 🔗 produto_id   │ (Chave Estrangeira → produtos.id)
│ • quantidade    │
│ • preco_unitario │
│ • subtotal      │
└─────────────────┘
```

### 13. Entidade: **CARRINHO_COMPRAS**
```
┌─────────────────┐
│ CARRINHO_COMPRAS │
├─────────────────┤
│ 🔑 id           │ (Chave Primária)
│ 🔗 cliente_id   │ (Chave Estrangeira → clientes.id)
│ 🔗 produto_id   │ (Chave Estrangeira → produtos.id)
│ • quantidade    │
│ • preco_unitario │
│ • data_adicao   │
└─────────────────┘
```

### 14. Entidade: **MOVIMENTACAO_ESTOQUE**
```
┌─────────────────┐
│ MOVIMENTACAO_ESTOQUE │
├─────────────────┤
│ 🔑 id           │ (Chave Primária)
│ 🔗 produto_id   │ (Chave Estrangeira → produtos.id)
│ 🔗 funcionario_id │ (Chave Estrangeira → funcionarios.id)
│ • tipo_movimentacao │
│ • quantidade    │
│ • estoque_anterior │
│ • estoque_atual │
│ • motivo        │
│ • observacoes   │
│ • data_movimentacao │
└─────────────────┘
```

---

## 🔗 RELACIONAMENTOS

### 1. USUARIOS ↔ CLIENTES
- **Tipo**: Um para Um (1:1)
- **Descrição**: Cada usuário pode ter um perfil de cliente
- **Cardinalidade**: `usuarios(1) ← tem → clientes(1)`

### 2. USUARIOS ↔ FUNCIONARIOS
- **Tipo**: Um para Um (1:1)
- **Descrição**: Cada usuário pode ter um perfil de funcionário
- **Cardinalidade**: `usuarios(1) ← tem → funcionarios(1)`

### 3. ENDERECOS ↔ CLIENTES/FUNCIONARIOS/FORNECEDORES/MOTOBOYS
- **Tipo**: Um para Muitos (1:N)
- **Descrição**: Um endereço pode ser usado por múltiplas entidades
- **Cardinalidade**: `enderecos(1) ← localiza → entidades(N)`

### 4. CATEGORIAS_PRODUTOS ↔ PRODUTOS
- **Tipo**: Um para Muitos (1:N)
- **Descrição**: Uma categoria contém vários produtos
- **Cardinalidade**: `categorias_produtos(1) ← contém → produtos(N)`

### 5. CLIENTES ↔ VENDAS
- **Tipo**: Um para Muitos (1:N)
- **Descrição**: Um cliente pode ter várias vendas
- **Cardinalidade**: `clientes(1) ← realiza → vendas(N)`

### 6. FUNCIONARIOS ↔ VENDAS
- **Tipo**: Um para Muitos (1:N)
- **Descrição**: Um funcionário pode processar várias vendas
- **Cardinalidade**: `funcionarios(1) ← processa → vendas(N)`

### 7. MOTOBOYS ↔ VENDAS
- **Tipo**: Um para Muitos (1:N)
- **Descrição**: Um motoboy pode entregar várias vendas
- **Cardinalidade**: `motoboys(1) ← entrega → vendas(N)`

### 8. VENDAS ↔ ITENS_VENDA ↔ PRODUTOS
- **Tipo**: Muitos para Muitos (N:M) via tabela associativa
- **Descrição**: Uma venda tem vários produtos, um produto pode estar em várias vendas
- **Cardinalidade**: `vendas(N) ← contém → itens_venda ← refere → produtos(M)`

### 9. FORNECEDORES ↔ COMPRAS
- **Tipo**: Um para Muitos (1:N)
- **Descrição**: Um fornecedor pode ter várias compras
- **Cardinalidade**: `fornecedores(1) ← fornece → compras(N)`

### 10. FUNCIONARIOS ↔ COMPRAS
- **Tipo**: Um para Muitos (1:N)
- **Descrição**: Um funcionário pode realizar várias compras
- **Cardinalidade**: `funcionarios(1) ← realiza → compras(N)`

### 11. COMPRAS ↔ ITENS_COMPRA ↔ PRODUTOS
- **Tipo**: Muitos para Muitos (N:M) via tabela associativa
- **Descrição**: Uma compra tem vários produtos, um produto pode estar em várias compras
- **Cardinalidade**: `compras(N) ← contém → itens_compra ← refere → produtos(M)`

### 12. CLIENTES ↔ CARRINHO_COMPRAS ↔ PRODUTOS
- **Tipo**: Muitos para Muitos (N:M) via tabela associativa
- **Descrição**: Um cliente pode ter vários produtos no carrinho
- **Cardinalidade**: `clientes(N) ← possui → carrinho_compras ← contém → produtos(M)`

### 13. PRODUTOS ↔ MOVIMENTACAO_ESTOQUE
- **Tipo**: Um para Muitos (1:N)
- **Descrição**: Um produto pode ter várias movimentações de estoque
- **Cardinalidade**: `produtos(1) ← tem → movimentacao_estoque(N)`

### 14. FUNCIONARIOS ↔ MOVIMENTACAO_ESTOQUE
- **Tipo**: Um para Muitos (1:N)
- **Descrição**: Um funcionário pode registrar várias movimentações
- **Cardinalidade**: `funcionarios(1) ← registra → movimentacao_estoque(N)`

---

## ✏️ CRIAÇÃO MANUAL DO DIAGRAMA

### Passo 1: Planejamento no Papel
1. **Faça um esboço inicial** com as 14 entidades principais
2. **Posicione as entidades** de forma que minimize cruzamentos de linhas
3. **Agrupe entidades relacionadas** (ex: vendas, itens_venda, produtos)

### Passo 2: Desenho das Entidades
1. **Desenhe retângulos** para cada entidade
2. **Liste todos os atributos** dentro de cada retângulo
3. **Sublinhe as chaves primárias**
4. **Use cor diferente** para chaves estrangeiras

### Passo 3: Desenho dos Relacionamentos
1. **Conecte as entidades** com linhas
2. **Use losangos** para representar relacionamentos
3. **Adicione cardinalidades** nas extremidades das linhas
4. **Use cores diferentes** para tipos de relacionamento

### Passo 4: Organização Visual
1. **Ajuste posições** para melhor legibilidade
2. **Use cores consistentes** para diferentes tipos de elementos
3. **Adicione legenda** explicando símbolos utilizados

---

## 🖥️ CRIAÇÃO COM MYSQL WORKBENCH

### Passo 1: Preparação
```sql
-- 1. Abra o MySQL Workbench
-- 2. Conecte-se ao servidor MySQL
-- 3. Vá em: File → New Model (Ctrl+N)
-- 4. Clique em "Add Diagram" no painel principal
```

### Passo 2: Importação do Banco Existente
```sql
-- Opção 1: Reverse Engineering (Recomendado)
-- Database → Reverse Engineer
-- Selecione a conexão → chocolatempo_db
-- Selecione todas as tabelas → Execute

-- Opção 2: Importação de Script SQL
-- File → Import → Reverse Engineer MySQL Create Script
-- Selecione o arquivo chocolatempo_database.sql
```

### Passo 3: Criação Manual de Entidades
```sql
-- Se criando manualmente:
-- 1. Clique no ícone "Table" na barra lateral
-- 2. Clique na área do diagrama para criar tabela
-- 3. Duplo-clique na tabela para editar
-- 4. Adicione colunas, tipos de dados, constraints
-- 5. Repita para todas as 14 entidades
```

### Passo 4: Criação de Relacionamentos
```sql
-- 1. Clique no ícone "1:n Non-Identifying Relationship"
-- 2. Clique na tabela pai (que tem a chave primária)
-- 3. Clique na tabela filha (que receberá a chave estrangeira)
-- 4. Ajuste cardinalidades conforme necessário
-- 5. Repita para todos os relacionamentos
```

### Passo 5: Organização Visual
```sql
-- 1. Use a função "Auto Layout" para organização automática
-- 2. Ajuste posições manualmente se necessário
-- 3. Altere cores: clique direito → Edit Object → Colors
-- 4. Adicione comentários: Edit → Preferences → Diagram
```

### Passo 6: Exportação
```sql
-- 1. File → Export → Export as PNG/PDF
-- 2. Escolha resolução e formato
-- 3. Salve o diagrama
```

---

## 📐 LAYOUT SUGERIDO

### Disposição das Entidades:

```
Nível 1 (Topo):
┌─────────────┬─────────────┬─────────────┬─────────────┐
│  USUARIOS   │  ENDERECOS  │ CATEGORIAS_ │  MOTOBOYS   │
│             │             │  PRODUTOS   │             │
└─────────────┴─────────────┴─────────────┴─────────────┘

Nível 2:
┌─────────────┬─────────────┬─────────────┬─────────────┐
│  CLIENTES   │FUNCIONARIOS │ FORNECEDORES│  PRODUTOS   │
└─────────────┴─────────────┴─────────────┴─────────────┘

Nível 3:
┌─────────────┬─────────────┬─────────────┐
│   VENDAS    │   COMPRAS   │ CARRINHO_   │
│             │             │  COMPRAS    │
└─────────────┴─────────────┴─────────────┘

Nível 4:
┌─────────────┬─────────────┬─────────────┐
│ ITENS_VENDA │ITENS_COMPRA │MOVIMENTACAO_│
│             │             │  ESTOQUE    │
└─────────────┴─────────────┴─────────────┘
```

---

## ✅ VALIDAÇÃO FINAL

### Checklist de Verificação:

#### ✅ Entidades
- [ ] Todas as 14 entidades estão representadas
- [ ] Atributos estão completos em cada entidade
- [ ] Chaves primárias estão identificadas
- [ ] Chaves estrangeiras estão marcadas

#### ✅ Relacionamentos
- [ ] Todos os relacionamentos estão conectados
- [ ] Cardinalidades estão corretas
- [ ] Relacionamentos N:M usam tabelas associativas
- [ ] Direção dos relacionamentos está clara

#### ✅ Integridade
- [ ] Não há entidades órfãs (sem relacionamentos)
- [ ] Chaves estrangeiras referenciam chaves primárias válidas
- [ ] Relacionamentos fazem sentido no contexto do negócio

#### ✅ Visual
- [ ] Layout é limpo e legível
- [ ] Não há cruzamentos desnecessários de linhas
- [ ] Cores ajudam na compreensão
- [ ] Legenda está presente se necessário

---

## 🎨 DICAS DE FORMATAÇÃO

### Cores Sugeridas:
- **🟦 Azul**: Entidades principais (clientes, produtos, vendas)
- **🟩 Verde**: Entidades de controle (usuarios, enderecos)
- **🟨 Amarelo**: Entidades de apoio (categorias, motoboys)
- **🟪 Roxo**: Tabelas associativas (itens_venda, itens_compra)
- **🟧 Laranja**: Entidades de gestão (funcionarios, fornecedores)

### Elementos Visuais:
- **Linha sólida**: Relacionamento identificador
- **Linha pontilhada**: Relacionamento não-identificador
- **Linha dupla**: Relacionamento opcional
- **Seta**: Direção do relacionamento

---

## 📊 EXEMPLO DE RELACIONAMENTO DETALHADO

### Relacionamento: VENDAS ↔ ITENS_VENDA ↔ PRODUTOS

```
     VENDAS                 ITENS_VENDA               PRODUTOS
┌─────────────┐           ┌─────────────┐           ┌─────────────┐
│ 🔑 id       │←─────────┤│ 🔑 id       │           │ 🔑 id       │
│ • cliente_id│     1:N  ││ 🔗 venda_id │           │ • nome      │
│ • data_venda│           ││ 🔗 produto_id│←─────────┤│ • preco     │
│ • valor_total│          ││ • quantidade│     N:1  ││ • estoque   │
└─────────────┘           └─────────────┘           └─────────────┘

Cardinalidade:
- Uma VENDA pode ter muitos ITENS_VENDA (1:N)
- Um ITEM_VENDA refere-se a um PRODUTO (N:1)
- Um PRODUTO pode estar em muitos ITENS_VENDA (1:N)
```

---

## 🚀 PRÓXIMOS PASSOS

Após criar o diagrama ER:

1. **📋 Documentação**: Crie documentação detalhada dos relacionamentos
2. **🔍 Revisão**: Faça revisão com stakeholders do projeto
3. **⚡ Otimização**: Identifique pontos de otimização no banco
4. **📈 Evolução**: Planeje futuras expansões do modelo
5. **🧪 Testes**: Valide o modelo com dados reais

---

**💡 Dica Final**: Mantenha o diagrama atualizado conforme o banco evolui. Use versionamento para controlar mudanças no modelo de dados.