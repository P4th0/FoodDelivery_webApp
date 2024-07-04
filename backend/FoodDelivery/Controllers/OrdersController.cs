using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using FoodDelivery.Models;
using Microsoft.EntityFrameworkCore;
using FoodDelivery.Views;

namespace FoodDelivery.Controllers
{
    public class OrderView
    {
        public int idOrder { get; set; }
        public DateTime date_of_order { get; set; }
        public string nameRestaurant { get; set; }

        public double price { get; set; }

        public string adress_delivered { get; set; }

    }

    public class ProductOrderView
    {
        public Dish Dish { get; set; }
        public int quantity { get; set; }
    }

    public class OrderModel
    {
        public int ClientId { get; set; }
        public List<Product> Products { get; set; }
    }
    public class Product
    {
        public int id { get; set; }
        public int Quantity { get; set; }
    }


    [ApiController]
    [Route("api/[controller]")]
    public class OrdersController : ControllerBase
    {

        private readonly FoodDeliveryContext _context;

        public OrdersController(FoodDeliveryContext context)
        {
            _context = context;
        }

        [HttpPost("checkout")]
        public async Task<IActionResult> Checkout([FromBody] OrderModel orderInput)
        {
            if (orderInput == null || orderInput.Products == null || orderInput.Products.Count == 0)
            {
                return BadRequest("Invalid order data.");
            }

            var productsFromOrder = orderInput.Products;

            bool productValidation = true;
            var totalPrice = 0.0;
            int restaurantId = -1;

            foreach(var product in productsFromOrder)
            {
                var productDatabase = await _context.Dishes.FirstOrDefaultAsync(x => x.Id == product.id);

                if (productDatabase == null)
                {
                    productValidation = false;
                    break;
                }

                totalPrice = productDatabase.Price * product.Quantity;
                restaurantId = productDatabase.RestaurantId;
            }

            if(!productValidation) { return BadRequest(); }

            var clientInfo = await _context.UserDetails.FirstOrDefaultAsync(x => x.UserId == orderInput.ClientId);

            if (clientInfo == null)
                return BadRequest();

            var order = new Order
            {
                ClientId = orderInput.ClientId,
                DateOfOrder = DateTime.Now,
                Price = totalPrice,
                AdressDelivered = clientInfo.Address,
                RestId = restaurantId
            };

            _context.Orders.Add(order);
            await _context.SaveChangesAsync();

            foreach (var product in productsFromOrder)
            {
                var addToAssoc = new OrderDish
                {
                    IdOrder = order.Id,
                    IdDish = product.id,
                    Quantity = product.Quantity
                };

                _context.OrderDishes.Add(addToAssoc);
                await _context.SaveChangesAsync();
            }   

            return Ok();
        }

        [HttpGet("getOrders")]
        public async Task<IActionResult> GetOrders(int? clientId)
        {
            if (clientId == null)
                return NotFound("Clientul nu a fost gasit");


            var orders = await _context.Orders.Where(o => o.ClientId == clientId).ToListAsync();
            
            
            return Ok(orders);
            
        }

        [HttpGet("showOrders")]
        public async Task<IActionResult> ShowOrders(int? clientId)
        {
            if (clientId == null)
                return NotFound("Clientul nu a fost gasit");

            var orders = await _context.Orders.Where(x => x.ClientId == clientId).ToListAsync();

            List<OrderView> ordersView = new List<OrderView>();

            foreach(var order in orders)
            {
                Restaurant crRestaurant = await _context.Restaurants.FirstOrDefaultAsync(x => x.Id == order.RestId);

                var crOrderView = new OrderView
                {
                    idOrder = order.Id,
                    adress_delivered = order.AdressDelivered,
                    date_of_order = order.DateOfOrder,
                    price = order.Price,
                    nameRestaurant = crRestaurant.Name
                };

                ordersView.Add(crOrderView);
            }


            return Ok(ordersView);
        }

        [HttpGet("getAllOrders")]
        public async Task<IActionResult> GetAllOrders()
        {
            var orders = await _context.Orders.ToListAsync();
            return Ok(orders);


        }

        [HttpGet("getProductofOrder")]
        public async Task<IActionResult> getProductofOrder(int order_id)
        {
            if (order_id == null)
                return NotFound("comanda nu a fost gasita");

            //step 1 selecteaza toate idurile dishurilor pe baza la order_Id
            var dishesFromOrder = await _context.OrderDishes.Where(x => x.IdOrder == order_id).ToListAsync();

            //step 2 selecteaza toate dishurile care le gasesti din dishesfromOrder
            

            List<ProductOrderView> products = new List<ProductOrderView>();

            foreach(var orderDish in dishesFromOrder)
            {
                Dish? dish = await _context.Dishes.FirstOrDefaultAsync(x => orderDish.IdDish == x.Id);

                if(dish == null) continue;

                var orderCrView = new ProductOrderView
                {
                    Dish = dish,
                    quantity = orderDish.Quantity
                };

                products.Add(orderCrView);
            }

            return Ok(products);

        }
    }
}
