# CHOCOLATEMPO

Pequena loja de chocolates artesanais construída como projeto frontend estático. Fornece listagem de produtos, filtros por categoria/preço, busca, painel simples para cadastro (páginas de exemplo) e um carrinho de compras que usa `localStorage` para persistir itens no navegador.

## Recursos

- Lista de produtos com imagens, preço e descrição
- Busca por nome/descrição
- Filtros por categoria e faixa de preço
- Badges de "Mais Vendido"
- Carrinho de compras armazenado em `localStorage` (página de carrinho disponível)
- Modal para confirmar adição ao carrinho e visualização rápida do produto
- Layout responsivo para mobile/tablet/desktop

## Páginas incluídas

- `index.html` — Página principal com catálogo e filtros
- `cadastro_produto.html` — Tela de cadastro/edição de produtos (exemplo)
- `cadastro_motoboy.html` — Tela de cadastro de motoboys (exemplo)
- `cadastro_fornecedor.html` — Tela de cadastro de fornecedores (exemplo)
- `carrinho.html` / `carrinho_cliente.html` — Páginas relacionadas ao carrinho/checkout
- `cliente.html` — Página de cliente (exemplo)
- `login.html` — Tela de login (exemplo)
- `relatorios.html`, `relatorio_compra.html`, `relatorio_estoque.html`, `relatorio_venda.html` — Páginas de relatórios (exemplo)
- `script.js` — Lógica principal do front-end para listagem, filtros e carrinho
- `style.css` — Estilos principais
- `assets/` — Imagens e ícones usados no projeto

## Tecnologias

- HTML5, CSS3 e JavaScript (ES6)
- Font Awesome (CDN) para ícones

## Como executar localmente

1. Clone ou baixe o repositório para sua máquina.
2. Abra a pasta `Choco Tempo/chocolatempo`.
3. Abra `index.html` no navegador (duplo-clique ou arraste para a janela do navegador).

Observação: o projeto é estático; não há backend incluído. Funcionalidades como cadastro e relatórios são mockups de frontend. O carrinho usa `localStorage`, portanto funciona apenas no navegador local.

## Possíveis melhorias

- Salvar/recuperar produtos de uma API / banco de dados
- Implementar autenticação real e proteção de rotas
- Integração com gateway de pagamento (ex.: Stripe)
- Otimizar imagens (WebP) e adicionar lazy-loading (`loading="lazy"`)
- Adicionar testes automatizados e pipeline de CI
- Adicionar validação mais robusta de formulários

## Estrutura do projeto

```
chocolatempo/
├─ assets/                # imagens e ícones
├─ cadastro_fornecedor.html
├─ cadastro_motoboy.html
├─ cadastro_produto.html
├─ carrinho.html
├─ carrinho_cliente.html
├─ cliente.html
├─ index.html
├─ login.html
├─ relatorios.html
├─ relatorio_compra.html
├─ relatorio_estoque.html
├─ relatorio_venda.html
├─ script.js
├─ style.css
└─ README.md
```

## Autor

George Lucas — desenvolvedor frontend

Para dúvidas ou melhorias, abra uma issue ou envie mensagem pelo LinkedIn/GitHub.

---