const userService = require('../services/userService');

const getUserDetails = async (req, res) => {
    try {
        const sessionId = req.cookies.sessionId;
        if (!sessionId) {
            return res.status(400).send('SessionId not provided');
        }
        const data = await userService.userDetails(sessionId);
        res.render('myprofile',{userDetails: data} );
    } catch (error) {
        console.error('Error fetching user details:', error);
        res.status(500).json({ error: 'Failed to fetch user details' });
    }
};

const addAdditionalAddress = async (req, res) => {
    try {
        const sessionId = req.cookies.sessionId;
        const additionalAddress = req.body.additionalAddress;
        if (!sessionId || !additionalAddress) {
            return res.status(400).json({ error: 'SessionId or additionalAddress missing in request' });
        }
        const result = await userService.addAddress(sessionId, additionalAddress);
        res.status(200).json({ message: result });
    } catch (error) {
        console.error('Error adding additional address:', error.message);

        res.status(500).json({ error: 'Failed to add additional address' });
    }
};

module.exports = { getUserDetails, addAdditionalAddress };