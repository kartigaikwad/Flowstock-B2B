const express = require("express");
const router = express.Router();
const Order = require("../models/Order");


// ✅ GET all orders (ADMIN PANEL)
router.get("/", async (req, res) => {
  try {
    const data = await Order.find();
    res.json(data);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// ✅ GET orders by shop (SHOP PANEL)
router.get("/shop/:shopId", async (req, res) => {
  try {
    const data = await Order.find({
      shopId: req.params.shopId
    });

    res.json(data);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// ✅ ADD order (FINAL FIXED)
router.post("/", async (req, res) => {
  try {
    const { product, shopId, quantity } = req.body;  // 🔥 FIXED

    if (!shopId || !product) {
      return res.status(400).json({ message: "shopId & product required" });
    }

    const newOrder = new Order({
      product,   // 🔥 correct
      shopId,
      quantity: quantity || 1,
      status: "Pending"
    });

    await newOrder.save();

    res.json({ message: "Order sent to supplier", order: newOrder });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// ✅ UPDATE status (ADMIN use)
router.put("/:id", async (req, res) => {
  try {
    const updated = await Order.findByIdAndUpdate(
      req.params.id,
      { status: req.body.status },
      { new: true }
    );

    res.json({ message: "Updated", order: updated });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


module.exports = router;