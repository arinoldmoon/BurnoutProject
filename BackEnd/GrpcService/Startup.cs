using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using GrpcService.Data;
using GrpcService.Models;
using GrpcService.Services;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace GrpcService
{
    public class Startup
    {
        // This method gets called by the runtime. Use this method to add services to the container.
        // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940

        public IConfiguration Configuration { get; }

        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddGrpc(opt => opt.EnableDetailedErrors = true);
            services.AddDbContext<DataContext>(opt => opt.UseSqlite(Configuration.GetConnectionString("SQLiteConnection")), ServiceLifetime.Singleton);

            services.Configure<PLCConfig>(Configuration.GetSection("PLCConfig"));

            services.AddSingleton<IOvenDbService, OvenDbService>();
            services.AddSingleton<IOvenPlcService, OvenPlcService>();
            services.AddHostedService<WorkerService>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseRouting();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapGrpcService<GrpcOvenService>();
                endpoints.MapGrpcService<GrpcPatternService>();
                endpoints.MapGrpcService<GrpcOperationService>();
                endpoints.MapGet("/", async context =>
                {
                    await context.Response.WriteAsync("Communication with gRPC endpoints must be made through a gRPC client. To learn how to create a client, visit: https://go.microsoft.com/fwlink/?linkid=2086909");
                });
            });
        }
    }
}
