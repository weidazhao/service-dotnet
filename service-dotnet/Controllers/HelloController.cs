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
            return $"Hello from Cross-Platform VSTS-Agent! Time: {DateTimeOffset.UtcNow.ToString("u")}";
        }
    }
}
