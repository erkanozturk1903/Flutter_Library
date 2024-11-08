const express = require('express');
const SubCategory = require('../models/sub_category');
const subCategoryRouter = express.Router();

subCategoryRouter.post('api/subcategories', async (req, res)=> {
    try {
        const {categoryId, categoryName, image, subCategoryName} = req.body;
        const subcategory = new ({categoryId, categoryName, image, subCategoryName});
        await subcategory.save();
        res.status(201).send(subcategory);
        
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

subCategoryRouter.get('/api/category/:categoryName/subcategories', async (req, res)=> {
    try {
       
      const {categoryName} =  req.params;

      const subcategories = await SubCategory.find({categoryName:categoryName});
      if(!subcategories || subcategories.length == 0){
         return res.status(404).json({msg: "subcategor,es not found"});
      }else {
        return res.status(200).json({subcategories})
      }
     
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

module.exports = subCategoryRouter;