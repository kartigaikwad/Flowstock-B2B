<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <title>Add Product</title>
  <link rel="stylesheet" href="../css/addproductstyle.css">
</head>

<body class="center-page">

<div class="card-box">

  <h2>Add Product</h2>

  <input type="text" id="name" placeholder="Product Name">
  <input type="text" id="brand" placeholder="Brand">
  <input type="number" id="price" placeholder="Price">
  <input type="number" id="stock" placeholder="Stock">

  <button onclick="addProduct()">Add Product</button>

  <p id="msg"></p>

  <button onclick="goBack()">← Back to Inventory</button>

</div>

<script>

function addProduct(){

  const shopId = localStorage.getItem("shopId");

  const nameInput = document.getElementById("name");
  const brandInput = document.getElementById("brand");
  const priceInput = document.getElementById("price");
  const stockInput = document.getElementById("stock");

  const name = nameInput.value.trim();
  const brand = brandInput.value.trim();
  const price = priceInput.value;
  const stock = stockInput.value;

  const msg = document.getElementById("msg");

  // EMPTY CHECK
  if(!name || !brand || !price || !stock){
    msg.innerText = "Fill all fields ❌";
    return;
  }

  // FOOTWEAR CHECK
  const allowed = ["shoe","sandal","slipper","boot","loafer","flip","crocs","bellys"];

  const isValid = allowed.some(word => name.toLowerCase().includes(word));

  if(!isValid){
    msg.innerText = "Only footwear allowed ❌";
    return;
  }

  // API CALL
  fetch("http://localhost:5000/products", {
    method:"POST",
    headers:{"Content-Type":"application/json"},
    body: JSON.stringify({
      name,
      brand,
      price,
      stock,
      shopId
    })
  })
  .then(res => res.json())
  .then(() => {
    msg.innerText = "Added ✅";

    // CLEAR
    nameInput.value = "";
    brandInput.value = "";
    priceInput.value = "";
    stockInput.value = "";
  })
  .catch(() => {
    msg.innerText = "Error ❌";
  });
}

function goBack(){
  window.location.href = "inventory.jsp";
}

</script>

</body>
</html>