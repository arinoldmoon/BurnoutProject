using GrpcService.Database;
using GrpcService.Models;
using GrpcService.Services;
using GrpcService.Services.gRPC;

var builder = WebApplication.CreateBuilder(args);
var configuration = builder.Configuration;

builder.Services.AddDbContext<SQLiteContext>(ServiceLifetime.Singleton);
builder.Services.Configure<PLCConfig>(configuration.GetSection("PLCConfig"));
builder.Services.AddSingleton<SystemConfig>();
builder.Services.AddSingleton<ResponseModel>();
builder.Services.AddSingleton<ModelConvertor>();

builder.Services.AddSingleton<IDbService, DbService>();
builder.Services.AddSingleton<IPlcService, PlcService>();
builder.Services.AddHostedService<WorkerService>();
builder.Services.AddGrpc(opt => opt.EnableDetailedErrors = true);

#if RELEASE
    builder.WebHost.UseUrls("http://*:5000");
#endif

var app = builder.Build();


app.MapGrpcService<OvenService>();
app.MapGrpcService<PatternService>();
app.MapGrpcService<OperationService>();

app.MapGet("/", () => "Communication with gRPC endpoints must be made through a gRPC client. To learn how to create a client, visit: https://go.microsoft.com/fwlink/?linkid=2086909");

app.Run();
