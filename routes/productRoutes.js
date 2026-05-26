const express = require("express");
const router = express.Router();
const Product = require("../models/Product");


// ✅ GET products (shop wise)
router.get("/:shopId", async (req, res) => {
  try {
    const { shopId } = req.params;

    if(!shopId){
      return res.status(400).json({ message: "shopId required" });
    }

    const data = await Product.find({ shopId });

    res.json(data);

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// ✅ GET all products (admin use)
router.get("/", async (req, res) => {
  try {
    const data = await Product.find();
    res.json(data);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// ✅ ADD product
router.post("/", async (req, res) => {
  try {
    const { name, price, stock, shopId, brand } = req.body;

    // 🔥 VALIDATION
    if(!name || !shopId){
      return res.status(400).json({ message: "name & shopId required" });
    }

    const newProduct = new Product({
      name,
      price: price || 0,
      stock: stock || 0,
      brand: brand || "Generic",
      shopId
    });

    await newProduct.save();

    res.json({
      message: "Product added",
      product: newProduct
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// ✅ UPDATE product
router.put("/:id", async (req, res) => {
  try {
    const updated = await Product.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );

    if(!updated){
      return res.status(404).json({ message: "Product not found" });
    }

    res.json(updated);

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// ✅ DELETE product
router.delete("/:id", async (req, res) => {
  try {
    const deleted = await Product.findByIdAndDelete(req.params.id);

    if(!deleted){
      return res.status(404).json({ message: "Product not found" });
    }

    res.json({ message: "Product deleted" });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


module.exports = router;