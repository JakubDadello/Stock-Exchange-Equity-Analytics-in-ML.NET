FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /app

COPY ["PolishEquity.Analytics.Api/PolishEquity.Analytics.Api.csproj", "PolishEquity.Analytics.Api/"]
COPY ["PolishEquity.Analytics.Trainer/PolishEquity.Analytics.Trainer.csproj", "PolishEquity.Analytics.Trainer/"]
RUN dotnet restore "PolishEquity.Analytics.Api/PolishEquity.Analytics.Api/PolishEquity.Analytics.Api.csproj"

COPY . .
WORKDIR "/app/PolishEquity.Analytics.Api" 
RUN dotnet build "PolishEquity.Analytics.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "PolishEquity.Analytics.Api.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
EXPOSE 8080

COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "PolishEquity.Analytics.Api.dll"]