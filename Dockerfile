FROM microsoft/dotnet:1.0.0-preview1

WORKDIR /dotnetapp

COPY ["project.json", "NuGet.config", "/dotnetapp/"]
RUN dotnet restore
COPY . .
RUN dotnet build

ENTRYPOINT ["dotnet", "run"]