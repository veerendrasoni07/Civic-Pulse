const express = require('express');
const ComplainReport = require('../models/complaint_report');
const reportRouter = express.Router();


// complaint report
reportRouter.post('/api/complaint-report',async(req,res)=>{
    try {
        const {image,location,department,desc,phone,fullname} = req.body;
        const report = new ComplainReport(
            {
                image,
                location,
                desc,
                department,
                phone,
                fullname
            }
        );

        const response = await report.save();
        res.status(200).json(response); 

    } catch (error) {
        console.log(error);
        res.status(200).json({error:"Internal Server Error"});
    }
});

// update location of issue
reportRouter.put('/api/update-location',async(req,res)=>{
    try {
        const {reportId,location} = req.body;
        const report = await ComplainReport.findByIdAndUpdate(
            reportId,
            {
                location:location
            },
            {
                new:true
            }
        );
        res.status(200).json(report);
    } 
    catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});    
    }
});

// my reports
reportRouter.get('/api/my-reports',async(req,res)=>{
    try {
        const {userId} = req.body;
        const reports = await ComplainReport.find({userId}).sort(-1);
        res.status(200).json(reports);
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
})

// nearby reports
reportRouter.get('/api/nearby-report',async(req,res)=>{
    try{
        const {address} = req.body;
        const nearbyReports = await ComplainReport.find(
            {
                $or:[
                    {location:{$regex:address,$options:'i'}},
                    {desc:{$regex:address,$options:'i'}}
                ]
            }
        );

        res.status(200).json(nearbyReports);

    }catch(e){
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
})

module.exports = reportRouter;
