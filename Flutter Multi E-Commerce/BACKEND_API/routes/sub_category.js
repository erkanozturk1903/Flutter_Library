const express = require('express');
const SubCategory = require('../models/sub_category');
const subcategoryRouter = express.Router();

subcategoryRouter.post('/api/subcategories', async (req, res)=> {
    try {
        const {categoryId, categoryName, image, subCategoryName} = req.body;
        const subcategory = new SubCategory({categoryId, categoryName, image, subCategoryName});
        await subcategory.save();
        res.status(201).send(subcategory);
        
    } catch (e) {
        res.status(500).json({error: e.message});
    }
});


subcategoryRouter.get('/api/subcategories', async (req, res) => {
    console.log('GET /api/subcategories isteği alındı'); // Debug log

    try {
        const subcategories = await SubCategory.find();
        console.log('Bulunan subcategories:', subcategories); // Debug log
        
        return res.status(200).json(subcategories);
    } catch (error) { // e yerine error kullanıldı
        console.error('Subcategories getirme hatası:', error); // Debug log
        res.status(500).json({error: error.message}); // e yerine error kullanıldı
    }
});

subcategoryRouter.get('/api/category/:categoryName/subcategories', async (req, res)=> {
    try {
       
      const {categoryName} =  req.params;

      const subcategories = await SubCategory.find({categoryName:categoryName});
      if(!subcategories || subcategories.length == 0){
         return res.status(404).json({msg: "subcategories not found"});
      }else {
        return res.status(200).json({subcategories})
      }
     
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

module.exports = subcategoryRouter;