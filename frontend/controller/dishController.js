const  dishService  = require('../services/dishService'); 
const  restaurantService  = require('../services/restaurantService'); 
const userService = require('../services/userService');
const fs = require('fs');
const path = require('path');

const getDishes = async (req, res) => {
    const restSelected = req.query.restaurantIdSelected;

    try {
        const data = await dishService.fetch(restSelected);
        const restaurant = await restaurantService.fetchSingle(restSelected);
        res.render('dishes',{dishes : data,resSelectat: restaurant} );
        res.render('your-orders')
    } catch(error) {
        res.status(500).json({ message: 'Eroare internă a serverului: ' + error.message }); // În caz de eroare, returnează un mesaj de eroare
    }
}

const prepareCart = async(req,res) => {
    console.log(req.body);

    const fileName = 'prepareCart.json';
    const filePath = path.join(__dirname, fileName);
    const jsonString = JSON.stringify(req.body);

    fs.writeFile(filePath, jsonString, 'utf-8', (err) => {
        if (err) {
            console.error('Error writing JSON file:', err);
        } else {
            console.log('JSON file has been saved:', filePath);
        }
    });

}

const sendCheckout = async(req,res) => {
    try{
        //first get sessionId then we get the userId
       const sessionId = req.cookies.sessionId;
       if (!sessionId) {
           return res.status(400).send('SessionId not provided');
       }
       const data = await userService.userDetails(sessionId);
       const userId = data.userDetails.userId;

       const fileName = 'prepareCart.json';
       const filePath = path.join(__dirname, fileName);
       
       fs.readFile(filePath, 'utf-8', (err, data) => {
        if (err) {
            console.error('Error reading JSON file:', err);
            return;
        }
    
        try {
            // Parse JSON string to object
            const products = JSON.parse(data);
            console.log(products);
    
            // here comes the order
            const result = dishService.sendCheckout(userId,products);
    
        } catch (error) {
            console.error('Error parsing JSON data:', error);
        }
    });



    }catch (error) {
        console.error('Error fetching user details:', error);
        res.status(500).json({ error: 'Failed to fetch user details' });
    }
}


module.exports = {getDishes, prepareCart,sendCheckout};
