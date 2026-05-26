const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();

// ✅ Middleware
app.use(express.json());
app.use(cors());

// ✅ MongoDB Connection
mongoose.connect("mongodb://127.0.0.1:27017/b2b")
.then(() => console.log("MongoDB Connected ✅"))
.catch(err => console.log("DB Error:", err));

// ✅ Routes
app.use("/products", require("./routes/productRoutes"));
app.use("/orders", require("./routes/orderRoutes"));
app.use("/shops", require("./routes/shopRoutes"));  // 🔥 better path

// ✅ Default route
app.get("/", (req, res) => {
  res.send("B2B Server Running 🚀");
});

// ✅ Error handling
app.use((err, req, res, next) => {
  res.status(500).json({ error: err.message });
});

// ✅ Server start
app.listen(5000, () => {
  console.log("Server running on port 5000");
});