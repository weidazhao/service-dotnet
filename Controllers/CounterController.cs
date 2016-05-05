using Microsoft.AspNetCore.Mvc;
using System.Threading;

namespace Backend
{
    [Route("/")]
    public class CounterController
    {
        private static int _count = 0;

        [HttpGet]
        public int Get()
        {
            return _count;
        }

        [HttpPost]
        public int Post()
        {
            return Interlocked.Increment(ref _count);
        }
    }
}
