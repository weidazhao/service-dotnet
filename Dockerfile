FROM microsoft/dotnet-preview

CMD ["dotnet", "run"]

WORKDIR /app
COPY project.json NuGet.config .
RUN dotnet restore
COPY . .
RUN dotnet build
