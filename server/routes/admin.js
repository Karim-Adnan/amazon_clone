const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");

adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, images, quantity, price, category } = req.body;

    let product = Product({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });

    product = await product.save();

    res.status(200).json(product);
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const products = await Product.find({});

    return res.status(200).json(products);
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

adminRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;

    let product = await Product.findByIdAndDelete(id);

    return res.status(200).json(product);
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

module.exports = adminRouter;
