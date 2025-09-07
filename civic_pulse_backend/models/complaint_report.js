const mongoose = require('mongoose');


const commentSchema = new mongoose.Schema({
    userId:{
        type:String,
        required:true
    },
    fullname:{
        type:String,
        required:true
    },
    profilePic:{
        type:String
    },
    text:{
        type:String,
        required:true
    },
},{timestamps:true})





const complainReportSchema = new mongoose.Schema({
    image:{
        type:String
    },
    userId:{
        type:String,
        required:true
    },
    location:{
        type:String,
        required: true
    },
    status:{
        type:String,
        enum:['pending','processing','completed']
    },
    department:{
        type:String,
        required:true
    },
    upvote:{
        type:Number,
        default:0
    },
    profilePic:{
        type:String
    },
    desc:{
        type:String,
        required:true
    },
    phone:{
        type:String,
        required:true
    },
    fullname:{
        type:String,
        required:true
    },
    comments:[commentSchema]
},{timestamps:true}
);


const ComplainReport = mongoose.model('ComplaintReport',complainReportSchema);
module.exports = ComplainReport;