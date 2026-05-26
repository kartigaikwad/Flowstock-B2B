const mongoose = require("mongoose");

const productSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },

  stock: {
    type: Number,
    required: true,
    default: 0
  },

  price: {
    type: Number,
    required: true,
    default: 0
  },

  brand: {
    type: String,
    default: "Generic"
  },

  shopId: {
    type: String,
    required: true   // 🔥 MUST for multi-shop
  }
});

module.exports = mongoose.model("Product", productSchema);