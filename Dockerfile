FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY DevOpsPipeline/DevOpsPipeline.csproj DevOpsPipeline/
RUN dotnet restore DevOpsPipeline/DevOpsPipeline.csproj

COPY . .
WORKDIR /src/DevOpsPipeline
RUN dotnet publish DevOpsPipeline.csproj -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "DevOpsPipeline.dll"]