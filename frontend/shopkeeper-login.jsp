<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <title>Shopkeeper Login</title>
  <link rel="stylesheet" href="../css/shopkeeperloginstyle.css">
</head>

<body class="center-page">

<div class="login-container">

  <!-- LOGO -->
  <div class="logo">
    <img src="../images/logo.png">
    <div>
      <div class="flow">FlowStock</div>
      <div class="b2b">Shopkeeper Access</div>
    </div>
  </div>

  <!-- CARD -->
  <div class="card-box">

    <h2>👤 Shopkeeper Login</h2>
    <p class="tagline">Order Shoes for your shop</p>

    <form id="shopForm">
      
      <input type="text" id="shopId" placeholder="Enter Shop ID (e.g. SHOP101)" required>

      <button type="submit" id="loginBtn">Enter</button>

    </form>

    <!-- 🔥 ERROR MESSAGE -->
    <p id="errorMsg" class="error-msg"></p>

    <!-- 🔥 SHOP NAME DISPLAY -->
    <p id="shopDisplay"></p>

    <a href="index.jsp" class="back-btn">← Back</a>

  </div>

</div>

<script>

const form = document.getElementById("shopForm");
const btn = document.getElementById("loginBtn");
const errorMsg = document.getElementById("errorMsg");
const shopDisplay = document.getElementById("shopDisplay");

form.addEventListener("submit", function(e){
  e.preventDefault();
  e.stopPropagation();   // 🔥 IMPORTANT

  const shopId = document.getElementById("shopId").value.trim();

  errorMsg.innerText = "";
  shopDisplay.innerText = "";

  if(!shopId){
    errorMsg.innerText = "Please enter Shop ID ❌";
    return;
  }

  btn.classList.add("loading");
  btn.innerText = "Checking...";
  btn.disabled = true;

  fetch("http://localhost:5000/shops/shop/" + shopId)
    .then(res => res.json())
    .then(data => {

      localStorage.setItem("shopId", shopId);
      localStorage.setItem("shopName", data.shopName);

      shopDisplay.innerText = "✔ Shop: " + data.shopName;

      setTimeout(() => {
        window.location.href = "inventory.jsp";
      }, 800);
    })
    .catch(() => {
      errorMsg.innerText = "Invalid Shop ID ❌";
      btn.innerText = "Enter";
      btn.disabled = false;
    });
});
</script>

</body>
</html>