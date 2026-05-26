const mongoose = require("mongoose");

const shopSchema = new mongoose.Schema({
  shopName: {
    type: String,
    required: true,
    trim: true
  },
  ownerName: {
    type: String,
    required: true,
    trim: true
  },
  shopId: {
    type: String,
    required: true,
    unique: true
  }
}, {
  timestamps: true   // 🔥 createdAt / updatedAt auto milega
});

module.exports = mongoose.model("Shop", shopSchema);