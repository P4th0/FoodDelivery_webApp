const axios = require('./initAxios');

const fetch = async (clientId) => { 
    try {
        const url = `https://localhost:7099/api/Orders/showOrders?clientId=${encodeURIComponent(clientId)}`; 
        const response = await axios.get(url);

        return response.data;
    } catch(error) {
        throw error;
    }
}

const fetchProductsOrder = async(orderId) => {
    try {
        const url = `https://localhost:7099/api/Orders/getProductofOrder?order_id=${encodeURIComponent(orderId)}`; 
        const response = await axios.get(url);

        return response.data;
    } catch(error) {
        throw error;
    }
}

module.exports = { fetch, fetchProductsOrder};