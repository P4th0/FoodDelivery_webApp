const axios = require('./initAxios');

const userDetails = async (sessionId) => { 
    try{
        const url = `https://localhost:7099/api/Auth/GetUserDetails?sessionId=${encodeURIComponent(sessionId)}`;  
        const response = await axios.get(url);
        return response.data;
    } catch(error) {
        throw error;
    }
};

const addAddress = async (sessionId, additionalAddress) => {
    try {
        const response = await axios.post("https://localhost:7099/api/Auth/addAdditionalAddress", {
            sessionId,
            additionalAddress
        });
    return response.data;        
        
    } catch (error) {
        throw error;
    }
};

module.exports = { userDetails, addAddress };