const express = require("express");
const router = express.Router();
const Shop = require("../models/Shop");


// ✅ ADD SHOP
router.post("/addShop", async (req, res) => {
  try {
    const { shopName, ownerName } = req.body;

    if(!shopName || !ownerName){
      return res.status(400).json({ message: "All fields required" });
    }

    let shopId;
    let exists = true;

    // 🔥 UNIQUE ID GENERATION (NO DUPLICATE)
    while(exists){
      shopId = "SHOP" + Math.floor(1000 + Math.random() * 9000);
      const check = await Shop.findOne({ shopId });
      if(!check) exists = false;
    }

    const newShop = new Shop({
      shopName,
      ownerName,
      shopId
    });

    await newShop.save();

    res.json({
      message: "Shop Created",
      shopId: shopId
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// ✅ GET SHOP BY ID (LOGIN KE LIYE)
router.get("/shop/:shopId", async (req, res) => {
  try {
    const shop = await Shop.findOne({
      shopId: req.params.shopId
    });

    if(!shop){
      return res.status(404).json({ message: "Shop not found" });
    }

    res.json({
      shopName: shop.shopName,
      shopId: shop.shopId
    });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


module.exports = router;