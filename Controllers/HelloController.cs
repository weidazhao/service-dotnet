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
            return $"Hello Docker! Time: {DateTimeOffset.UtcNow.ToString("u")}";
        }
    }
}
