const express = require('express');
const Product = require('../models/product');
const productRouter = express.Router();

// Debug için middleware ekleyelim
productRouter.use((req, res, next) => {
    console.log(`[Product Route] ${req.method} ${req.path}`);
    next();
});

productRouter.post('/api/add-product', async(req, res) => {
    try {
        const {productName, productPrice, quantity, description, category, vendorId, fullName, subCategory, images} = req.body;
        const product = new Product({
            productName, 
            productPrice, 
            quantity, 
            description, 
            category,
            vendorId,
            fullName, 
            subCategory, 
            images
        });
        await product.save();
        return res.status(201).json(product);
    } catch (e) {
        console.error('Add product error:', e);
        res.status(500).json({ error: e.message });
    }
});

productRouter.get('/api/popular-products', async(req, res) => {
    try {
        console.log('Fetching popular products...');
        const products = await Product.find({ popular: true });
        
        console.log(`Found ${products.length} popular products`);
        
        if (!products || products.length === 0) {
            return res.status(404).json({ 
                success: false,
                message: "No popular products found" 
            });
        }
        
        return res.status(200).json({
            success: true,
            products: products
        });
    } catch (error) {
        console.error('Error fetching popular products:', error);
        res.status(500).json({ 
            success: false,
            error: error.message 
        });
    }
});

productRouter.get('/api/recommended-products', async(req, res) => {
    try {
        console.log('Fetching recommended products...');
        const products = await Product.find({ recommend: true });
        
        console.log(`Found ${products.length} recommended products`);
        
        if (!products || products.length === 0) {
            return res.status(404).json({
                success: false,
                message: "No recommended products found"
            });
        }
        
        return res.status(200).json({
            success: true,
            products: products
        });
    } catch (error) {
        console.error('Error fetching recommended products:', error);
        res.status(500).json({
            success: false,
            error: error.message
        });
    }
});

productRouter.get('/api/products-by-category/:category', async(req, res)=> {
    try {
        const {category} = req.params;
       const products = await Product.find({category, popular:true});
       if(!products || products.length == 0) {
        return res.status(404).json({msg: "Product no found"});

       }else {
        return res.status(200).json(products);
       }
    } catch (e) {
        res.status(500).json({error: e.message});
    }
})

module.exports = productRouter;