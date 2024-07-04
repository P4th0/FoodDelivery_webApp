document.addEventListener('DOMContentLoaded', function() {

    if(localStorage.getItem("cart").length !== 0)
    {
        afiseazaCosul(JSON.parse(localStorage.getItem("cart")));
    }

})

function afiseazaCosul(cartItems) {
    let totalPrice = 0.0;

    // Iterăm prin fiecare produs din coș și construim structura HTML pentru afișare
    cartItems.forEach(item => {
        // Calculăm prețul total
        totalPrice += item.productPrice * item.quantity;
    });

    // Actualizăm prețul total în interfață
    const subTotalElement = document.getElementById('cart-subtotal');
    const totalElement = document.getElementById('cart-total');
    subTotalElement.textContent = `${totalPrice} RON`;
    totalElement.textContent = `${totalPrice} RON`;
}