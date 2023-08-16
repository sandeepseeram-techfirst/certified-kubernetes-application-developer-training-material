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


