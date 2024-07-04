using FoodDelivery.Models;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.StaticFiles;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.FileProviders;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddSqlServer<FoodDeliveryContext>(builder.Configuration.GetConnectionString("DefaultConnection"));
builder.Services.AddScoped<SessionCleanupService>(); // clean expired sessions 

builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath = "/api/Auth/login";
        options.ExpireTimeSpan = TimeSpan.FromHours(1);
        options.Cookie.HttpOnly = true;
        options.Cookie.SecurePolicy = CookieSecurePolicy.Always;
        options.Cookie.SameSite = SameSiteMode.Strict;
    });

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigin",
        builder =>
        {
            builder.WithOrigins("https://localhost:8080")
                   .AllowAnyHeader()
                   .AllowAnyMethod()
                   .AllowCredentials();
        });
});

builder.Services.AddSwaggerGen(option =>
{
option.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo { Title = "LoginAPI Demo", Version = "v1" });

// Update security definition for cookie auth
option.AddSecurityDefinition("cookieAuth", new OpenApiSecurityScheme
{
    In = ParameterLocation.Cookie,
    Description = "Enter 'COOKIE-NAME' value from your login",
    Name = "BisoCookie",
    Type = SecuritySchemeType.ApiKey
});

    option.AddSecurityRequirement(new OpenApiSecurityRequirement()
  {
    { new OpenApiSecurityScheme { Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "cookieAuth" } }, new string[] { } }
  });
});


var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

//aici injectam serviciul nostru de curatare al sesiunilor expirate
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    var sessionCleanupService = services.GetRequiredService<SessionCleanupService>();
    await sessionCleanupService.CleanupExpiredSessions();
}

app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new PhysicalFileProvider(Path.Combine(Directory.GetCurrentDirectory(), "Static")),
    RequestPath = "/StaticFiles",
    ContentTypeProvider = new FileExtensionContentTypeProvider(
        new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
        {
            {".json", "application/json" },
            {".css", "text/css" },
            {".html", "text/html" },
            {".jpg", "image/jpeg" },
            {".pdf", "application/pdf" }
        }
    )
});

app.Run();
