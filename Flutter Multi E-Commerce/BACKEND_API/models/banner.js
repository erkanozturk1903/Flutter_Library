const mongoose = require('mongoose');
const bannerSchema = mongoose.Schema({
 image: {
    type: String,
    required: true
 }
});

const Banner = mongoose.model('banners', bannerSchema);
module.exports = Banner;