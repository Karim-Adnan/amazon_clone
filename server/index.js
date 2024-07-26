// Imports
const express = require("express");
const mongoose = require("mongoose");

const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

// Initialize Express
const PORT = 3000;
const app = express();
const db =
  "mongodb+srv://kaifadnan05:kaifadnan05@cluster0.ll7xomh.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0&tls=true";

// Middleware
app.use(express.json());

app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// Connect to MongoDB
mongoose
  .connect(db)
  .then(() => {
    console.log("Connected to MongoDB successfully! 🚀");
  })
  .catch((err) => {
    console.log(err);
  });

// Routes
app.listen(PORT, "0.0.0.0", () =>
  console.log(`Server is running on http://localhost:${PORT}`)
);
