using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace code.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PrimeNumberController : ControllerBase
    {
        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        private readonly ILogger<PrimeNumberController> _logger;

        public PrimeNumberController(ILogger<PrimeNumberController> logger)
        {
            _logger = logger;
        }

        [HttpGet("isPrime")]
        public bool Get(int number)
        {
            if (number <= 1) return false;
            if (number == 2) return true;
            if (number % 2 == 0) return false;

            var boundary = (int)Math.Floor(Math.Sqrt(number));
                
            for (int i = 3; i <= boundary; i += 2)
                if (number % i == 0)
                    return false;
            
            return true;                   
        }
    }
}
