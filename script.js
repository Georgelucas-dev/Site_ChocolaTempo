// ======================
// ARMAZENAMENTO LOCAL
// ======================
if (!localStorage.getItem('produtos')) {
  const produtos = [
    { id: 1, nome: 'Trufa de Chocolate', categoria: 'Trufas', preco: 12, quantidade: 20, img: 'img/trufa1.jpg' },
    { id: 2, nome: 'Tablete Meio Amargo', categoria: 'Tabletes', preco: 18, quantidade: 15, img: 'img/tablete1.jpg' },
    { id: 3, nome: 'Bombom Recheado', categoria: 'Bombons', preco: 5, quantidade: 50, img: 'img/bombom1.jpg' },
    { id: 4, nome: 'Trufa de Morango', categoria: 'Trufas', preco: 14, quantidade: 10, img: 'img/trufa2.jpg' },
  ];
  localStorage.setItem('produtos', JSON.stringify(produtos));
}

if (!localStorage.getItem('carrinho')) localStorage.setItem('carrinho', JSON.stringify([]));
if (!localStorage.getItem('vendas')) localStorage.setItem('vendas', JSON.stringify([]));
if (!localStorage.getItem('compras')) localStorage.setItem('compras', JSON.stringify([]));

// ======================
// UTILITÁRIOS
// ======================
function getProdutos() { return JSON.parse(localStorage.getItem('produtos')); }
function setProdutos(produtos) { localStorage.setItem('produtos', JSON.stringify(produtos)); }
function getCarrinho() { return JSON.parse(localStorage.getItem('carrinho')); }
function setCarrinho(carrinho) { localStorage.setItem('carrinho', JSON.stringify(carrinho)); }
function getVendas() { return JSON.parse(localStorage.getItem('vendas')); }
function setVendas(vendas) { localStorage.setItem('vendas', JSON.stringify(vendas)); }
function getCompras() { return JSON.parse(localStorage.getItem('compras')); }
function setCompras(compras) { localStorage.setItem('compras', JSON.stringify(compras)); }

// ======================
// FILTRO DE PRODUTOS
// ======================
function aplicarFiltro() {
  const categoria = document.getElementById('filtroCategoria')?.value || 'Todos';
  const preco = document.getElementById('filtroPreco')?.value || 'Todos';
  let produtos = getProdutos();

  if (categoria !== 'Todos') produtos = produtos.filter(p => p.categoria === categoria);
  if (preco !== 'Todos') {
    const [min, max] = preco.split('-').map(Number);
    produtos = produtos.filter(p => p.preco >= min && p.preco <= max);
  }
  renderProdutos(produtos);
}

// ======================
// RENDERIZAÇÃO DE PRODUTOS
// ======================
function renderProdutos(produtos) {
  const container = document.querySelector('.grid');
  if (!container) return;
  container.innerHTML = '';
  produtos.forEach(p => {
    const card = document.createElement('div');
    card.className = 'card';
    card.innerHTML = `
      <div class="card-img"><img src="${p.img}" alt="${p.nome}" style="width:100%;height:100%;object-fit:cover;"></div>
      <h3>${p.nome}</h3>
      <p>Categoria: ${p.categoria}</p>
      <div class="price">R$ ${p.preco.toFixed(2)}</div>
      <button onclick="adicionarCarrinho(${p.id})">Adicionar ao Carrinho</button>
    `;
    container.appendChild(card);
  });
}

// ======================
// CARRINHO DE COMPRAS
// ======================
function adicionarCarrinho(id) {
  const produtos = getProdutos();
  const produto = produtos.find(p => p.id === id);
  if (!produto || produto.quantidade <= 0) {
    alert('Produto indisponível.');
    return;
  }

  let carrinho = getCarrinho();
  const item = carrinho.find(c => c.id === id);
  if (item) item.qtd++;
  else carrinho.push({ id, nome: produto.nome, preco: produto.preco, qtd: 1 });
  setCarrinho(carrinho);
  alert('Produto adicionado ao carrinho!');
  atualizarEstoque(id, -1);
  renderProdutos(getProdutos());
}

function atualizarEstoque(id, qtd) {
  const produtos = getProdutos();
  const produto = produtos.find(p => p.id === id);
  if (produto) produto.quantidade += qtd;
  setProdutos(produtos);
}

// ======================
// RENDERIZAÇÃO CARRINHO
// ======================
function renderCarrinho() {
  const container = document.querySelector('.table tbody');
  if (!container) return;
  container.innerHTML = '';
  const carrinho = getCarrinho();
  if (carrinho.length === 0) {
    container.innerHTML = `<tr><td colspan="5" style="text-align:center;">Carrinho vazio</td></tr>`;
    return;
  }
  carrinho.forEach(item => {
    const row = document.createElement('tr');
    row.innerHTML = `
      <td>${item.nome}</td>
      <td>R$ ${item.preco.toFixed(2)}</td>
      <td>
        <button onclick="alterarQtd(${item.id}, -1)">-</button>
        ${item.qtd}
        <button onclick="alterarQtd(${item.id}, 1)">+</button>
      </td>
      <td>R$ ${(item.preco*item.qtd).toFixed(2)}</td>
      <td><button onclick="removerItem(${item.id})">Remover</button></td>
    `;
    container.appendChild(row);
  });
}

function alterarQtd(id, delta) {
  let carrinho = getCarrinho();
  const item = carrinho.find(i => i.id === id);
  if (!item) return;
  item.qtd += delta;
  if (item.qtd <= 0) {
    removerItem(id);
    return;
  }
  setCarrinho(carrinho);
  renderCarrinho();
  atualizarEstoque(id, -delta);
}

function removerItem(id) {
  let carrinho = getCarrinho();
  const item = carrinho.find(i => i.id === id);
  if (!item) return;
  atualizarEstoque(id, item.qtd);
  carrinho = carrinho.filter(i => i.id !== id);
  setCarrinho(carrinho);
  renderCarrinho();
}

// ======================
// FINALIZAR COMPRA
// ======================
function finalizarCompra() {
  const carrinho = getCarrinho();
  if (carrinho.length === 0) { alert('Carrinho vazio'); return; }
  const vendas = getVendas();
  const data = new Date().toLocaleString();
  carrinho.forEach(item => vendas.push({ ...item, data }));
  setVendas(vendas);
  setCarrinho([]);
  alert('Compra realizada com sucesso!');
  renderCarrinho();
  renderProdutos(getProdutos());
}

// ======================
// RELATÓRIOS
// ======================
function renderRelatorioVendas() {
  const container = document.querySelector('.table tbody');
  if (!container) return;
  const vendas = getVendas();
  if (!vendas.length) {
    container.innerHTML = `<tr><td colspan="4" style="text-align:center;">Nenhuma venda</td></tr>`;
    return;
  }
  container.innerHTML = '';
  vendas.forEach(v => {
    const row = document.createElement('tr');
    row.innerHTML = `
      <td>${v.nome}</td>
      <td>${v.qtd}</td>
      <td>R$ ${(v.preco*v.qtd).toFixed(2)}</td>
      <td>${v.data}</td>
    `;
    container.appendChild(row);
  });
}

function renderRelatorioEstoque() {
  const container = document.querySelector('.table tbody');
  if (!container) return;
  const produtos = getProdutos();
  container.innerHTML = '';
  produtos.forEach(p => {
    const row = document.createElement('tr');
    row.innerHTML = `
      <td>${p.nome}</td>
      <td>${p.categoria}</td>
      <td>${p.quantidade}</td>
      <td>R$ ${p.preco.toFixed(2)}</td>
    `;
    container.appendChild(row);
  });
}
