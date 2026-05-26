const mongoose = require("mongoose");

const orderSchema = new mongoose.Schema({

  // 🔥 Product name (UI ke liye)
  product: {
    type: String,
    required: true
  },

  // 🔥 (Optional) future ke liye productId
  productId: {
    type: String
  },

  // 🔥 Kis shop ne order kiya
  shopId: {
    type: String,
    required: true
  },

  // 🔥 Quantity
  quantity: {
    type: Number,
    default: 1
  },

  // 🔥 Order status
  status: {
    type: String,
    enum: ["Pending", "Approved", "Shipped", "Delivered"],
    default: "Pending"
  },

  // 🔥 Auto date/time
  createdAt: {
    type: Date,
    default: Date.now
  }

});

module.exports = mongoose.model("Order", orderSchema);