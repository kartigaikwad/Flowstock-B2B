<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="true"%>

<!DOCTYPE html>
<html>
<head>
  <title>Supplier Dashboard</title>

  <link rel="stylesheet" href="../css/supplierstyle.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>

<!-- ===== HEADER ===== -->
<div class="header">

  <div class="logo-title">
    <img src="../images/logo.png" class="logo">
    <h2>Supplier Dashboard</h2>
  </div>

  <button onclick="logout()" class="logout-btn">Logout</button>
</div>

<!-- ===== DASHBOARD ===== -->
<div id="dashboardPage">

  <!-- CARDS -->
  <div class="top-cards">

    <div class="card" onclick="filterOrders('Pending')">
      <h2 id="pendingCount">0</h2>
      <p>Pending</p>
    </div>

    <div class="card" onclick="filterOrders('Approved')">
      <h2 id="approvedCount">0</h2>
      <p>Approved</p>
    </div>

    <div class="card" onclick="filterOrders('Shipped')">
      <h2 id="shippedCount">0</h2>
      <p>Shipped</p>
    </div>

    <div class="card" onclick="filterOrders('Delivered')">
      <h2 id="deliveredCount">0</h2>
      <p>Delivered</p>
    </div>

    <div class="card" onclick="showAll()">
      <h2 id="totalCount">0</h2>
      <p>Total Orders</p>
    </div>

  </div>

  <!-- MAIN -->
  <div class="dashboard-container">

    <div class="chart-box">
      <h3>Top 3 Products</h3>
      <div class="chart-wrapper">
        <canvas id="topChart"></canvas>
      </div>
    </div>

    <div class="orders-box">
      <h3>Orders</h3>
      <div id="ordersList"></div>
    </div>

  </div>

  <!-- ===== RECENT ACTIVITY ===== -->
  <div class="bottom-section">
    <div class="activity-box">
      <h3>Recent Activity</h3>
      <div id="activityList"></div>
    </div>
  </div>

</div>

<script>

let allOrders = [];
let activities = [];

// LOAD
function loadOrders(){
  fetch("http://localhost:5000/orders")
    .then(res => res.json())
    .then(data => {

      allOrders = data.reverse();
      updateCards(data);
      renderOrders(allOrders.filter(o => o.status !== "Delivered"));
      loadChart(data);

    });
}

// CARDS
function updateCards(data){
  pendingCount.innerText = data.filter(o => o.status === "Pending").length;
  approvedCount.innerText = data.filter(o => o.status === "Approved").length;
  shippedCount.innerText = data.filter(o => o.status === "Shipped").length;
  deliveredCount.innerText = data.filter(o => o.status === "Delivered").length;
  totalCount.innerText = data.length;
}

// FILTER
function filterOrders(status){
  renderOrders(allOrders.filter(o => o.status === status));
}

function showAll(){
  renderOrders([...allOrders]);
}

// RENDER
function renderOrders(data){

  let html = "";

  if(data.length === 0){
    ordersList.innerHTML = "<p style='text-align:center'>No Orders Found</p>";
    return;
  }

  data.forEach(o => {
    html += `
      <div class="order-card">
        <div class="order-info">
          <h4>${o.product}</h4>

          <p class="meta">
            Qty: ${o.quantity} <br>
            Shop ID: ${o.shopId}
          </p>

          <span class="status ${o.status.toLowerCase()}">
            ${o.status}
          </span>
        </div>

        <div class="btn-group">
          ${o.status === "Pending" ? `<button class="approve" data-id="${o._id}">Approve</button>` : ""}
          ${o.status === "Approved" ? `<button class="ship" data-id="${o._id}">Ship</button>` : ""}
          ${o.status === "Shipped" ? `<button class="deliver" data-id="${o._id}">Deliver</button>` : ""}
        </div>
      </div>
    `;
  });

  ordersList.innerHTML = html;
}

// UPDATE
function updateStatus(id, status){
  fetch(`http://localhost:5000/orders/${id}`, {
    method: "PUT",
    headers: {"Content-Type":"application/json"},
    body: JSON.stringify({status})
  }).then(() => loadOrders());
}

// EVENTS
ordersList.addEventListener("click", e => {

  let btn = e.target.closest("button");
  if(!btn) return;

  let id = btn.dataset.id;
  let card = btn.closest(".order-card");
  let product = card.querySelector("h4").innerText;

  if(btn.classList.contains("approve")){
    updateStatus(id,"Approved");
    addActivity(product + " Approved");
  }

  if(btn.classList.contains("ship")){
    updateStatus(id,"Shipped");
    addActivity(product + " Shipped");
  }

  if(btn.classList.contains("deliver")){
    updateStatus(id,"Delivered");
    addActivity(product + " Delivered");
  }

});

// ACTIVITY
function addActivity(text){
  activities.unshift({
    msg: text,
    time: new Date().toLocaleTimeString()
  });

  if(activities.length > 6) activities.pop();

  renderActivity();
}

function renderActivity(){
  let html = "";

  activities.forEach(a => {
    html += `
      <div class="activity-item">
        <p>${a.msg}</p>
        <span>${a.time}</span>
      </div>
    `;
  });

  activityList.innerHTML = html;
}

// CHART
function loadChart(data){

  let map = {};

  data.forEach(o => {
    map[o.product] = (map[o.product] || 0) + 1;
  });

  let sorted = Object.entries(map).sort((a,b)=>b[1]-a[1]).slice(0,3);

  let labels = sorted.map(x=>x[0]);
  let values = sorted.map(x=>x[1]);

  if(window.chart) chart.destroy();

  chart = new Chart(topChart, {
    type: "pie",
    data: {
      labels: labels,
      datasets: [{
        data: values,
        backgroundColor: [
          "#7c3aed",
          "#a78bfa",
          "#c4b5fd"
        ],
        borderWidth: 0
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: "top"
        }
      }
    }
  });

} // ✅ 🔥 YE MISSING THA

// LOGOUT
function logout(){
  window.location.href = "index.jsp";
}

// INIT
loadOrders();

</script>

</body>
</html>