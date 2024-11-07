//import the express module
const express = require('express');
const mongoose = require("mongoose");
const authRouter = require('./routes/auth');

//Define the port number the server will listen on
const PORT = 3000;

//create an instance of an express application
const app = express();

//mongodb String (veritabanı adı eklendi)
const DB = "mongodb+srv://erozturk0381:erkan@cluster0.dfnor.mongodb.net/test";

//middleware - to register router or mount routes
app.use(express.json());
app.use(authRouter);

// Test endpoint ekleyelim
app.get('/test', (req, res) => {
    if (mongoose.connection.readyState === 1) {
        res.json({ status: 'success', message: 'Veritabanı bağlantısı aktif' });
    } else {
        res.json({ 
            status: 'error', 
            message: 'Veritabanı bağlantısı yok', 
            state: mongoose.connection.readyState 
        });
    }
});

// MongoDB bağlantısı
mongoose.connect(DB)
    .then(() => {
        console.log('MongoDB bağlantısı başarılı');
    })
    .catch((err) => {
        console.error('MongoDB bağlantı hatası:', {
            message: err.message,
            code: err.code,
            name: err.name
        });
    });

// Genel mongoose hata dinleyicisi
mongoose.connection.on('error', (err) => {
    console.error('Mongoose bağlantı hatası:', err);
});

//Start the server and listen on the specified port
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server is running on port ${PORT}`);
});