const express = require('express');
const Worker = require('../models/worker');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const workerAuthRoute = express.Router();
require('dotenv').config();


workerAuthRoute.post('/api/worker/register',async(req,res)=>{
    try{
        const {name,email,password,phone,department} = req.body;
        // check if user already exists
        const existingWorker = await Worker.findOne({email});
        if(existingWorker){
            return res.status(400).json({error:"Worker already exists"});
        }
        // hash password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password,salt);
        const newWorker = new Worker({name,email,password:hashedPassword,phone:phone,department:department});
        await newWorker.save();
        res.status(201).json({message:"Worker registered successfully"});
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
        const token = jwt.sign({id:worker._id},process.env.JWT_SECRET);
        res.status(200).json({token,worker:worker});
    }catch(e){
        console.log(e);
        res.status(500).json({error:"Internal Server Error"});
    }
});
module.exports = workerAuthRoute;
