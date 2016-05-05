using System;
using System.IO;
using Microsoft.AspNetCore.Hosting;

namespace Backend
{
    public class Program
    {
        public static void Main(string[] args)
        {
            string port = Environment.GetEnvironmentVariable("PORT") ?? "5000";
            
            var webHost = new WebHostBuilder().UseKestrel()
                                              .UseContentRoot(Directory.GetCurrentDirectory())                        
                                              .UseStartup<Startup>()
                                              .UseUrls($"http://+:{port}")
                                              .Build();

            webHost.Run();
        }
    }
}