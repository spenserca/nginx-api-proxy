var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

var app = builder.Build();

app.UseHttpsRedirection();

app.MapGet("/hello-world", () => new ResponseMessage("Hello, World!"));

app.Run();

record ResponseMessage(string Message);
