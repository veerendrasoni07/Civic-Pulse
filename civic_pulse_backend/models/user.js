const mongoose = require('mongoose');


const userSchema = new mongoose.Schema({
  fullname:{
    type:String,
  },
  email:{
        type:String,
        required:true,
        trim:true,
        unique:true,
        validate:{
            validator:(value)=>{
                const result = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
                return result.test(value);
            },
            message:"Please enter a valid email address!"
        }
    },
    password:{
        type:String,
    },
    state:{
      type:String
    },
    city:{
      type:String
    },
    address:{
      type:String
    },
  phone: String,
  googleId: String,
  picture: String,
  authProvider: [String],
  department:String,
  role: { type: String, default: "citizen" }, // citizen, operator, supervisor,
  createdAt: { type: Date, default: Date.now },
});

const User = mongoose.model("User",userSchema);
module.exports = User;
