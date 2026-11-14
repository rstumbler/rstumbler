# INSTRUKSI UNTUK CODEX: FASE 3 (PANEL ADMIN)

Tugas: Buat file baru bernama `admin.html` di root folder. Isi dengan kode di bawah ini. Jangan ubah file `index.html` atau file lainnya.

```html
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>Admin - RSTumbler</title>
<style>
:root{--rose:#9d174d;--magenta:#db2777;--pink:#fbcfe8;--blush:#fdf2f8;--ink:#1f1a1c;--muted:#7a6068;--line:#f3d1e3;--radius:16px}
*{margin:0;padding:0;box-sizing:border-box;font-family:system-ui,-apple-system,sans-serif}
body{background:#eef1f5;color:var(--ink);display:flex;justify-content:center;min-height:100vh}
.app{width:100%;max-width:480px;background:#f8f9fb;min-height:100vh;position:relative;padding-bottom:20px}
h1,h2,h3{font-family:Georgia,serif;font-weight:400}
a{text-decoration:none;color:inherit} button{font:inherit;cursor:pointer;border:none;background:none}

/* HEADER */
.header{display:flex;align-items:center;justify-content:space-between;padding:16px 20px;background:#fff;border-bottom:1px solid var(--line);position:sticky;top:0;z-index:10}
.header-title{font-size:16px;font-weight:800}
.btn-logout{font-size:12px;color:#dc2626;font-weight:bold}

/* LOGIN BOX */
.login-box{padding:40px 20px;text-align:center}
.login-box h2{margin-bottom:20px;color:var(--rose)}
.input-group{margin-bottom:14px;text-align:left}
.input-group label{font-size:12px;font-weight:bold;margin-bottom:6px;display:block}
.input-group input{width:100%;padding:12px;border:1px solid var(--line);border-radius:10px;font-size:14px;outline:none}
.btn-login{width:100%;padding:14px;background:var(--rose);color:#fff;border-radius:10px;font-weight:bold;font-size:14px;margin-top:10px}

/* DASHBOARD */
.dash{padding:20px;display:none}
.menu-grid{display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-bottom:20px}
.menu-card{background:#fff;padding:16px;border-radius:12px;border:1px solid var(--line);text-align:center;font-weight:bold;font-size:13px;color:var(--rose)}
.menu-card span{display:block;font-size:24px;margin-bottom:8px}

/* PRODUK LIST */
.section-title{font-size:14px;font-weight:800;margin-bottom:12px;display:flex;justify-content:space-between;align-items:center}
.btn-add-prod{background:var(--magenta);color:#fff;padding:8px 12px;border-radius:8px;font-size:11px}
.prod-card{background:#fff;padding:12px;border-radius:12px;border:1px solid var(--line);margin-bottom:10px;display:flex;gap:12px;align-items:center}
.prod-card img{width:50px;height:50px;border-radius:8px;object-fit:cover;background:var(--blush)}
.prod-info{flex:1}
.prod-name{font-size:13px;font-weight:bold}
.prod-price{font-size:12px;color:var(--rose);font-weight:bold}

/* FORM MODAL */
.overlay{position:fixed;inset:0;background:rgba(0,0,0,.5);display:none;align-items:flex-end;justify-content:center;z-index:100}
.overlay.open{display:flex}
.modal{background:#fff;width:100%;max-width:480px;border-radius:20px 20px 0 0;padding:20px;max-height:90vh;overflow-y:auto}
.modal-header{display:flex;justify-content:space-between;margin-bottom:16px}
.modal-header h3{font-size:16px;font-weight:bold}
.btn-close{font-size:20px;color:var(--muted)}
.form-group{margin-bottom:12px}
.form-group label{font-size:11px;font-weight:bold;display:block;margin-bottom:4px}
.form-group input,.form-group textarea{width:100%;padding:10px;border:1px solid var(--line);border-radius:8px;font-size:13px;outline:none}
.btn-save{width:100%;padding:14px;background:var(--magenta);color:#fff;border-radius:10px;font-weight:bold;font-size:14px;margin-top:10px}
</style>
</head>
<body>
<div class="app">
  <header class="header">
    <div class="header-title">RSTumbler Admin</div>
    <button class="btn-logout" onclick="logout()">Logout</button>
  </header>

  <!-- LOGIN SECTION -->
  <div class="login-box" id="loginSection">
    <h2>Login Admin</h2>
    <div class="input-group">
      <label>Email</label>
      <input type="email" id="email" placeholder="admin@rstumbler.com">
    </div>
    <div class="input-group">
      <label>Password</label>
      <input type="password" id="password" placeholder="••••••••">
    </div>
    <button class="btn-login" id="btnLogin">Masuk</button>
  </div>

  <!-- DASHBOARD SECTION -->
  <div class="dash" id="dashSection">
    <div class="menu-grid">
      <div class="menu-card" onclick="openForm()"><span>📦</span> Tambah Produk</div>
      <div class="menu-card" onclick="alert('Fitur Order segera hadir!')"><span>📋</span> Daftar Order</div>
    </div>

    <div class="section-title">
      <span>Daftar Produk</span>
    </div>
    <div id="productList">
      <!-- Produk dimuat via JS -->
    </div>
  </div>

  <!-- MODAL FORM PRODUK -->
  <div class="overlay" id="overlay">
    <div class="modal">
      <div class="modal-header">
        <h3>Tambah Produk</h3>
        <button class="btn-close" onclick="closeForm()">✕</button>
      </div>
      <form id="formProduk">
        <div class="form-group">
          <label>Nama Produk</label>
          <input type="text" id="pName" required>
        </div>
        <div class="form-group">
          <label>Harga Jual (Rp)</label>
          <input type="number" id="pPrice" required>
        </div>
        <div class="form-group">
          <label>Harga Modal (Rp)</label>
          <input type="number" id="pCost" required>
        </div>
        <div class="form-group">
          <label>URL Gambar (Opsional)</label>
          <input type="url" id="pImage" placeholder="https://...">
        </div>
        <div class="form-group">
          <label>Ukuran (Pisahkan koma)</label>
          <input type="text" id="pSizes" placeholder="500ml, 750ml">
        </div>
        <div class="form-group">
          <label>Warna (Pisahkan koma)</label>
          <input type="text" id="pColors" placeholder="Pink, Ungu">
        </div>
        <button type="submit" class="btn-save">Simpan Produk</button>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
<script src="/runtime-config.js"></script>
<script>
  // ===== CONFIG =====
  const CONFIG = window.SELARA_CONFIG || {};
  let supabaseClient = null;
  if (CONFIG.supabaseUrl && CONFIG.supabaseAnonKey) {
    supabaseClient = supabase.createClient(CONFIG.supabaseUrl, CONFIG.supabaseAnonKey);
  }

  const loginSection = document.getElementById('loginSection');
  const dashSection = document.getElementById('dashSection');
  const overlay = document.getElementById('overlay');

  // Cek Sesi Login (LocalStorage)
  if (localStorage.getItem('rstumbler_admin') === 'true') {
    showDashboard();
  }

  // ===== LOGIN LOGIC =====
  document.getElementById('btnLogin').addEventListener('click', async () => {
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const btn = document.getElementById('btnLogin');

    btn.innerText = 'Memproses...';
    btn.disabled = true;

    try {
      const { data, error } = await supabaseClient.auth.signInWithPassword({ email, password });
      if (error) throw error;

      localStorage.setItem('rstumbler_admin', 'true');
      showDashboard();
    } catch (err) {
      alert('Login gagal: ' + err.message);
    } finally {
      btn.innerText = 'Masuk';
      btn.disabled = false;
    }
  });

  function showDashboard() {
    loginSection.style.display = 'none';
    dashSection.style.display = 'block';
    loadProducts();
  }

  async function logout() {
    await supabaseClient.auth.signOut();
    localStorage.removeItem('rstumbler_admin');
    location.reload();
  }

  // ===== AMBIL PRODUK =====
  async function loadProducts() {
    const list = document.getElementById('productList');
    list.innerHTML = '<p style="font-size:12px;text-align:center;color:gray">Memuat...</p>';

    try {
      const { data, error } = await supabaseClient.from('products').select('*').order('created_at', { ascending: false });
      if (error) throw error;

      if (data.length === 0) {
        list.innerHTML = '<p style="font-size:12px;text-align:center;color:gray">Belum ada produk.</p>';
        return;
      }

      const rupiah = (n) => "Rp " + Number(n).toLocaleString("id-ID");
      list.innerHTML = data.map(p => `
        <div class="prod-card">
          <img src="${p.image_url || 'https://via.placeholder.com/100/fbcfe8/9d174d?text=Foto'}">
          <div class="prod-info">
            <div class="prod-name">${p.name}</div>
            <div class="prod-price">${rupiah(p.price)}</div>
          </div>
        </div>
      `).join('');

    } catch (err) {
      list.innerHTML = `<p style="font-size:12px;color:red">Error: ${err.message}</p>`;
    }
  }

  // ===== FORM TAMBAH PRODUK =====
  function openForm() { overlay.classList.add('open'); }
  function closeForm() { overlay.classList.remove('open'); }

  document.getElementById('formProduk').addEventListener('submit', async (e) => {
    e.preventDefault();
    const btn = e.target.querySelector('.btn-save');
    btn.innerText = 'Menyimpan...';

    const sizesArray = document.getElementById('pSizes').value.split(',').map(s => s.trim()).filter(Boolean);
    const colorsArray = document.getElementById('pColors').value.split(',').map(s => s.trim()).filter(Boolean);

    const newProduct = {
      name: document.getElementById('pName').value,
      price: Number(document.getElementById('pPrice').value),
      cost_price: Number(document.getElementById('pCost').value),
      image_url: document.getElementById('pImage').value || null,
      sizes: sizesArray.length ? sizesArray : null,
      colors: colorsArray.length ? colorsArray : null
    };

    try {
      const { error } = await supabaseClient.from('products').insert([newProduct]);
      if (error) throw error;

      alert('Produk berhasil ditambahkan!');
      closeForm();
      document.getElementById('formProduk').reset();
      loadProducts();

    } catch (err) {
      alert('Gagal: ' + err.message);
    } finally {
      btn.innerText = 'Simpan Produk';
    }
  });
</script>
</body>
</html>