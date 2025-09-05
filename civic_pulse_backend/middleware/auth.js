/*const jwt = require("jsonwebtoken");
const User = require('../models/user');
const Vendor = require('../models/vendor');

// authentication middleware 
// this middleware checking that the user is authenticated or not
auth = async(req,res,next)=>{
  try {
    // extract token from the request header
    const token = req.header('x-auth-token');
    // if no token is provided then return 401(unauthorized) error with a authentication denied message
    if(!token) return res.status(401).json({msg:"No authentication token,authorization denied"});
    // verify the jwt token by using secret key
    const verified = await jwt.verify(token,"passwordKey");
    // if token verification failed then return 401(unauthorized) error with message
    if(!verified) return res.status(401).json({msg:"Token verification failed,authorization failed"});
    // find the user or vendor in the database using id which is stored in token payload,
    const user = await User.findById(verified.id) || await Vendor.findById(verified.id);
    // if user or vendor not found then return 401(unauthorized)error
    if(!user) return res.status(401).json({msg:"User or Vendor not found,authorization denied "});
    // attach the authenticated user (whether a user or vendor) to the request object
    // this make's the user data available to any subsequent middleware or route handlers
    req.user = user;
    // attach the token also in request object if incase is needed later
    req.token = token;
    // proceed to the next middleware or route
    next();
    } 
    catch (error) {
      res.status(500).json({error:error.message});
    }
}



// vendor authentication middleware
// this middleware ensures that the user making the request is a vendor
// it should be used for routes that only vendor can access.

const vendorAuth = async(req,res,next)=>{
  try {
    // check if the user making the request is a vendor(by checking the "role" property because user dont have role property
    // so if req.user.role don't have role property this means "User" is making request vendor is not making request
    // therefore restrict him by throwing 403 error).
    if(!req.user.role || req.user.role!=="vendor"){
      // if user is not a vendor then return 403(forbidden error) with a error message
      return res.status(403).json({msg:"Access denied, only vendors are allowed"}) 
    }
    // if the user is vendor then, proceed to the next middleware or route handler.
    next();
  } catch (error) {
    return res.status(500).json({error:e.message});
  }
}

module.exports = {auth,vendorAuth};*/