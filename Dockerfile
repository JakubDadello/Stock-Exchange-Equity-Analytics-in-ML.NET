# Use the official .NET 10 SDK image for a robust build environment
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /app

# Copy project files and restore dependencies
COPY ["PolishEquity.Analytics.Api/PolishEquity.Analytics.Api.csproj", "PolishEquity.Analytics.Api/"]
COPY ["PolishEquity.Analytics.Trainer/PolishEquity.Analytics.Trainer.csproj", "PolishEquity.Analytics.Trainer/"]
RUN dotnet restore "PolishEquity.Analytics.Api/PolishEquity.Analytics.Api.csproj"

# Copy the entire source code and build the application
COPY . .
WORKDIR "/app/PolishEquity.Analytics.Api" 
RUN dotnet build "PolishEquity.Analytics.Api.csproj" -c Release -o /app/build

# Publish the application to a dedicated folder
FROM build AS publish
RUN dotnet publish "PolishEquity.Analytics.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Use the lightweight ASP.NET runtime image for the final stage
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
EXPOSE 8080

# Copy the trained ML model into the publish directory
COPY PolishEquity.Analytics.Api/LightGBM_model.zip /app/publish/

# Copy only the compiled binaries from the publish stage
COPY --from=publish /app/publish .

# Set the entry point for the application
ENTRYPOINT ["dotnet", "PolishEquity.Analytics.Api.dll"]