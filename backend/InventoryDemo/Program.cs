using InventoryDemo.Business.Abstracts;
using InventoryDemo.Business.AutoMapper;
using InventoryDemo.Business.Concretes;
using InventoryDemo.DataAccess.Data;
using InventoryDemo.DataAccess.Repositories.Abstracts;
using InventoryDemo.DataAccess.Repositories.Concretes;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Text;

var builder = WebApplication.CreateBuilder(args);
string connectionString = builder.Configuration.GetConnectionString("db");

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    var jwtSecurityScheme = new OpenApiSecurityScheme
    {
        Scheme = "bearer",
        BearerFormat = "JWT",
        Name = "JWT Auth",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.Http,
        Description = "Post your JWT token below!",
        Reference = new OpenApiReference
        {
            Id = JwtBearerDefaults.AuthenticationScheme,
            Type = ReferenceType.SecurityScheme
        }
    };

    c.AddSecurityDefinition(jwtSecurityScheme.Reference.Id, jwtSecurityScheme);
    c.AddSecurityRequirement(new OpenApiSecurityRequirement { { jwtSecurityScheme, Array.Empty<string>() } });
});

builder.Services.AddDbContext<InventoryDbContext>(options =>
{
    options.UseSqlServer(connectionString);
});

builder.Services.AddAutoMapper(typeof(MapProfile));
builder.Services.AddScoped<ICategoryService, CategoryService>();
builder.Services.AddScoped<ICategoryRepository, EFCategoryRepository>();
builder.Services.AddScoped<IPropertyService, PropertyService>();
builder.Services.AddScoped<IPropertyRepository, EFPropertyRepository>();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IUserRepository, EFUserRepository>();

builder.Services.AddCors(opt => opt.AddPolicy("Allow", builder =>
{
    builder.AllowAnyOrigin();
    builder.AllowAnyMethod();
    builder.AllowAnyHeader();
}));

var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("A very very secret key."));
var credential = new SigningCredentials(key, SecurityAlgorithms.Sha256);

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(opt =>
{
    opt.SaveToken = true;
    opt.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateActor = true,
        ValidateIssuer = true,
        ValidateAudience = true,

        ValidIssuer = "inventory",
        ValidAudience = "inventory",
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = key
    };
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
