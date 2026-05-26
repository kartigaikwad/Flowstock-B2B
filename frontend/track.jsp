<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page isELIgnored="true" %>

<!DOCTYPE html>
<html>
<head>
  <title>Order Tracker</title>
  <link rel="stylesheet" href="../css/trackstyle.css">
</head>

<body>

<a href="inventory.jsp" class="back-btn">← Back</a>

<h2>Your Orders</h2>

<div id="orders"></div>

<script>

// ================= SHOP CHECK =================
const shopId = localStorage.getItem("shopId");

if(!shopId){
  alert("Login again ❌");
  window.location.href = "shopkeeper-login.jsp";
}


// ================= LOAD ORDERS =================
function loadOrders(){

  fetch(`http://localhost:5000/orders/shop/${shopId}`)
    .then(res => {
      if(!res.ok){
        throw new Error("Failed to load");
      }
      return res.json();
    })
    .then(data => {

      const container = document.getElementById("orders");

      if(!data || data.length === 0){
        container.innerHTML = "<p class='empty'>No orders found 📦</p>";
        return;
      }

      let html = "";

      // Latest first
      data.reverse().forEach(order => {

        // ✅ SAFE PRODUCT NAME
        let product = (typeof order.product === "string" && order.product.trim() !== "")
          ? order.product
          : "Unknown Product";

        let qty = order.quantity || 1;
        let status = order.status || "Pending";

        // ✅ STATUS CLASS
        let cls = "pending";
        if(status === "Approved") cls = "approved";
        else if(status === "Shipped") cls = "shipped";
        else if(status === "Delivered") cls = "delivered";

        html += `
          <div class="card">

            <div class="left">
              <h3>${product}</h3>
              <p>Qty: ${qty}</p>

              <div class="progress">
                <div class="bar ${cls}"></div>
              </div>
            </div>

            <div class="right">
              <span class="status ${cls}">${status}</span>
            </div>

          </div>
        `;
      });

      container.innerHTML = html;
    })
    .catch(() => {
      document.getElementById("orders").innerHTML =
        "<p class='empty'>Error loading orders ❌</p>";
    });
}


// ================= INIT =================
loadOrders();

</script>

</body>
</html>