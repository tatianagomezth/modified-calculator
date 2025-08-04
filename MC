<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Invoice Form</title>
<style>
  body { font-family: Arial, sans-serif; margin: 20px; }
  .invoice-header { background-color: #003366; color: white; padding: 20px; }
  .invoice-header h1 { margin: 0; }
  .invoice-section { margin-top: 20px; }
  table { width: 100%; border-collapse: collapse; margin-top: 20px; }
  table, th, td { border: 1px solid #ccc; }
  th, td { padding: 10px; text-align: left; }
  .totals { margin-top: 20px; float: right; width: 300px; }
  .totals div { display: flex; justify-content: space-between; padding: 5px 0; }
  input[type=text], input[type=number], input[type=date] {
    width: 100%; padding: 5px; margin-top: 5px; box-sizing: border-box;
  }
  button { padding: 10px 20px; background: #003366; color: white; border: none; cursor: pointer; }
</style>
</head>
<body>

<div class="invoice-header">
  <h1>Company Name</h1>
  <p>Address, City, ST, ZIP Code<br>Phone Number | Fax Number</p>
</div>

<div class="invoice-section">
  <label>Invoice # <input type="text" id="invoiceNumber" value="100"></label><br><br>
  <label>Date: <input type="date" id="invoiceDate"></label>
</div>

<div class="invoice-section">
  <h3>Bill To</h3>
  <input type="text" id="billName" placeholder="Name | Company">
  <input type="text" id="billAddress" placeholder="Address, City, ST, ZIP Code">
  <input type="text" id="billPhone" placeholder="Phone">
</div>

<div class="invoice-section">
  <h3>For</h3>
  <input type="text" id="productDescription" placeholder="Product Description">
</div>

<table id="itemsTable">
  <thead>
    <tr>
      <th>Item Description</th>
      <th>Amount</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><input type="text" class="itemDesc"></td>
      <td><input type="number" class="itemAmount" step="0.01" oninput="calculateTotal()"></td>
    </tr>
  </tbody>
</table>
<button onclick="addRow()">Add Item</button>

<div class="totals">
  <div><span>Subtotal:</span> <span id="subtotal">$0.00</span></div>
  <div><span>Tax Rate (%):</span> <input type="number" id="taxRate" step="0.01" value="0" oninput="calculateTotal()"></div>
  <div><span>Other Costs:</span> <input type="number" id="otherCosts" step="0.01" value="0" oninput="calculateTotal()"></div>
  <div><strong>Total Cost:</strong> <strong id="totalCost">$0.00</strong></div>
</div>

<script>
function addRow() {
  const table = document.getElementById('itemsTable').getElementsByTagName('tbody')[0];
  const row = table.insertRow();
  const cell1 = row.insertCell(0);
  const cell2 = row.insertCell(1);
  cell1.innerHTML = '<input type="text" class="itemDesc">';
  cell2.innerHTML = '<input type="number" class="itemAmount" step="0.01" oninput="calculateTotal()">';
}

function calculateTotal() {
  let subtotal = 0;
  document.querySelectorAll('.itemAmount').forEach(input => {
    subtotal += parseFloat(input.value) || 0;
  });
  document.getElementById('subtotal').textContent = `$${subtotal.toFixed(2)}`;

  const taxRate = parseFloat(document.getElementById('taxRate').value) || 0;
  const otherCosts = parseFloat(document.getElementById('otherCosts').value) || 0;

  const taxAmount = subtotal * (taxRate / 100);
  const total = subtotal + taxAmount + otherCosts;
  document.getElementById('totalCost').textContent = `$${total.toFixed(2)}`;
}
</script>

</body>
</html>
