const express = require('express');
const ComplainReport = require('../models/complaint_report');
const commentRoute = express.Router();


commentRoute.post('/api/comment/:reportId',async(req,res)=>{
    try {
        const {userId,fullname,text,profilePic} = req.body;
        const {reportId} = req.params;
        const complaint = await ComplainReport.findByIdAndUpdate(
            reportId,
            {
                $push:{
                    comments:{userId,fullname,text,profilePic}
                }
            },{
                new:true
            }
        );
         // return ONLY the newly added comment
        const newComment = complaint.comments[complaint.comments.length - 1];
        res.status(200).json(newComment);
        
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
});

commentRoute.post('/api/vote/:reportId',async(req,res)=>{
    try {
        const {reportId} = req.params;
        const complaint = await ComplainReport.findByIdAndUpdate(
            reportId,
            {
                $inc:{upvote:1} // increment
            },
            {new:true}
        )
        res.status(200).json(complaint);
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
});


commentRoute.get('/api/get-comments/:reportId',async(req,res)=>{
    try {
        const {reportId} = req.params;
        const allComments = await ComplainReport.findById(
            reportId
        );
        res.status(200).json(allComments.comments);
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
});



module.exports = commentRoute;