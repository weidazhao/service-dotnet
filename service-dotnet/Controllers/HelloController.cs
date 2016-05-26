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
            return $"Hello from VSTS-Agent 2 on Thursday!!!!!!!!!!!!!!! Time: {DateTimeOffset.UtcNow.ToString("u")}";
        }
    }
}
