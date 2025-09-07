const express = require('express');
const port = 3000;
const app = express();
const db = require('./db');
const bodyparser = require('body-parser');
const auth_route = require('./routes/user_auth');
const workerAuthRoute = require('./routes/worker_auth');
const comments = require('./routes/comment_route');
const DeptHeadRoute = require('./routes/dept_head_routes');
const adminRoutes = require('./routes/admin_routes');
const cors = require('cors');
const reportRouter = require('./routes/complaint_report');




app.use(bodyparser.json());
app.use(cors());
app.use(auth_route);
app.use(DeptHeadRoute);
app.use(adminRoutes);
app.use(comments);
app.use(workerAuthRoute);
app.use(reportRouter);
app.get('/',async(req,res)=>{
    res.send("We are live");
})

app.listen(port,()=>{
    console.log("Server Connected");
})