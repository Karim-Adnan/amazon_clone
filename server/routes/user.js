const express = require("express");
const adminRouter = express.Router();

adminRouter.get("", auth, async (req, res) => {
  try {
    return res.status(200).json({});
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});
