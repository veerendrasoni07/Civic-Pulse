const mongoose = require('mongoose');

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
    department:{
        type:String,
        required:true
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
    }
},{timestamps:true}
);


const ComplainReport = mongoose.model('ComplaintReport',complainReportSchema);
module.exports = ComplainReport;