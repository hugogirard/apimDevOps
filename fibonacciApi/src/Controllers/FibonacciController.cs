using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace src.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FibonacciController : ControllerBase
    {
        private readonly ILogger<FibonacciController> _logger;

        public FibonacciController(ILogger<FibonacciController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        public IEnumerable<int> Get(int len) 
        {
            var sequence = new List<int>();
            int a = 0, b = 1, c = 0;   
            for (int i = 2; i < len; i++)  
            {  
                c= a + b;  
                sequence.Add(c); 
                a= b;  
                b= c;  
            }

            return sequence;
        }
    }
}
