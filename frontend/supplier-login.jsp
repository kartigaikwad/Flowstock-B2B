<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <title>Supplier Login</title>
  <link rel="stylesheet" href="../css/supplierloginstyle.css">
</head>

<body class="center-page">

<div class="login-container">

  <!-- LOGO -->
  <div class="logo">
    <img src="../images/logo.png">
    <div>
      <div class="flow">FlowStock</div>
      <div class="b2b">Supplier Access</div>
    </div>
  </div>

  <!-- CARD -->
  <div class="card-box">
    
    <h2>🏢 Supplier Login</h2>
    <p class="tagline">Authorized Access Only</p>

    <form id="supplierForm">

      <input type="text" id="user" placeholder="Username" required>

      <input type="password" id="pass" placeholder="Enter Access Code" required>

      <button type="submit">Login</button>

    </form>

    <a href="index.jsp" class="back-btn">← Back</a>

  </div>

</div>

<script>
document.getElementById("supplierForm").addEventListener("submit", function(e){
  e.preventDefault();

  let user = document.getElementById("user").value;
  let pass = document.getElementById("pass").value;

  if(user === "admin" && pass === "nike@b2b"){  
    window.location.href = "supplier.jsp";
  } else {
    alert("Invalid Username or Code ❌");
  }
});
</script>

</body>
</html>