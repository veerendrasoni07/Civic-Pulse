const express = require("express");
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const {OAuth2Client} = require('google-auth-library');
const client = new OAuth2Client();
require('dotenv').config();
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");

// Sign Up
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { fullname, email, password,phone } = req.body;

    const existingUser = await User.findOne({ email });
    
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      fullname,
      phone
    });

    user = await user.save();

    res.json(user);

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Sign In

authRouter.post("/api/login", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, user:user._doc});
  } catch (e) {
    console.log(error);
    res.status(500).json({ error: e.message });
  }
});

// google sign in 

/*
authRouter.post('/api/google-signin',async(req,res)=>{
  try {
    const {tokenId} = req.body;
    const ticket = await client.verifyIdToken(
      {
        tokenId,
        audience:process.env.GOOGLE_CLIENT_ID
      }
    );

    const payload = ticket.getPayload();
    const googleId = payload.sub;
    const email = payload.email;
    const picture = payload.picture;
    const name = payload.name;

    const user = await User.findOne({googleId});
    if(!user){
      user = await User.create({
        fullname:name,
        email:email,
        picture:picture,
        role:'citizen',
        authProvider:'google'
      })
    }
    else{
      // existing user -> link google if not already linked 
      if(!user.googleId) user.googleId = googleId;
      if(!user.authProvider.includes('google')) user.authProvider.push('google');
      await user.save();
    }

    const token = await jwt.sign({userId:user._id},process.env.JWT_SECRET_TOKEN);
    res.status(200).json({token,user});

  } catch (error) {
    console.log(error);
    res.status(500).json({error:"Internal Server Error"});
  }
})*/

 
module.exports = authRouter;