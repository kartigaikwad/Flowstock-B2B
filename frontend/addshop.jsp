<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <title>Add Shop</title>
  <link rel="stylesheet" href="../css/addshopstyle.css">
</head>

<body>

<div class="container">

  <!-- 🔷 LOGO -->
  <div class="logo">
    <img src="../images/logo.png">
    <div>
      <div class="flow">FlowStock</div>
      <div class="b2b">Add New Shop</div>
    </div>
  </div>

  <!-- 🧾 CARD -->
  <div class="card-box">
    
    <h2>➕ Create Shop</h2>
    <p class="tagline">Register your shop to start ordering</p>

    <!-- ✅ FORM UPDATED -->
    <form onsubmit="createShop(event)">

      <input type="text" id="shopName" placeholder="Shop Name" required>

      <input type="text" id="ownerName" placeholder="Owner Name" required>

      <button type="submit">Create Shop</button>

    </form>

    <!-- ✅ RESULT MESSAGE -->
    <p id="result" style="margin-top:10px; color:green;"></p>

    <a href="index.jsp" class="back-btn">← Back</a>

  </div>

</div>

<!-- ✅ SCRIPT -->
<script>
function createShop(e){
  e.preventDefault();

  let shopName = document.getElementById("shopName").value;
  let ownerName = document.getElementById("ownerName").value;

  fetch("http://localhost:5000/shops/addShop", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({ shopName, ownerName })
  })
  .then(res => res.json())
  .then(data => {
    document.getElementById("result").innerText =
      "✅ Shop Created! ID: " + data.shopId;
  })
  .catch(err => {
    document.getElementById("result").innerText =
      "❌ Error creating shop";
  });
}
</script>

</body>
</html>