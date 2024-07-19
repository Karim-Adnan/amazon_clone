const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const authRouter = express.Router();
const auth = require("../middlewares/auth");

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return res.status(400).json({ message: "User already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({ name, email, password: hashedPassword });

    user = await user.save();
    return res.status(200).json(user);
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({ message: "User does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ message: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    return res.json({ token, ...user._doc });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

authRouter.post("/api/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");

    if (!token) {
      return res.status(200).json(false);
    }
    const verified = jwt.verify(token, "passwordKey");

    if (!verified) {
      return res.status(200).json(false);
    }

    const user = await User.findById(verified.id);

    if (!user) {
      return res.status(200).json(false);
    }

    return res.status(200).json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);

  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
