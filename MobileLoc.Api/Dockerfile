FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["MobileLoc.Api/MobileLoc.Api.csproj", "MobileLoc.Api/"]
RUN dotnet restore "MobileLoc.Api/MobileLoc.Api.csproj"
COPY . .
WORKDIR "/src/MobileLoc.Api"
RUN dotnet build "MobileLoc.Api.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "MobileLoc.Api.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "MobileLoc.Api.dll"]