const mongoose = require('mongoose');
const workerSchema = new mongoose.Schema({
    name: {type: String, required: true},
    email: {type: String, required: true, unique: true},
    phone: {type: String},
    department: {type: String, required: true},
    address: {type: String},
    picture: {type: String},
    password: {type: String, required: true},
    assignedReports: [{ type: mongoose.Schema.Types.ObjectId, ref: 'ComplainReport' }]
}, { timestamps: true });

module.exports = mongoose.model('Worker', workerSchema);
