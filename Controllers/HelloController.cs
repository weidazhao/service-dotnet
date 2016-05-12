using Microsoft.AspNetCore.Mvc;
using System;

namespace Backend
{
    [Route("/api/hello")]
    public class HelloController
    {
        [HttpGet]
        public string Get()
        {
            return $"Hello ACS! Time: {DateTimeOffset.UtcNow.ToString("u")}";
        }
    }
}
