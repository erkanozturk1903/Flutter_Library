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
        res.json({token,user:userWithoutPassword})
        return 
       }
     }
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

//put route for updating users's state, city and locality

authRouter.put('/api/users/:id', async (req, res) => {
    try {
        //Extract the 'id' parameter from the request URL
        const {id} = req.params;
        //Extract the "state", "city" and locality fields from the request body
        const {state, city, locality} = req.body;
        //Find the user by their ID and update the state, locality, city fileds
        const updateUser = await User.findByIdAndUpdate(
            id,
            {state, city, locality},
            {new:true},
        );
        //if no user is found, return 404 page not found status with an error message
        if(!updateUser){
            return res.status(404).json({error: "User not found"});
        }
        return res.status(200).json(updateUser);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

module.exports = authRouter;