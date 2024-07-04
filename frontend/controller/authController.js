const authService = require('../services/authService');

const login = async (req, res) => {
    const { email, password } = req.body;
    try {
        const token = await authService.login(email, password);
        res.cookie('sessionId', token.sessionId, { maxAge: 3600000, httpOnly: true });
        console.log('Request sessionId:', token.sessionId);
        res.redirect('/acasa');
    } catch (error) {
        res.status(400).json({ message: error.response.data });
    }
};

const register = async (req, res) => {
    const { email, password, firstName, lastName, phoneNumber, dateOfBirth, address, city } = req.body;
    var success = true;
    try {
        const token = await authService.register(email, password, firstName, lastName, phoneNumber, dateOfBirth, address, city);
    } catch (error) {
        success = false;
        res.render('auth', {
            errorMsg: error.response.data
        });
    }
    if (success === true) {
        res.render('auth');
    }
};

const logout = async (req, res) => {
    try {
        const sessionId = req.cookies.sessionId; // Access the sessionId cookie directly
        const token = await authService.logout(sessionId);
        res.clearCookie('sessionId');
        res.redirect('/')
    } catch (error) {
        res.status(400).json({ message: error.response.data });
    }
};

module.exports = { login, register, logout };
