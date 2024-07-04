const axios = require('./initAxios');

const fetch = async (restSelected) => { 
    try {
        const url = `https://localhost:7099/api/GetDishes/dishes?restId=${encodeURIComponent(restSelected)}`; 
        const response = await axios.get(url);
        return response.data;
    } catch(error) {
        throw error;
    }
}

const fetchOnlyDish = async (dishId) => { 
    try {
        const url = `https://localhost:7099/api/GetDishes/GetOnlyDishes?dishId=${encodeURIComponent(dishId)}`; 
        const response = await axios.get(url);
        return response.data;
    } catch(error) {
        throw error;
    }
}

const sendCheckout = async (clientId, products) =>
{
    try{
        const response = await axios.post("https://localhost:7099/api/Orders/checkout",{
        clientId,
        products
        });
        
        return response.data;

    } catch(error) {
        throw error;
    }
}






module.exports = { fetch, fetchOnlyDish, sendCheckout};