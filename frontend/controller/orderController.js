const orderService = require('../services/orderService');
const userService = require('../services/userService');
const dishService = require('../services/dishService');

const getOrders = async (req,res) =>{
    try{
     //first get sessionId then we get the userId
    const sessionId = req.cookies.sessionId;
    if (!sessionId) {
        return res.status(400).send('SessionId not provided');
    }
    const data = await userService.userDetails(sessionId);
    const userId = data.userDetails.userId;
    const orders = await orderService.fetch(userId);
    



    console.table(orders);

    res.render('your_orders',{orders: orders} );
 } catch (error) {
    console.error('Error fetching user details:', error);
    res.status(500).json({ error: 'Failed to fetch user details' });
}

};


const getProductsOrder = async (req,res) => {    
    try{
        //first get sessionId then we get the userId
       const sessionId = req.cookies.sessionId;
       if (!sessionId) {
           return res.status(400).send('SessionId not provided');
       }

       const responseData = req.body;
       const productsOrder = await orderService.fetchProductsOrder(responseData.data);


       res.json({data: productsOrder});

    } catch (error) {
       console.error('Error fetching user details:', error);
       res.status(500).json({ error: 'Failed to fetch user details' });
   }
};

module.exports = { getOrders, getProductsOrder };