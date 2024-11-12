const express = require('express');
const User = require('../models/user');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const authRouter = express.Router();

//signup api endpoint
authRouter.post('/api/signup', async(req, res) => {
    console.log('Signup request received:', req.body);
    
    try {
        const {fullName, email, password} = req.body;
        
        console.log('Checking existing email...');
        const existingEmail = await User.findOne({email});
        
        if(existingEmail) {
            console.log('Email already exists');
            return res.status(400).json({msg: 'user with same email already exist'});
        }
        
        console.log('Generating password hash...');
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);
        
        console.log('Creating new user...');
        let user = new User({
            fullName,
            email,
            password: hashedPassword
        });
        
        console.log('Saving user...');
        user = await user.save();
        console.log('User saved successfully');
        
        res.json({user});
    } catch(error) {
        console.error('Error in signup:', error);
        res.status(500).json({error: error.message});
    }
});
//signin api endpoint

authRouter.post('/api/signin', async(req, res) => {
    try {
        const {email, password} = req.body;
     const findUser = await User.findOne({email});
     if(!findUser){
        return res.status(400).json({msg: "User not found with this email"});
     }
     else {
       const isMatch = await bcrypt.compare(password, findUser.password);
       if(!isMatch){
        return res.status(400).json({msg: 'Incorrect Password'});
       }else {
        const token = jwt.sign({id:findUser._id}, "passwordKey");

        //remove sensitive information
        const {password, ...userWithoutPassword } = findUser._doc;
        //sent the response
        res.json({token, ...userWithoutPassword})
        return 
       }
     }
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

module.exports = authRouter;