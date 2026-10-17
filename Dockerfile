FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish TaskManagerApi.csproj -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /app .
CMD ["sh", "-c", "ASPNETCORE_URLS=http://+:${PORT:-10000} dotnet TaskManagerApi.dll"]
