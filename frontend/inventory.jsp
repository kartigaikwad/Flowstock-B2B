<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page isELIgnored="true" %>

<!DOCTYPE html>
<html>
<head>
  <title>Inventory</title>
  <link rel="stylesheet" href="../css/inventorystyle.css">
</head>

<body>

<a href="index.jsp" class="back-btn">← Back</a>

<div class="header">
  <div class="logo-title">
    <img src="../images/logo.png" class="logo">
    <h2 id="shopTitle"></h2>
  </div>
</div>

<!-- ONLY CART BUTTON -->
<div class="float-buttons">
  <button class="cart-float" onclick="goToCart()">🛒</button>
</div>

<!-- EMPTY STATE -->
<div id="emptyBox" style="display:none; text-align:center; margin-top:60px;">
  <h3>No products available 🛍️</h3>
  <button onclick="goToAdd()" class="primary-btn">Add Product</button>
</div>

<!-- PRODUCTS -->
<div id="products"></div>

<!-- CART FOOTER -->
<div id="cart-footer" class="cart-footer" style="display:none;">
  <span id="cart-text">0 items added</span>
  <button onclick="goToCart()">Go to Cart</button>
</div>

<script>

// ===== SHOP DATA =====
const shopName = localStorage.getItem("shopName");
const shopId = localStorage.getItem("shopId");

if(!shopId || !shopName){
  alert("Login again ❌");
  window.location.href = "shopkeeper-login.jsp";
}

document.getElementById("shopTitle").innerText = shopName;


// ===== LOAD PRODUCTS =====
function loadProducts(){

  fetch(`http://localhost:5000/products/${shopId}`)
    .then(res => res.json())
    .then(data => {

      if(data.length === 0){
        document.getElementById("emptyBox").style.display = "block";
        document.getElementById("products").innerHTML = "";
        return;
      }

      document.getElementById("emptyBox").style.display = "none";

      let html = "";

      data.forEach((p, index) => {

        let cls = p.stock < 10 ? "card low" : "card ok";

        html += `
        <div class="${cls}">
          <div class="card-content">
            <h3>${p.name}</h3>
            <p><b>Brand:</b> ${p.brand || "N/A"}</p>
            <p><b>Price:</b> ₹${p.price || 0}</p>
            <p><b>Stock:</b> ${p.stock}</p>
            ${p.stock < 10 ? "<p class='alert'>⚠ Low Stock</p>" : ""}
          </div>

          <div class="card-buttons">
            <button onclick='addToCart("${p.name}", ${p.price})'>Add</button>
            <button onclick='orderNow("${p.name}", ${index})'>Order</button>
          </div>

          <div id="msg-${index}"></div>
        </div>
        `;
      });

      document.getElementById("products").innerHTML = html;
    });
}


// ===== NAV =====
function goToAdd(){
  window.location.href = "addproduct.jsp";
}

function goToCart(){
  window.location.href = "cart.jsp";
}


// ===== CART =====
function addToCart(name, price){

  let cart = JSON.parse(localStorage.getItem("cart")) || [];

  let item = cart.find(i => i.name === name);

  if(item){
    item.qty++;
  } else {
    cart.push({name, price, qty:1});
  }

  localStorage.setItem("cart", JSON.stringify(cart));
  updateCart();
}

function updateCart(){

  let cart = JSON.parse(localStorage.getItem("cart")) || [];

  let total = cart.reduce((sum,i)=> sum+i.qty,0);

  let footer = document.getElementById("cart-footer");

  if(total>0){
    footer.style.display="flex";
    document.getElementById("cart-text").innerText = total+" items";
  } else {
    footer.style.display="none";
  }
}


// ===== ORDER =====
function orderNow(name, index){

  fetch("http://localhost:5000/orders", {
    method:"POST",
    headers:{"Content-Type":"application/json"},
    body: JSON.stringify({
      product:name,
      shopId:shopId,
      quantity:1
    })
  })
  .then(()=>{
    document.getElementById("msg-"+index).innerText="✔ Ordered";
  });
}


// INIT
loadProducts();
updateCart();

</script>

</body>
</html>