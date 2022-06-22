using Radzen;
using UI.Models;
using UI.Services;

var builder = WebApplication.CreateBuilder(args);
var configuration = builder.Configuration;

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
builder.Services.AddScoped<DialogService>();
builder.Services.AddScoped<NotificationService>();
builder.Services.AddScoped<GlobalService>();

builder.Services.AddSingleton<OvenService>(o => new OvenService(configuration.GetSection("GrpcService").GetSection("IP").Value));
builder.Services.AddSingleton<PatternService>(o => new PatternService(configuration.GetSection("GrpcService").GetSection("IP").Value));
builder.Services.AddSingleton<SystemConfig>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
}


app.UseStaticFiles();

app.UseRouting();

app.MapBlazorHub();
app.MapFallbackToPage("/_Host");

app.Run();
