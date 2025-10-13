RF.001 – Cadastro de Logins de Acesso
RN.001 – O login "Cliente" será utilizado por consumidores que desejarem realizar compras.


RN.002 – O login "Funcionário" será utilizado exclusivamente no sistema interno da empresa.


RN.003 – O login "Administrador" será utilizado para administração geral do sistema.


RN.004 – Logins de clientes serão criados manualmente pelos próprios usuários.


RN.005 – Logins de funcionário e administrador serão criados manualmente pelo administrador.


RN.006 – A confirmação de novos logins será feita por e-mail.



RF.002 – Cadastro de Clientes
RN.007 – Dados obrigatórios: Nome completo, E-mail, CPF, Telefone, Data de nascimento.


RN.008 – Endereço completo será solicitado apenas no momento da compra.


RN.009 – O cliente poderá editar seus dados mediante confirmação por e-mail.



RF.003 – Cadastro de Fornecedores
RN.010 – Dados obrigatórios: CNPJ, Inscrição Estadual, Razão Social, Nome Fantasia, Endereço completo (CEP, Estado, Cidade, Bairro, Rua), Telefone, E-mail.



RF.004 – Cadastro de Produtos
RN.011 – Atributos obrigatórios: Nome, Tipo, Sabor, Preço, Validade, Peso, Fotos.


RN.012 – Produtos sazonais podem ter regras específicas de disponibilidade.



RF.005 – Controle de Estoque
RN.013 – O sistema deve registrar a entrada de produtos.


RN.014 – Deve registrar a validade dos produtos.


RN.015 – O sistema deve emitir alerta quando o estoque estiver abaixo de 10%.



RF.006 – Cadastro de Motoboys
RN.016 – Cadastro realizado manualmente pelo usuário com perfil "Funcionário".


RN.017 – Dados obrigatórios: Nome, CPF, Telefone, CNH, Placa da motocicleta.



RF.007 – Consulta de Etapas do Pedido
RN.018 – Etapas rastreáveis: Em preparação, A caminho, Entregue.


RN.019 – O sistema deve emitir alerta quando o pedido estiver "A caminho".



RF.008 – Formas de Pagamento
RN.020 – Aceitas: PIX, Cartão de crédito/débito, Boleto bancário, Dinheiro.



RF.009 – Cadastro de Funcionários

# Regras de Negócio — Verificação de implementação (checagem)

Este documento lista os requisitos/RNs do projeto e indica se eles existem no site "CHOCOLATEMPO" (Presente / Parcial / Ausente). Para cada item eu comentei onde (arquivo/trecho) foi identificado o comportamento correspondente.

Legenda: [X] Presente | [~] Parcialmente implementado | [ ] Ausente


RF.001 – Cadastro de Logins de Acesso

- [~] RN.001 – O login "Cliente" será utilizado por consumidores que desejarem realizar compras.
	- Comentário: presente em `login.html` (select `#role` com option `cliente`). O login é simulado — ao submeter o formulário o usuário é redirecionado para `cliente.html` (ver handler no final de `login.html`). Não há persistência de contas nem autenticação real.

- [ ] RN.002 – O login "Funcionário" será utilizado exclusivamente no sistema interno da empresa.
	- Comentário: não encontrado. Em `login.html` não há opção "Funcionário" (apenas `cliente` e `admin`). Não há fluxo/rota separada para funcionário.

- [~] RN.003 – O login "Administrador" será utilizado para administração geral do sistema.
	- Comentário: opção `admin` existe em `login.html` e redireciona para `index.html` (simulação). Implementação é visual/simulação sem autenticação real.

- [ ] RN.004 – Logins de clientes serão criados manualmente pelos próprios usuários.
	- Comentário: não existe página de registro (signup) — ausente. Não há fluxo para criação de login por usuário.

- [ ] RN.005 – Logins de funcionário e administrador serão criados manualmente pelo administrador.
	- Comentário: não implementado. Não há painel de gestão de contas ou criação de perfis com roles protegidos.

