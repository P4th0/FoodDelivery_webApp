const axios = require('./initAxios');

const login = async (email,password) => { 
    try{
        const response = await axios.post("https://localhost:7099/api/Auth/login",{
        email,
        password
        });
        
        return response.data;

    } catch(error) {
        throw error;
    }
}

const register = async (email,password,firstName,lastName,phoneNumber,dateOfBirth,address,city) => {
    try{
        const response = await axios.post("https://localhost:7099/api/Auth/register",{
            email,
            password,
            firstName,
            lastName,
            phoneNumber,
            dateOfBirth,
            address,
            city
        });
        return response.data;
      } catch (error) {
            throw error; 
      }
    }

    const logout = async (sessionId) => {
        try {
            const response = await axios.post("https://localhost:7099/api/Auth/logout", {
                sessionId
            });
            return response.data;
        } catch (error) {
            throw error;
        }
    };

module.exports = { login, register, logout };
