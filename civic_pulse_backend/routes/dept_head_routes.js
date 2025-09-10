const express = require('express');
const deptRouter = express.Router();
const DeptCode = require('../models/department_code');
const DeptHead = require('../models/dept_head');
const ComplainReport = require('../models/complaint_report');
const Worker = require('../models/worker');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
require('dotenv').config();

// POST /auth/register-head
deptRouter.post("/api/register-head", async (req, res) => {
  try {
    const { fullname, email, password, codeUsed } = req.body;

  // 1. Check if code exists and unused
    const deptCode = await DeptCode.findOne({ code: codeUsed, used: false });
    if (!deptCode) {
      return res.status(400).json({ error: "Invalid or already used code" });
    }

  // 2. Create head user
    const hashedPassword = await bcrypt.hash(password, 10);
    const newDeptHead = new DeptHead({
      fullname,
      email,
      password: hashedPassword,
      role: "department head",
      department: deptCode.department,
      codeUsed: codeUsed
    });
    await newDeptHead.save();

    // 3. Mark code as used
    deptCode.used = true;
    await deptCode.save();

    res.json(newDeptHead);
  } catch (error) {
    console.log(error);
    res.status(500).json({error:"Internal Server Error"});
  }
});


deptRouter.post('/api/dept-head/login',async(req,res)=>{
    try{
        const {email,password} = req.body;
        const depthead = await DeptHead.findOne({email});
        if(!depthead){
            return res.status(400).json({error:"Invalid credentials"});
        }
        const isMatch = await bcrypt.compare(password,depthead.password);
        if(!isMatch){
            return res.status(400).json({error:"Invalid credentials"});
        }
        const token = jwt.sign({id:depthead._id},process.env.JWT_SECRET_KEY);
        res.status(200).json({token,depthead:depthead});
    }catch(e){
        console.log(e);
        res.status(500).json({error:"Internal Server Error"});
    }
});



deptRouter.get('/api/get-assigned-reports/:deptHeadId',async(req,res)=>{
  try {
    const {deptHeadId} = req.params;
    const deptHead = await DeptHead.findById(deptHeadId);
    if(!deptHead) return res.status(400).json({msg:"Department Head Not Found"});
    const reports = await ComplainReport.find({"assignedHead.headId":deptHeadId});
    res.status(200).json(reports);
  } catch (error) {
    console.log(error);
    res.status(500).json({error:"Internal Server Error"});
  }
});

// worker according to the department

deptRouter.get('/api/workers-of-department/:department',async(req,res)=>{
  try {
    const {department} = req.params;
    const workers = await Worker.find({
      department:department
    });
    res.status(200).json(workers);
  } catch (error) {
    console.log(error);
    res.status(500).json({error:"Internal Server Error"});
  }
});

// assign tasks to the workers 
deptRouter.post('/api/assign-reports/worker',async(req,res)=>{
  try {
    const {reportId,workers} = req.body;
    const report = await ComplainReport.findById(reportId);
    if(!report) return res.status(400).json({msg:"Report not found"});
    
    // validate workers
    const workerDoc = await Worker.find({
      _id:{$in:workers.map(w => w.workerId)}
    })

    if(workerDoc.length !== workers.length){
      return res.status(400).json({msg:"Few workers are not available"});
    }

    report.assignedTo = workers;
    await report.save();
    res.status(200).json({ message: "Workers assigned successfully", report });

  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});



module.exports = deptRouter;