- [ ] RN.006 – A confirmação de novos logins será feita por e-mail.
	- Comentário: não implementado (nenhum envio/validação por e-mail presente nos arquivos estáticos).


RF.002 – Cadastro de Clientes

- [~] RN.007 – Dados obrigatórios: Nome completo, E-mail, CPF, Telefone, Data de nascimento.
	- Comentário: o checkout em `carrinho_cliente.html` exige Nome, CPF, Email e Telefone (campos `#nome`, `#cpf`, `#email`, `#telefone`), porém não há campo para Data de Nascimento. Implementação é do pedido, não de um cadastro persistente de cliente.

- [X] RN.008 – Endereço completo será solicitado apenas no momento da compra.
	- Comentário: implementado em `carrinho_cliente.html` (campos `#cep`, `#rua`, `#numero`, `#bairro`, `#cidade`, `#estado`). Há integração com ViaCEP (`fetch` em `buscarCEP()`) para auto-preenchimento.

- [ ] RN.009 – O cliente poderá editar seus dados mediante confirmação por e-mail.
	- Comentário: ausente. Não existe fluxo de edição de perfil com verificação por e-mail.


RF.003 – Cadastro de Fornecedores

- [~] RN.010 – Dados obrigatórios: CNPJ, Inscrição Estadual, Razão Social, Nome Fantasia, Endereço completo (CEP, Estado, Cidade, Bairro, Rua), Telefone, E-mail.
	- Comentário: o formulário em `cadastro_fornecedor.html` (`#form-fornecedor`) pede Nome da Empresa, CNPJ, Telefone, Email, Produto e Endereço (campo `#endereco`). Inscrição Estadual, Razão Social e Nome Fantasia não estão explicitamente separados — portanto está parcialmente implementado (campos principais como CNPJ, telefone e email existem). Os dados são salvos em `localStorage` (função `salvarFornecedor`).


RF.004 – Cadastro de Produtos

- [~] RN.011 – Atributos obrigatórios: Nome, Tipo, Sabor, Preço, Validade, Peso, Fotos.
	- Comentário: `cadastro_produto.html` fornece campos para Nome (`#nome`), Categoria/Tipo (`#categoria`), Descrição (`#descricao` — onde poderia constar sabor), Preço (`#preco`), Estoque (`#estoque`) e upload de Imagem (`#imagem`). Não há campos separados para Validade e Peso. Armazenamento é feito em `localStorage` (função `salvarProduto`). Portanto, parcial.

- [ ] RN.012 – Produtos sazonais podem ter regras específicas de disponibilidade.
	- Comentário: ausente — não há lógica para disponibilidade sazonal por datas.


RF.005 – Controle de Estoque

- [X] RN.013 – O sistema deve registrar a entrada de produtos.
	- Comentário: presente em `cadastro_produto.html` — ao cadastrar um produto campo `estoque` é salvo junto com o produto em `localStorage` e exibido na listagem (`carregarProdutos`).

- [ ] RN.014 – Deve registrar a validade dos produtos.
	- Comentário: ausente — não há campo de validade nem lógica relacionada.

- [ ] RN.015 – O sistema deve emitir alerta quando o estoque estiver abaixo de 10%.
	- Comentário: ausente — não há mecanismo de alerta/reporte automático quando estoque baixo. Existe a página `relatorio_estoque.html` (link em `relatorios.html`) mas não há código para cálculo/alerta automático no front-end atual.


RF.006 – Cadastro de Motoboys

- [X] RN.016 – Cadastro realizado manualmente pelo usuário com perfil "Funcionário".
	- Comentário: `cadastro_motoboy.html` contém formulário para cadastrar motoboys (`#form-motoboy`) e salvar em `localStorage`. O cadastro é manual via página (presume-se uso por um admin), não há verificação de role. Implementado como página administrativa.

