using System.Globalization;
using FoodDelivery.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FoodDelivery.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GetDishesController : ControllerBase
    {

        private readonly FoodDeliveryContext _context;

        public GetDishesController(FoodDeliveryContext context)
        {
            _context = context;
        }

        [HttpGet("dishes", Name = "GetDishes")]
        public async Task<ActionResult<IEnumerable<Dish>>> GetDishes(int? restId)
        {
            var staticPath = "/StaticFiles/Images/Dishes/";


            if (restId == null)
            {
                return BadRequest("No restaurant selected from the front-end");
            }

            List<Dish> filteredDishes = await _context.Dishes.Where(dish => dish.RestaurantId == restId).ToListAsync();

            filteredDishes.ForEach(dish => dish.Image = staticPath + dish.Image);


            return filteredDishes;
        }

        [HttpGet("GetOnlyDishes")]
        public async Task<ActionResult<IEnumerable<Dish>>> GetOnlyDishes(int? dishId)
        {
            var staticPath = "/StaticFiles/Images/Dishes/";


            if (dishId == null)
            {
                return BadRequest("No dish selected from the front-end");
            }

            List<Dish> filteredDishes = await _context.Dishes.Where(dish => dish.Id == dishId).ToListAsync();

            filteredDishes.ForEach(dish => dish.Image = staticPath + dish.Image);


            return filteredDishes;
        }




    }
}
