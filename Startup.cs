using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

namespace Backend
{
    public class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        { 
            services.AddMvcCore()
                    .AddJsonFormatters();
        }

        public void Configure(IApplicationBuilder app, ILoggerFactory loggerFactory)
        {
            loggerFactory.AddConsole(LogLevel.Debug);
            
            app.UseMvc();
            
            //
            // Health check
            //
            app.Run(context =>
            {
                if (context.Request.Path == "/")
                {
                    context.Response.StatusCode = 200;
                }
                else
                {
                    context.Response.StatusCode = 404;
                }
                
                return Task.CompletedTask;
            });
        }
    }
}
