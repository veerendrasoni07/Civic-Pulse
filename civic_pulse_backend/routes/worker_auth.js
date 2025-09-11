const express = require('express');
const Worker = require('../models/worker');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/user');
const ComplainReport = require('../models/complaint_report');
const workerAuthRoute = express.Router();
require('dotenv').config();


workerAuthRoute.post('/api/worker/register',async(req,res)=>{
    try{
        const {fullname,email,password,phone,department} = req.body;
        // check if user already exists
        const existingWorker = await Worker.findOne({email});
        if(existingWorker){
            return res.status(400).json({error:"Worker already exists"});
        }
        // hash password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password,salt);
        let newWorker = new Worker({fullname,email,password:hashedPassword,phone,department});
        newWorker = await newWorker.save();
        res.status(200).json(newWorker);
    }catch(e){
        console.log(e);
        res.status(500).json({error:"Internal Server Error"});
    }
});


workerAuthRoute.post('/api/worker/login',async(req,res)=>{
    try{
        const {email,password} = req.body;
        const worker = await Worker.findOne({email});
        if(!worker){
            return res.status(400).json({error:"Invalid credentials"});
        }
        const isMatch = await bcrypt.compare(password,worker.password);
        if(!isMatch){
            return res.status(400).json({error:"Invalid credentials"});
        }
        const token = jwt.sign({id:worker._id},process.env.JWT_SECRET_KEY);
        res.status(200).json({token,worker:worker});
    }catch(e){
        console.log(e);
        res.status(500).json({error:"Internal Server Error"});
    }
});


// fetch all the assigned reports 
workerAuthRoute.get('/api/fetch-all-assigned-reports/:workerId',async(req,res)=>{
    try {
        const {workerId} = req.params;
        const worker = await User.findById(workerId);
        if(!worker){
            return res.status(400).json({msg:"Worker is not found"});
        }

        const allAssignedReports = await ComplainReport.find({"assignedTo.workerId":workerId});
        res.status(200).json(allAssignedReports);
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
})



module.exports = workerAuthRoute;
