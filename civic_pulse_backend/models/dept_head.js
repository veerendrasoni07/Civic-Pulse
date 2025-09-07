const mongoose = require('mongoose');
const { assign } = require('nodemailer/lib/shared');

const deptHeadSchema = new mongoose.Schema({
  fullname: String,
  email: { type: String, unique: true },
  password: String,
  department: String,
  role:{
    type:String,
    default:'department head'
  },
  phone: String,
  address: String,
  picture: String,
  assignedReports: [{ type: mongoose.Schema.Types.ObjectId, ref: 'ComplainReport' }],
  codeUsed: String, // Department code they registered with
  createdAt: { type: Date, default: Date.now }
});

const DeptHead = mongoose.model('DeptHead',deptHeadSchema);

module.exports = DeptHead;