using System;
using Grpc.Net.Client;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Radzen;
using UI.Protos;
using UI.Services;

namespace UI
{
    public partial class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        partial void OnConfigureServices(IServiceCollection services);
        partial void OnConfiguringServices(IServiceCollection services);
        public void ConfigureServices(IServiceCollection services)
        {
            OnConfiguringServices(services);

            services.AddRazorPages();
            services.AddServerSideBlazor();

            services.AddScoped<DialogService>();
            services.AddScoped<NotificationService>();
            services.AddScoped<GlobalService>();

            services.AddSingleton<OvenService>(o => new OvenService(Configuration.GetSection("GrpcService").GetSection("IP").Value));
            services.AddSingleton<PatternService>(o => new PatternService(Configuration.GetSection("GrpcService").GetSection("IP").Value));
            services.AddSingleton<OperationService>(o => new OperationService(Configuration.GetSection("GrpcService").GetSection("IP").Value));

            OnConfigureServices(services);

        }

        partial void OnConfigure(IApplicationBuilder app, IWebHostEnvironment env);
        partial void OnConfiguring(IApplicationBuilder app, IWebHostEnvironment env);
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            OnConfiguring(app, env);

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Error");
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapBlazorHub();
                endpoints.MapFallbackToPage("/_Host");
            });

            OnConfigure(app, env);
        }
    }
}
