const express = require('express');
const DeptCode = require('../models/department_code');

const adminRouter = express.Router();
const crypto = require("crypto");

// POST /admin/generate-code
adminRouter.post("/generate-code", authAdmin, async (req, res) => {
  const { department } = req.body;

  // Generate a unique 8-char code
  const code = crypto.randomBytes(4).toString("hex").toUpperCase();

  const deptCode = new DeptCode({ code, department });
  await deptCode.save();

  res.json({ department, code });
});

module.exports = adminRouter;
