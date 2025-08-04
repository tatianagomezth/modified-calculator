<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Invoice Form</title>
<style>
  :root{
    --bg:#f6f8fb;
    --panel:#ffffff;
    --ink:#0f172a;
    --muted:#6b7280;
    --blue:#2046d9;
    --blue-2:#2f6bff;
    --line:#e5e7eb;
    --shadow:0 6px 24px rgba(15,23,42,.06), 0 2px 8px rgba(15,23,42,.04);
    --radius:14px;
  }
  *{box-sizing:border-box}
  body{
    margin:0; padding:20px;
    background:var(--bg); color:var(--ink);
    font:15px/1.45 system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
  }
  .wrap{
    max-width:920px; margin:0 auto; background:transparent;
  }
  .card{
    background:var(--panel); border-radius:20px; box-shadow:var(--shadow);
    padding:22px; border:1px solid #eef1f6;
  }
  .header{
    background:linear-gradient(135deg, var(--blue), var(--blue-2));
    border-radius:12px; color:#fff; padding:18px 18px 14px; margin-bottom:18px;
  }
  .header h1{margin:0 0 10px; font-size:22px}
  .row{display:grid; gap:10px}
  .row.cols-2{grid-template-columns:1fr 1fr}
  .row.cols-3{grid-template-columns:1fr 1fr 1fr}
  .input{
    background:rgba(255,255,255,.12); border:1px solid rgba(255,255,255,.2);
    color:#eef2ff; padding:10px 12px; border-radius:10px; outline:none;
  }
  .input::placeholder{color:#dbe4ff}
  .section-title{
    font-weight:700; font-size:20px; margin:10px 0 4px;
  }
  label.small{color:var(--muted); font-size:13px; display:inline-flex; align-items:center; gap:8px; margin:10px 0}
  input[type="text"], input[type="number"], input[type="date"], textarea{
    width:100%; padding:12px 12px; border-radius:10px; border:1px solid var(--line);
    background:#f8fafc; outline:none; transition:border .15s ease, box-shadow .15s ease;
  }
  textarea{min-height:72px; resize:vertical}
  input:focus, textarea:focus{border-color:#bcd0ff; box-shadow:0 0 0 4px rgba(59,130,246,.12)}
  .table{
    margin-top:14px; border:1px solid var(--line); border-radius:12px; overflow:hidden; background:#fff;
  }
  .thead{
    background:#1f3fb6; color:#fff; font-weight:700; padding:12px 14px;
    display:grid; grid-template-columns:2fr 1fr;
  }
  .trow{
    display:grid; grid-template-columns:2fr 1fr; gap:12px; padding:12px; border-top:1px solid var(--line);
  }
  .btn{
    display:inline-block; border:0; background:#2046d9; color:#fff; padding:10px 16px;
    border-radius:10px; cursor:pointer; font-weight:600; box-shadow:0 4px 16px rgba(32,70,217,.18);
  }
  .btn:active{transform:translateY(1px)}
  .mt-10{margin-top:10px}
  .totals{
    margin-top:24px; display:grid; grid-template-columns:1fr 260px; gap:16px; align-items:start;
  }
  .total-box{
    border:1px solid var(--line); border-radius:12px; padding:14px; background:#fff;
  }
  .line{display:flex; justify-content:space-between; align-items:center; padding:8px 0; border-bottom:1px dashed #e8eaf0}
  .line:last-child{border-bottom:0}
  .money{font-weight:700}
  .field-mini{width:92px}
  .total-bar{
    margin-top:12px; background:#2046d9; color:#fff; padding:14px 16px; border-radius:10px;
    display:flex; justify-content:space-between; font-weight:800; letter-spacing:.2px;
  }
  .muted{color:var(--muted)}
</style>
</head>
<body>
  <div class="wrap">
    <div class="card">
      <!-- Top header -->
      <div class="header">
        <h1>Company Name</h1>
        <div class="row cols-1">
          <input class="input" placeholder="Address, City, ST, ZIP Code" />
          <div class="row cols-2">
            <input class="input" placeholder="Phone Number" />
            <input class="input" placeholder="Fax Number" />
          </div>
        </div>
      </div>

      <!-- Invoice meta -->
      <div class="row cols-3" style="align-items:center; gap:14px;">
        <label class="small"><strong>Invoice #</strong>
          <input type="text" id="invoiceNumber" value="100" style="width:92px;">
        </label>
        <div></div>
        <label class="small"><strong>Date:</strong>
          <input type="date" id="invoiceDate" placeholder="dd/mm/aaaa">
        </label>
      </div>

      <!-- Bill To / For -->
      <div class="row cols-2" style="gap:18px; margin-top:14px;">
        <div>
          <div class="section-title">Bill To</div>
          <input type="text" id="billName" placeholder="Name | Company">
          <textarea id="billAddress" placeholder="Address, City, ST, ZIP Code" style="margin-top:10px"></textarea>
          <input type="text" id="billPhone" placeholder="Phone" style="margin-top:10px">
        </div>
        <div>
          <div class="section-title">For</div>
          <textarea id="productDescription" placeholder="Product Description"></textarea>
        </div>
      </div>

      <!-- Items table -->
      <div class="table" id="items">
        <div class="thead">
          <div>Item Description</div>
          <div>Amount</div>
        </div>
        <div class="trow">
          <input type="text" class="itemDesc" placeholder="Item description">
          <input type="number" class="itemAmount" value="0" min="0" step="0.01" oninput="calc()">
        </div>
      </div>
      <button class="btn mt-10" onclick="addItem()">Add Item</button>

      <!-- Totals -->
      <div class="totals">
        <div></div>
        <div class="total-box">
          <div class="line"><span>Subtotal</span><span class="money" id="subtotal">$0.00</span></div>
          <div class="line">
            <span>Tax Rate (%)</span>
            <input type="number" id="taxRate" class="field-mini" value="0" min="0" step="0.01" oninput="calc()">
          </div>
          <div class="line">
            <span>Other Costs</span>
            <input type="number" id="otherCosts" class="field-mini" value="0" min="0" step="0.01" oninput="calc()">
          </div>
          <div class="total-bar">
            <span>Total Cost</span>
            <span id="totalCost">$0.00</span>
          </div>
          <div class="muted" style="margin-top:6px;font-size:12px">Values update automatically.</div>
        </div>
      </div>
    </div>
  </div>

<script>
  const money = n => `$${Number(n).toFixed(2)}`;

  function addItem(){
    const wrap = document.getElementById('items');
    const row = document.createElement('div');
    row.className = 'trow';
    row.innerHTML = `
      <input type="text" class="itemDesc" placeholder="Item description">
      <input type="number" class="itemAmount" value="0" min="0" step="0.01">
    `;
    row.querySelector('.itemAmount').addEventListener('input', calc);
    wrap.appendChild(row);
    calc();
  }

  function calc(){
    const amounts = Array.from(document.querySelectorAll('.itemAmount'));
    const subtotal = amounts.reduce((s, el) => s + (parseFloat(el.value) || 0), 0);
    document.getElementById('subtotal').textContent = money(subtotal);

    const taxRate = parseFloat(document.getElementById('taxRate').value) || 0;
    const other = parseFloat(document.getElementById('otherCosts').value) || 0;

    const tax = subtotal * (taxRate / 100);
    const total = subtotal + tax + other;

    document.getElementById('totalCost').textContent = money(total);
  }

  // init
  calc();
</script>
</body>
</html>
