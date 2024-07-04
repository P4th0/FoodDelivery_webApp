// Get the modal
var modal = document.getElementById("myModal");

// Get the button that opens the modal

var btns = document.getElementsByClassName("myBtn");

for(i = 0; i<btns.length; i++)
{
    btns[i].onclick = async function(event) {
        var value = event.target.getAttribute("assoc");
        modal.style.display = "block";
        
        const response = await fetch(`/getProductsOrder`, {
                method: 'POST', 
                headers: {
                    'Content-Type': 'application/json'
                  },
                body: JSON.stringify({data: `${value}`}),
            }
        );

        const responseData = await response.json();
        console.log(responseData);

        // Get the table body element
        const tbody = document.querySelector("#myModal .modal-content table tbody");

        // Clear existing rows in the table body
        tbody.innerHTML = '';

        // Iterate over responseData and add rows to the table
        responseData.data.forEach(product => {
            // Create a new row
            let row = document.createElement("tr");

            // Create a cell for the product name
            let cellProdus = document.createElement("td");
            cellProdus.textContent = product.dish.name;
            row.appendChild(cellProdus);

            // Create a cell for the quantity
            let cellCantitate = document.createElement("td");
            cellCantitate.textContent = product.quantity;
            row.appendChild(cellCantitate);

            // Append the row to the table body
            tbody.appendChild(row);
        });
    };
}

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
