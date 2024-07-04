using FoodDelivery.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FoodDelivery.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GetRestaurantsController : ControllerBase
    {

        private readonly FoodDeliveryContext _context;

        public GetRestaurantsController(FoodDeliveryContext context)
        {
            _context = context;
        }

        [HttpGet("restaurants", Name = "GetRestaurants")]
        public async Task<ActionResult<IEnumerable<Restaurant>>> GetRestaurants()
        {
            var restaurante = await _context.Restaurants.ToListAsync();

            foreach (Restaurant restaurant in restaurante)
            {
                restaurant.Image = "/StaticFiles/Images/Restaurants/" + restaurant.Image;
                restaurant.Logo = "/StaticFiles/Images/Logos/" + restaurant.Logo;
            }    
                
            return restaurante;
        }

        [HttpGet("restaurantOnly", Name = "GetOnlyRestaurant")]
        public async Task<ActionResult<Restaurant>> GetSpecificRestaurant(int idRes)
        {
            var restaurante = await _context.Restaurants.Where(restaurant => restaurant.Id == idRes).ToListAsync();
            if(restaurante.Count == 0)
                return StatusCode(404);

            var restaurant = restaurante.First();
            restaurant.Image = "/StaticFiles/Images/Restaurante/" + restaurant.Image;
            restaurant.Logo = "/StaticFiles/Images/Logos/" + restaurant.Logo;

            return restaurant;
        }


    }
}
