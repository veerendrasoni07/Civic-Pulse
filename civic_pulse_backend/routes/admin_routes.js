const express = require('express');
const DeptCode = require('../models/department_code');
const DeptHead = require('../models/dept_head');
const ComplainReport = require('../models/complaint_report');
const adminRouter = express.Router();
const crypto = require("crypto");

// generate department code for dept head signup
adminRouter.post("/api/generate-code", async (req, res) => {
  const { department } = req.body;

  // Generate a unique 8-char code
  const code = crypto.randomBytes(4).toString("hex").toUpperCase();

  const deptCode = new DeptCode({ code, department });
  await deptCode.save();

  res.json({ department, code });
});

// assign reports to the dept head
adminRouter.post("/api/assign-reports/dept-head", async (req, res) => {
  try {
    const { deptHeadId,deptHeadName ,reportId } = req.body;

    const report = await ComplainReport.findById(reportId);
    if(!report){
      return res.status(400).json({msg:"Report not found"});
    }

    // assign dept head to report
    report.assignedHead = {
      headId : deptHeadId,
      headName : deptHeadName
    }

    // push history to the report
    report.history.push({
      status:"processing",
      updatedBy:deptHeadName,
      note: `Assigned To Department Head : ${deptHeadName}`
    });

    await report.save();

    res.json({ message: "Reports assigned successfully to dept head", report });

  } catch (error) {
    console.error("Error assigning reports:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});


adminRouter.get('/api/get-depthead/:department',async(req,res)=>{
  try {
    const {department} = req.params;
    const deptHead = await DeptHead.find({department:department});
    res.status(200).json(deptHead);
  } catch (error) {
    console.log(error);
    res.status(500).json({error:"Internal Server Error"})
  }
})


module.exports = adminRouter;
