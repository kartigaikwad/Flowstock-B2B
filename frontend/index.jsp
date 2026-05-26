<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <title>FlowStock B2B</title>
  <link rel="stylesheet" href="../css/style.css">
</head>

<body class="center-page">

<!-- ===== LOGO HEADER ===== -->
<div class="logo">
  <img src="../images/logo.png" alt="logo">

  <div class="logo-text">
    <div class="flow">FlowStock</div>
    <div class="b2b">B2B Platform</div>
  </div>
</div>

<!-- ===== HERO ===== -->
<div class="hero">

  <h1>
    Inventory Management System <br>
    for <span>Indian Footwear Businesses</span>
  </h1>

  <p class="subtext">
    Manage orders. One platform to run your entire supply chain.
  </p>

  <div class="buttons">
    <button class="primary" onclick="go('shopkeeper-login.jsp')">
      👤 Shopkeeper
    </button>

    <button class="secondary" onclick="go('supplier-login.jsp')">
      🏢 Supplier
    </button>

   <button class="dark" onclick="location.href='addshop.jsp'">
  ➕ Add Shop
</button>

  <!-- FORM -->
  <div id="shopFormBox" style="display:none;">
    <input type="text" id="shopName" placeholder="Shop Name" required>
    <input type="text" id="ownerName" placeholder="Owner Name" required>

    <button id="createBtn" onclick="createShop()">Create Shop</button>

    <p id="shopMsg"></p>
  </div>

  <!-- FEATURES -->
  <div class="features">
    <p>✔ Real-time Inventory</p>
    <p>✔ Low Stock Alerts</p>
    <p>✔ Order Management</p>
    <p>✔ Tracking System</p>
  </div>

</div>

<script>

// NAVIGATION
function go(page){
  window.location.href = page;
}

// OPEN FORM
function openShopForm(){
  document.getElementById("shopFormBox").style.display = "block";
}

// CREATE SHOP (FINAL FIXED)
function createShop(){

  const shopName = document.getElementById("shopName").value.trim();
  const ownerName = document.getElementById("ownerName").value.trim();
  const msg = document.getElementById("shopMsg");
  const btn = document.getElementById("createBtn");

  msg.innerText = "";

  if(!shopName || !ownerName){
    msg.innerText = "⚠ Fill all fields";
    return;
  }

  // loading state
  btn.innerText = "Creating...";
  btn.disabled = true;

  fetch("http://localhost:5000/shops/addShop", {   // 🔥 FIXED URL
    method: "POST",
    headers: {"Content-Type":"application/json"},
    body: JSON.stringify({
      shopName,
      ownerName
    })
  })
  .then(res => {
    if(!res.ok){
      throw new Error();
    }
    return res.json();
  })
  .then(data => {

    msg.innerHTML = "✅ Shop Created! ID: <b>" + data.shopId + "</b>";

    // reset fields
    document.getElementById("shopName").value = "";
    document.getElementById("ownerName").value = "";

  })
  .catch(() => {
    msg.innerText = "❌ Error creating shop";
  })
  .finally(() => {
    btn.innerText = "Create Shop";
    btn.disabled = false;
  });
}

</script>

</body>
</html>