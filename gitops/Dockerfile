FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["LibraryService.csproj", "LibraryService/"]
RUN dotnet restore "LibraryService/LibraryService.csproj"
COPY . .
WORKDIR "/src/LibraryService"
COPY . .

RUN dotnet build "LibraryService.csproj" -c Release -o /app/build -r linux-x64

FROM build AS publish
RUN dotnet publish "LibraryService.csproj" -c Release -o /app/publish -r linux-x64
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LibraryService.dll"]