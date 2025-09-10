const mongoose = require('mongoose');

const commentSchema = new mongoose.Schema({
  userId: { type: String, required: true },
  fullname: { type: String, required: true },
  profilePic: { type: String },
  text: { type: String, required: true },
}, { timestamps: true });

// Feedback schema (from citizen after resolution)
const feedbackSchema = new mongoose.Schema({
  rating: { type: Number, min: 1, max: 5 }, // optional star rating
  comment: { type: String },
  submittedBy: { type: String, required: true }, // citizen userId
}, { timestamps: true });

// Tracking history (status updates with timestamps)
const historySchema = new mongoose.Schema({
  status: { type: String, enum: ['pending', 'processing', 'completed', 'reopened'], required: true },
  updatedAt: { type: Date, default: Date.now },
  updatedBy: { type: String }, // workerId or headId
  note: { type: String }, // e.g., "Assigned to Worker A"
});

const complainReportSchema = new mongoose.Schema({
  image: { type: String }, // complaint image
  userId: { type: String, required: true }, // citizen who created
  location: { type: String, required: true },
  status: { type: String, enum: ['pending', 'processing', 'completed', 'reopened'], default: 'pending' },
  department: { type: String, required: true },
  upvote: { type: Number, default: 0 },
  profilePic: { type: String },
  desc: { type: String, required: true },
  phone: { type: String, required: true },
  fullname: { type: String, required: true },
  assignedHead:{
    headId: { type: String },
    headName: { type: String },
  },
  assignedTo: [
    {
      workerId: { type: String },
      workerName: { type: String },
    }
  ],
  completionImage: { type: String }, // after fix photo
  escalated: { type: Boolean, default: false },
  feedback: feedbackSchema, // citizen feedback
  history: [historySchema], // status timeline
  comments: [commentSchema],
}, { timestamps: true });

const ComplainReport = mongoose.model('ComplaintReport', complainReportSchema);
module.exports = ComplainReport;
