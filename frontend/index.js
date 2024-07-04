const express = require('express');
const app = express();
const path = require('path');
const mime = require('mime-types');
const ejs  = require('ejs');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');

const authController = require('./controller/authController');
const restaurantController =require('./controller/restaurantController');
const dishController = require('./controller/dishController')
const isAuthentificated = require('./services/SessionService')
const userController = require('./controller/userController')
const orderController = require('./controller/orderController')

app.use(express.static('resources'));
app.use(bodyParser.urlencoded({extended: true}));
app.use(cookieParser());
app.set('view engine', 'ejs');
app.use(express.json());


app.get('/', (req, res) => {
  res.render('auth');
});

app.get('/dishes',isAuthentificated, dishController.getDishes);

app.get('/restaurants',isAuthentificated, restaurantController.getRestaurante);

app.post('/processLogin', authController.login);

app.post('/processRegister',authController.register);

app.post('/processLogout',authController.logout);

app.get('/checkout',isAuthentificated, (req, res) => {
  res.render('checkout');
});
app.get('/your_orders',isAuthentificated, (req, res) => {
  res.render('your_orders');
});
app.get('/acasa',isAuthentificated, (req, res) => {
  res.render('acasa');
});
app.get('/myprofile', isAuthentificated, userController.getUserDetails);
app.post('/addAddress', isAuthentificated, userController.addAdditionalAddress);
app.get('/your-orders',isAuthentificated, orderController.getOrders);
app.post('/prepareCart',dishController.prepareCart);
app.post('/getProductsOrder', orderController.getProductsOrder);
app.post('/sendCheckout',dishController.sendCheckout);

app.listen(8080, () => {
  console.log('Serverul rulează pe portul 8080');
});