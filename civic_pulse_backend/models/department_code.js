const mongoose = require('mongoose');
const deptCodeSchema = new mongoose.Schema({
  code: String,            // unique invite code
  department: String,
  used: { type: Boolean, default: false }
});

const DeptCode = mongoose.model("DeptCode", deptCodeSchema);
module.exports = DeptCode;