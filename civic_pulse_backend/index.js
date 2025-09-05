const express = require('express');
const port = 3000;
const app = express();
const db = require('./db');
const bodyparser = require('body-parser');
const auth_route = require('./routes/user_auth');
const reportRouter = require('./routes/complaint_report');
app.use(bodyparser.json());

app.use(auth_route);
app.use(reportRouter);
app.get('/',async(req,res)=>{
    res.send("We are live");
})

app.listen(port,()=>{
    console.log("Server Connected");
})