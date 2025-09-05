const mongoose = require('mongoose');

const MONGOURL = 'mongodb+srv://civic_pulse2025:M7EjOWsatWVYw705@cluster0.6ndgyhh.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0'


mongoose.connect(MONGOURL);

const db = mongoose.connection;

db.on('connected',()=>{
    console.log('Db Connected');
})

db.on('disconnected',()=>{
    console.log('Db Disconnected');
})


module.exports = db;