const axios = require('./initAxios');

const fetch = async () => { 
    try {
        const response = await axios.get('https://localhost:7099/api/GetRestaurants/restaurants');
        return response.data;
    } catch(error) {
        throw error;
    }
}

const fetchSingle = async (restSelected) => { 
    try {
        const url = `https://localhost:7099/api/GetRestaurants/restaurantOnly?idRes=${encodeURIComponent(restSelected)}`; 
        const response = await axios.get(url);
        return response.data;
    } catch(error) {
        throw error;
    }
}



module.exports = { fetch, fetchSingle };