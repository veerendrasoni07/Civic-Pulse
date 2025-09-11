const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/user");
require("dotenv").config();

const authRouter = express.Router();

// ================= Citizen Signup =================
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { fullname, email, password, phone } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ msg: "User with this email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      fullname,
      email,
      password: hashedPassword,
      phone,
      role: "citizen", // default for self-register
    });

    user = await user.save();
    res.status(201).json({ msg: "Citizen registered successfully", user });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// ================= Login (for all roles) =================
authRouter.post("/api/login", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) return res.status(400).json({ msg: "User not found" });

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ msg: "Invalid credentials" });

    const token = jwt.sign(
      { id: user._id, role: user.role },
      process.env.JWT_SECRET_KEY,
    );

    res.json({ token, user });
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// ================= Admin Creates Worker =================
authRouter.post("/api/register-worker", async (req, res) => {
  try {
    const { fullname, email, password, phone, department } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ msg: "User with this email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let worker = new User({
      fullname,
      email,
      password: hashedPassword,
      phone,
      department,
      role: "worker",
    });

    worker = await worker.save();
    res.status(201).json({ msg: "Worker account created successfully", worker });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// ================= Admin Creates Dept Head =================
authRouter.post("/api/register-depthead", async (req, res) => {
  try {
    const { fullname, email, password, phone, department } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ msg: "User with this email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let deptHead = new User({
      fullname,
      email,
      password: hashedPassword,
      phone,
      department,
      role: "depthead",
    });

    deptHead = await deptHead.save();
    res.status(201).json({ msg: "DeptHead account created successfully", deptHead });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
