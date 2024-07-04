const  restaurantService  = require('../services/restaurantService');


const getRestaurante = async (req, res) => {
    try {
        var data = await restaurantService.fetch();
        res.render('restaurants', {listaRestaurante: data});
    } catch(error) {
        res.status(500).json({ message: 'Eroare internă a serverului: ' + error.message }); // În caz de eroare, returnează un mesaj de eroare
    }
}

module.exports = { getRestaurante };
