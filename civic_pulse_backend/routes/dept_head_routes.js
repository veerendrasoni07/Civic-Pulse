const express = require('express');
const deptRouter = express.Router();
const DeptCode = require('../models/department_code');
const DeptHead = require('../models/dept_head');


// POST /auth/register-head
deptRouter.post("/api/register-head", async (req, res) => {
  try {
    const { name, email, password, codeUsed } = req.body;

  // 1. Check if code exists and unused
  const deptCode = await DeptCode.findOne({ code: codeUsed, used: false });
  if (!deptCode) {
    return res.status(400).json({ error: "Invalid or already used code" });
  }

  // 2. Create head user
  const hashedPassword = await bcrypt.hash(password, 10);
  const newDeptHead = new DeptHead({
    name,
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


workerAuthRoute.post('/api/dept-head/login',async(req,res)=>{
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
        const token = jwt.sign({id:depthead._id},process.env.JWT_SECRET);
        res.status(200).json({token,depthead:depthead});
    }catch(e){
        console.log(e);
        res.status(500).json({error:"Internal Server Error"});
    }
});





module.exports = deptRouter;