- [~] RN.017 – Dados obrigatórios: Nome, CPF, Telefone, CNH, Placa da motocicleta.
	- Comentário: o formulário exige Nome, CPF, Telefone, Modelo da Moto, Placa, Chassi. Não há campo explícito para CNH — portanto parcial (faltando CNH).


RF.007 – Consulta de Etapas do Pedido

- [ ] RN.018 – Etapas rastreáveis: Em preparação, A caminho, Entregue.
	- Comentário: ausente — não existe sistema de pedidos persistente com status; o fluxo de pedido é local (simulação) e não há timeline de status.

- [ ] RN.019 – O sistema deve emitir alerta quando o pedido estiver "A caminho".
	- Comentário: ausente — nenhuma lógica de notificação/alerta de status implementada.


RF.008 – Formas de Pagamento

- [X] RN.020 – Aceitas: PIX, Cartão de crédito/débito, Boleto bancário, Dinheiro.
	- Comentário: implementado em `carrinho_cliente.html` (select `#pagamento` com opções `cartao`, `pix`, `boleto`, `dinheiro`). A seleção exibe campos/detalhes correspondentes (função `inicializarEventos()` / `detalhes-pagamento`).


RF.009 – Cadastro de Funcionários

- [ ] RN.021 – Cadastro feito manualmente pelo administrador.
	- Comentário: não há página específica para "Funcionários" (há cadastro de motoboys). Não existe separação de perfis administrativos para criar funcionários.

- [ ] RN.022 – Dados obrigatórios: Nome completo, E-mail, CPF, Telefone, Data de nascimento.
	- Comentário: ausente — não existe formulário de funcionários com esses campos completos.

- [ ] RN.023 – Em caso de desligamento, outro funcionário poderá ser cadastrado.
	- Comentário: não aplicável/ausente de forma explícita (não há gestão de empregados).


RF.010 – Geração de Relatórios

- [X] RN.025 – Relatórios devem ser organizados e agrupados por tipo (Entradas, Saídas, Estoque, Motoboy).
	- Comentário: `relatorios.html` apresenta cartões que direcionam para `relatorio_venda.html`, `relatorio_compra.html` e `relatorio_estoque.html`. A estrutura de navegação para relatórios por tipo está presente.

- [ ] RN.026 – Relatórios exportáveis em PDF e Excel.
	- Comentário: ausente — os relatórios são apenas páginas front-end; não há funcionalidade de exportação para PDF/Excel.


RF.011 – Venda com Mensagens Personalizadas

- [~] RN.027 – O sistema deve permitir que o cliente adicione mensagens personalizadas aos produtos.
	- Comentário: há campo `#observacoes` em `carrinho_cliente.html` que permite adicionar observações ao pedido (mensagem geral). Porém não há campo por item/produto para mensagens individualizadas. Portanto, implementação parcial (mensagem global do pedido existe).


⚙️ Requisitos Não Funcionais

- [X] RNF.011 – O sistema deve ser acessível via dispositivos móveis por navegadores (Chrome, Firefox, Safari, Edge, versão 90+).
	- Comentário: o layout contém media queries e várias páginas são responsivas (`@media` em CSS embutido nos arquivos). Testes básicos indicam comportamento responsivo em `index.html`, `cliente.html`, `carrinho_cliente.html` e páginas administrativas.


Observações finais e recomendações rápidas

- Muitas funcionalidades exigidas nas regras (autenticação real, confirmação por e-mail, controle de validade, alerta de estoque, exportação de relatórios) não estão disponíveis porque o projeto é estático e usa `localStorage` para persistência local.
- Se o objetivo for atender 100% às regras de negócio, recomenda-se implementar um backend (API) com autenticação/roles, banco de dados para produtos/pedidos/usuários, mecanismo de envio de e-mails e geração/exportação de relatórios (PDF/Excel).

Se quiser, eu atualizo este arquivo com referências mais precisas (trechos de código/linhas) ou gero uma lista de tarefas priorizadas para implementar as regras ausentes/partiais. O que prefere? 


