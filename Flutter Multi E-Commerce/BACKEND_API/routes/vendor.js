const express = require('express');
const Vendor = require('../models/vendor');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const vendorRouter = express.Router();




vendorRouter.post('/api/vendor/signup', async(req, res) => {
    console.log('Signup request received:', req.body);
    
    try {
        const {fullName, email, password} = req.body;
        
        console.log('Checking existing email...');
        const existingEmail = await Vendor.findOne({email});
        
        if(existingEmail) {
            console.log('Email already exists');
            return res.status(400).json({msg: 'vendor with same email already exist'});
        }
        
        console.log('Generating password hash...');
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);
        
        console.log('Creating new vendor...');
        let vendor = new Vendor({
            fullName,
            email,
            password: hashedPassword
        });
        
        console.log('Saving vendor...');
        vendor = await vendor.save();
        console.log('Vendor saved successfully');
        
        res.json({vendor});
    } catch(error) {
        console.error('Error in signup:', error);
        res.status(500).json({error: error.message});
    }
});

vendorRouter.post('/api/vendor/signin', async(req, res) => {
    try {
        const {email, password} = req.body;
     const findVendor = await Vendor.findOne({email});
     if(!findVendor){
        return res.status(400).json({msg: "Vendor not found with this email"});
     }
     else {
       const isMatch = await bcrypt.compare(password, findVendor.password);
       if(!isMatch){
        return res.status(400).json({msg: 'Incorrect Password'});
       }else {
        const token = jwt.sign({id:findVendor._id}, "passwordKey");

        //remove sensitive information
        const {password, ...vendorWithoutPassword } = findVendor._doc;
        //sent the response
        res.json({token,vendor:vendorWithoutPassword})
        return 
       }
     }
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})


module.exports = vendorRouter;