<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page isELIgnored="true" %>

<!DOCTYPE html>
<html>
<head>
  <title>Your Cart</title>
  <link rel="stylesheet" href="../css/cartstyle.css">
</head>

<body>

<a href="inventory.jsp" class="back-btn">← Back</a>

<h2>Your Cart</h2>

<div id="cart-items"></div>

<h3 id="total"></h3>

<button onclick="placeOrder()" class="primary" id="orderBtn">Place Order</button>

<div id="order-msg" class="success-msg"></div>

<script>

// ✅ LOAD UI
function loadCart(){

  let cart = JSON.parse(localStorage.getItem("cart")) || [];
  let container = document.getElementById("cart-items");

  if(cart.length === 0){
    container.innerHTML = "<p style='text-align:center'>Cart is empty 🛒</p>";
    document.getElementById("total").innerText = "";
    return;
  }

  let html = "";
  let total = 0;

  cart.forEach((item, index) => {

    let name = (typeof item.name === "string" && item.name.trim() !== "")
      ? item.name
      : "Shoes";

    let price = Number(item.price) || 0;
    let qty = Number(item.qty) || 1;

    total += price * qty;

    html +=
      '<div class="card row">' +

        '<div class="left">' +
          '<h3>' + name + '</h3>' +
          '<p>Price: ₹' + price + '</p>' +
          '<p>Qty: ' + qty + '</p>' +
        '</div>' +

        '<div class="middle">' +
          '<button class="dec" data-i="' + index + '">-</button>' +
          '<span>' + qty + '</span>' +
          '<button class="inc" data-i="' + index + '">+</button>' +
        '</div>' +

        '<div class="right">' +
          '<button class="remove" data-i="' + index + '">❌</button>' +
        '</div>' +

      '</div>';
  });

  container.innerHTML = html;
  document.getElementById("total").innerText = "Total: ₹" + total;
}


// ✅ BUTTON EVENTS
document.addEventListener("click", function(e){

  let btn = e.target.closest("button");
  if(!btn) return;

  let i = Number(btn.getAttribute("data-i"));
  if(isNaN(i)) return;

  let cart = JSON.parse(localStorage.getItem("cart")) || [];

  if(btn.classList.contains("inc")){
    cart[i].qty = Number(cart[i].qty || 1) + 1;
  }

  if(btn.classList.contains("dec")){
    let qty = Number(cart[i].qty || 1);
    if(qty > 1) cart[i].qty = qty - 1;
  }

  if(btn.classList.contains("remove")){
    cart.splice(i, 1);
  }

  localStorage.setItem("cart", JSON.stringify(cart));
  loadCart();
});


// ✅ PLACE ORDER (FIXED)
async function placeOrder(){

  let cart = JSON.parse(localStorage.getItem("cart")) || [];
  let shopId = localStorage.getItem("shopId");

  if(cart.length === 0){
    alert("Cart is empty ❌");
    return;
  }

  if(!shopId){
    alert("Please login again ❌");
    return;
  }

  let btn = document.getElementById("orderBtn");
  if(btn) btn.disabled = true;

  try {

    await Promise.all(
      cart.map(item => {
        return fetch("http://localhost:5000/orders", {
          method: "POST",
          headers: {"Content-Type":"application/json"},
          body: JSON.stringify({
            product: item.name,
            productId: item.name,   // simple mapping
            shopId: shopId,
            quantity: item.qty
          })
        }).then(res => {
          if(!res.ok){
            throw new Error("Failed");
          }
        });
      })
    );

    localStorage.removeItem("cart");
    loadCart();

    let msg = document.getElementById("order-msg");

    msg.innerHTML =
      '<div class="tick">✔</div>' +
      '<div class="success-text">Order Placed</div>' +
      '<p>You can track your order</p>' +
      '<div>' +
        '<button onclick="goToTracker()">Track Order</button>' +
        '<button onclick="goToInventory()">Continue Shopping</button>' +
      '</div>';

    msg.classList.add("show");

  } catch (err) {
    alert("Order failed ❌");
    if(btn) btn.disabled = false;
  }
}


// ✅ NAVIGATION
function goToTracker(){
  window.location.href = "track.jsp";
}

function goToInventory(){
  window.location.href = "inventory.jsp";
}


// ✅ INIT
loadCart();

</script>

</body>
</html>