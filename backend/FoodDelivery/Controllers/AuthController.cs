using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore.Query.Internal;
using FoodDelivery.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using System.Security.Cryptography;
using System.IdentityModel.Tokens.Jwt;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;
using System.Text.RegularExpressions;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using System.Net;
using Microsoft.AspNetCore.Authorization;
using FoodDelivery.Views;

namespace FoodDelivery.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly FoodDeliveryContext _context;

        public AuthController(FoodDeliveryContext context)
        {
            _context = context;
        }

        [HttpPost("register")]

        public async Task<IActionResult> Register(RegisterModel input)
        {
            if (!VerifyuserDetails(input))
                return BadRequest("One or more of user details misstyped");


            if (await _context.UserCredentials.AnyAsync(x => x.Email == input.Email))
                return BadRequest("Email is already registered");

            //encrypt password

            byte[] salt = RandomNumberGenerator.GetBytes(128 / 8);

            string hashed = Convert.ToBase64String(KeyDerivation.Pbkdf2(
                password: input.Password!,
                salt: salt,
                prf: KeyDerivationPrf.HMACSHA256,
                iterationCount: 100000,
                numBytesRequested: 256 / 8));

            var userCredential = new UserCredential { Email = input.Email, Password = hashed, Salt = salt }; // aici se face hashing la parola

            _context.UserCredentials.Add(userCredential);
            await _context.SaveChangesAsync();

            var userDetail = new UserDetail
            {
                FirstName = input.FirstName,
                LastName = input.LastName,
                PhoneNumber = input.PhoneNumber,
                DateOfBirth = input.DateOfBirth,
                Address = input.Address,
                City = input.City,
                User = userCredential
            };


            _context.UserDetails.Add(userDetail);
            await _context.SaveChangesAsync();

            return StatusCode(201);
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login(LoginModel request)
        {
            var credentialFound = await _context.UserCredentials.Where(c => c.Email == request.Email).FirstOrDefaultAsync();

            if (credentialFound == null)
                return BadRequest("Email not found");

            if (!VerifyPassword(request.Password, credentialFound.Password, Convert.ToBase64String(credentialFound.Salt)))
                return BadRequest("Password its incorect");

            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, request.Email),
                new Claim(ClaimTypes.Role, "User")
            };
            var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

            var authProperties = new AuthenticationProperties
            {
                ExpiresUtc = DateTimeOffset.UtcNow.AddMinutes(60),
                IsPersistent = true,
            };
            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity), authProperties);

            var sessionId = Guid.NewGuid().ToString();

            var userSession = new UserSession
            {
                Email = request.Email,
                SessionId = sessionId,
                CreatedAt = DateTime.UtcNow,
                ExpiresAt = DateTime.UtcNow.AddMinutes(60),
                UserId = credentialFound.Id
            };

            _context.UserSessions.Add(userSession);
            await _context.SaveChangesAsync();

            Response.Cookies.Append("sessionId", sessionId, new CookieOptions
            {
                HttpOnly = true,
                Secure = true, // Make sure to set this to true if your site is served over HTTPS

            });

            return Ok(new { sessionId });

        }

        
        [HttpPost("logout")]
        public async Task<IActionResult> Logout(SessionIdModel sessionIdModel)
        {
            if (string.IsNullOrEmpty(sessionIdModel?.sessionId))
                return BadRequest("SessionId not provided");

            var session = await _context.UserSessions.FirstOrDefaultAsync(s => s.SessionId == sessionIdModel.sessionId);

            if (session == null || session.ExpiresAt < DateTime.UtcNow)
                return NotFound("Session not found or expired");


            _context.UserSessions.Remove(session);
            await _context.SaveChangesAsync();

            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

            return Ok("Logout successful");
        }

        [HttpGet("GetUserDetails")]
        public async Task<IActionResult> GetUserDetails([FromQuery] string sessionId)
        {
            if (string.IsNullOrEmpty(sessionId))
                return BadRequest("SessionId not provided");

            var session = await _context.UserSessions.FirstOrDefaultAsync(s => s.SessionId == sessionId);

            if (session == null || session.ExpiresAt < DateTime.UtcNow)
                return NotFound("Session not found or expired");

            var userDetails = await _context.UserDetails.FirstOrDefaultAsync(e => e.UserId == session.UserId);
            var email = session.Email;

            var response = new UserDetailsEmail
            {
                UserDetails = userDetails,
                Email = email
            };

            return Ok(response);
        }

        [HttpPost("addAdditionalAddress")]
        public async Task<IActionResult> AddAdditionalAddress(AdditionalAddressModel model)
        {
            var session = await _context.UserSessions.FirstOrDefaultAsync(s => s.SessionId == model.SessionId);

            if (session == null || session.ExpiresAt < DateTime.UtcNow)
                return BadRequest("Session not found or expired");

            var userDetails = await _context.UserDetails.FirstOrDefaultAsync(e => e.UserId == session.UserId);

            if (userDetails == null)
                return BadRequest("User details not found");

            // Actualizăm adresele suplimentare în baza de date
            if (string.IsNullOrEmpty(userDetails.AdditionalAddresses))
            {
                userDetails.AdditionalAddresses = model.AdditionalAddress;
            }
            else
            {
                userDetails.AdditionalAddresses += $"|{model.AdditionalAddress}";
            }

            await _context.SaveChangesAsync();

            return Ok("Additional address added successfully");
        }




        private bool VerifyPassword(string enteredPassword, string storedHash, string storedSalt)
        {
            var saltBytes = Convert.FromBase64String(storedSalt);
            string hashed = Convert.ToBase64String(KeyDerivation.Pbkdf2(
                password: enteredPassword,
                salt: saltBytes,
                prf: KeyDerivationPrf.HMACSHA256,
                iterationCount: 100000, // Ensure this matches the iteration count used in registration
                numBytesRequested: 256 / 8)); // Ensure this matches the byte size used in registration

            return hashed == storedHash;
        }


        // simple check of user input data
        private bool VerifyuserDetails(RegisterModel input)
        {
            if (!Regex.IsMatch(input.FirstName, @"^[a-zA-Z\s]*$") || !Regex.IsMatch(input.LastName, @"^[a-zA-Z\s]*$"))
                return false;


            if (!Regex.IsMatch(input.PhoneNumber, @"^\d{10}$"))
                return false;


            if (input.DateOfBirth != null)
            {
                DateTime minDateOfBirth = new DateTime(1900, 1, 1);
                DateTime maxDateOfBirth = DateTime.Now;

                if (input.DateOfBirth < minDateOfBirth || input.DateOfBirth > maxDateOfBirth)
                    return false;
            }

            if (!Regex.IsMatch(input.Address, @"^[a-zA-Z0-9\s.]*$") || !Regex.IsMatch(input.City, @"^[a-zA-Z0-9\s.]*$"))
                return false;

            string emailPattern = @"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$";
            if (!Regex.IsMatch(input.Email, emailPattern))
                return false;

            return true;
        }

    }
}
