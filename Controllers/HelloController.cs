using Microsoft.AspNetCore.Mvc;

namespace Backend
{
    [Route("/api/hello")]
    public class HelloController
    {
        [HttpGet]
        public string Get()
        {
            return $"Hello {System.DateTimeOffset.UtcNow}";
        }
    }
}
