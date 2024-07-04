// Obiect pentru a stoca produsele din coș
let cartItems = [];

// Funcția pentru adăugarea unui produs în coș
function adaugaInCos(productId, quantity,selectedProductName,price) {
    // Creăm obiectul pentru produs
    let product = {
        id: productId,
        quantity: quantity,
        selectProductName: selectedProductName,
        productPrice: price
    };

    let existingProductIndex = cartItems.findIndex((element) => element.id == productId);

    if(existingProductIndex != -1)
        //merge! de fapt splice sterge in array si returneaza elemenetele sterse!
        cartItems.splice(existingProductIndex,1);

    // Adăugăm produsul în array-ul cartItems
    cartItems.push(product);
    
    // Actualizăm afișarea în HTML
    localStorage.setItem("cart",JSON.stringify(cartItems));

    console.log(cartItems);
    afiseazaCosul(cartItems);
    


    fetch('http://localhost:8080/prepareCart',{
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(cartItems)
    })
    .then(response => response.json())
    .then(data => console.log(data))
    .catch((error) => console.error('Error:',error));

    
}

// Funcția pentru afișarea produselor din coș în HTML
function afiseazaCosul(cartItems) {
    const cartItemsContainer = document.getElementById('cart-items');
    cartItemsContainer.innerHTML = ''; // Curățăm containerul


    let totalPrice = 0.0;

    // Iterăm prin fiecare produs din coș și construim structura HTML pentru afișare
    cartItems.forEach(item => {
        const itemRow = document.createElement('div');
        itemRow.classList.add('widget-body');
        itemRow.innerHTML = `
            <div class="title-row">
                <span class="item-name">${item.selectProductName}</span>
                <span class="item-price">${item.productPrice}RON x ${item.quantity}</span>
            </div>
        `;
        cartItemsContainer.appendChild(itemRow);

        // Calculăm prețul total
        totalPrice += item.productPrice * item.quantity;
    });

    // Actualizăm prețul total în interfață
    const totalPriceElement = document.getElementById('totalPrice');
    totalPriceElement.textContent = `${totalPrice} RON`;
}

function clearAllCart()
{
    localStorage.setItem("cart","");
    const cartItemsContainer = document.getElementById('cart-items');
    cartItemsContainer.innerHTML = ''; // Curățăm containerul
    const totalPriceElement = document.getElementById('totalPrice');
    totalPriceElement.textContent = `0 RON`;

}

// Așteptăm ca documentul să se încarce complet
document.addEventListener('DOMContentLoaded', function() {

    clearAllCart();


    // Selectăm toate butoanele "Add To Cart"
    const addToCartButtons = document.getElementsByClassName('add-to-cart');
    
    for(var i = 0; i < addToCartButtons.length; i++)
    {
        var button = addToCartButtons[i];
        button.addEventListener('click', function(event){
            var buttonId = event.target.getAttribute('data-product-id');
            var productName = event.target.getAttribute('data-product-name');
            var productPrice = event.target.getAttribute("data-product-price");
            var textFields = document.getElementsByClassName('quantityTextField');
            
            let foundTextField = null;
            for(let j = 0; j < textFields.length; j++)
            {
                if(textFields[j].id === buttonId)
                {
                    foundTextField = textFields[j];
                    break;
                }
            }

            if(foundTextField)
            {
                let quantityProductSelected = foundTextField.value.replaceAll(/[A-Za-z\s]/g, '');
                
                if(quantityProductSelected.length !== 0)
                    adaugaInCos(buttonId,quantityProductSelected,productName,productPrice);
            }
        })
    }
});


var trashCan = document.getElementById('clear-all-cart');
trashCan.addEventListener("click",clearAllCart);