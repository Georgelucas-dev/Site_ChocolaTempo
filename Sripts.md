
# Scripts (JavaScript) — CHOCOLATEMPO

Este arquivo resume o que existe de JavaScript no projeto, separando o que é considerado "básico" (operações de UI e manipulação local simples) e "avançado" (recursos que exigem lógica mais complexa, integração com APIs ou comportamento não trivial). Para cada item indicando o arquivo onde o código está implementado e funções principais.

OBS: o projeto é essencialmente front-end estático e usa `localStorage` como persistência local.

---

## Arquivos JS principais

- `script.js` — principal motor de lógica para catálogo, carrinho, estoque e relatórios.
- Código inline em páginas (`carrinho_cliente.html`, `cadastro_produto.html`, `cadastro_fornecedor.html`, `cadastro_motoboy.html`, `cliente.html`, `index.html`) — cada uma contém scripts específicos para sua página (carregamento de produtos, máscaras, filtros, formulários e UI).

---

## Funcionalidades - Básico

Esses são os comportamentos simples/padrão encontrados no código:

- Manipulação de `localStorage` (persistência local)
	- Arquivo(s): `script.js`, scripts inline nas páginas de cadastro
	- Funções: `getProdutos()`, `setProdutos()`, `getCarrinho()`, `setCarrinho()`, `getVendas()`, `setVendas()`, `getCompras()`, `setCompras()`
	- O que faz: ler/gravar arrays JSON para simular banco de dados local (produtos, carrinho, vendas, compras).

- Renderização de listas/cards
	- Arquivo(s): `script.js`, `cliente.html`/`index.html` inline
	- Funções: `renderProdutos(produtos)`, `renderCarrinho()`, `renderRelatorioVendas()`, `renderRelatorioEstoque()`
	- O que faz: cria elementos DOM (cards, linhas de tabela) dinamicamente com base nos arrays do `localStorage`.

- Filtros e busca simples
	- Arquivo(s): `script.js`, `cliente.html`/`index.html` inline
	- Funções: `aplicarFiltro()`, `filtrarProdutos()` (nome similar em páginas diferentes)
	- O que faz: filtra arrays em memória por categoria, faixa de preço e termo de busca, atualizando a renderização.

- Carrinho básico (adicionar, remover, alterar quantidade)
	- Arquivo(s): `script.js`, `carrinho_cliente.html` inline
	- Funções: `adicionarCarrinho(id)` / `adicionarAoCarrinho(id)` (varia por arquivo), `removerItem(id)`, `alterarQtd(id, delta)`, `salvarCarrinho()`
	- O que faz: mantém lista de itens no `localStorage`, atualiza estoque local e exibe feedback (alert/toast/modal).

- Formulários com validação simples e máscaras
	- Arquivo(s): `cadastro_produto.html`, `cadastro_fornecedor.html`, `cadastro_motoboy.html`, `carrinho_cliente.html`
	- O que faz: valida campos required no front-end, aplica máscaras para CPF/CNPJ/telefone/placa e previne envios inválidos.

- Interação básica com serviços públicos
	- Arquivo(s): `carrinho_cliente.html`
	- Função: `buscarCEP()` — usa fetch para ViaCEP (https://viacep.com.br/) para auto-preenchimento de endereço.

---

## Funcionalidades - "Avançado" (ou mais complexas)

No contexto deste projeto, "avançado" significa maior lógica, integração externa, ou comportamento que requer cautela:

- Gestão de estoque com decremento automático
	- Arquivo(s): `script.js`, funções: `atualizarEstoque(id, qtd)` chamadas por `adicionarCarrinho`/`alterarQtd`/`removerItem`
	- Por que é avançado: sincroniza inventário com ações do carrinho; exige cuidado para evitar condições de corrida (aqui é single-threaded, mas em backend real exigiria transações).

- Fluxo de finalização de compra e persistência de vendas
	- Arquivo(s): `script.js`, `carrinho_cliente.html`
	- Função: `finalizarCompra()` (ou lógica inline no `checkoutForm.submit` em `carrinho_cliente.html`) — grava vendas em `localStorage`, limpa carrinho e mostra confirmação.
	- Considerações: implementação é síncrona e local; em produção precisaria chamada a API e confirmação de pagamento.

- Geração de relatórios a partir de dados locais
	- Arquivo(s): `script.js`, `relatorios.html` e páginas relacionadas
	- Funções: `renderRelatorioVendas()`, `renderRelatorioEstoque()`
	- O que faz: agrega dados das vendas/produtos do `localStorage` e popula tabelas. Em um sistema real isso exigiria endpoints e geração/exportação (CSV/PDF).

- UI dinâmica de pagamento
	- Arquivo(s): `carrinho_cliente.html` (inline)
	- Função/Comportamento: `inicializarEventos()` altera dinamicamente o DOM para mostrar campos de cartão, pix, boleto, etc. Também inclui validação/formatação dos campos do cartão (formatarCartao, formatarValidade).

- Aplicação de cupons e descontos
	- Arquivo(s): `carrinho_cliente.html` (inline)
	- Lógica: existe objeto `cuponsValidos` e função `aplicarCupom()` que aplica desconto sobre subtotal.

---

## Funções/trechos importantes e onde encontrá-los

- `script.js` (raiz do projeto `chocolatempo`)
	- get/set utilitários: `getProdutos()`, `setProdutos()`, `getCarrinho()`, `setCarrinho()`, `getVendas()` etc.
	- Carrinho: `adicionarCarrinho(id)`, `alterarQtd(id, delta)`, `removerItem(id)`, `finalizarCompra()`
	- Renderização: `renderProdutos(produtos)`, `renderCarrinho()`, `renderRelatorioVendas()`, `renderRelatorioEstoque()`

- `carrinho_cliente.html` (scripts inline)
	- Formulário de checkout (validação), máscaras (`formatarCPF`, `formatarTelefone`, `formatarCEP`), `buscarCEP()` (ViaCEP), `aplicarCupom()`, controle de botão finalizar e lógica de pagamento.

- `cadastro_produto.html` (scripts inline)
	- Inicialização de produtos padrão (`produtosPadrao`), upload/preview de imagem (FileReader), salvar/editar/excluir produtos em `localStorage`.

- `cadastro_fornecedor.html` e `cadastro_motoboy.html` (scripts inline)
	- CRUD simples de fornecedores/motoboys em `localStorage`, máscaras e validações (CNPJ/CPF/telefone/placa).

---

