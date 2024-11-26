const express = require('express');
const orderRouter = express.Router();
const Order = require('../models/order');


//Post route for creating orders
orderRouter.post('/api/orders', async(req, res) => {
    try {
        const {
            fullName,
            email,
            state,
            city,
            locality,
            productName,
            productPrice,
            quantity,
            category,
            image,
            vendorId,
            buyerId,
    } = req.body;
    const createdAt = new Date().getMilliseconds()
    const order= new Order(
       {
        fullName,
        email,
        state,
        city,
        locality,
        productName,
        productPrice,
        quantity,
        category,
        image,
        vendorId,
        buyerId,
        createdAt
       }
    );
    await order.save();
    return res.status(201).json(order);
    } catch (e) {
        res.status(500).json({error:e.message});
    }
});
//GET route for fetching orders by buyer ID
orderRouter.get('api/orders/:buyerId', async (req, res) => {
    try {
        const {buyerId} = req.params;
        const orders = await Order.find({buyerId});
        if(orders.length ==0) {
            return res.status(404).json({msg: "No Orders found for this buyer"});
        }
        return res.status(200).json(orders);
    } catch (error) {
        res.status(500).json({error: e.message});
    }
})


module.exports = orderRouter; 