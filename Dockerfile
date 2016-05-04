FROM microsoft/dotnet-preview

CMD ["dotnet", "run"]

WORKDIR /app
COPY project.json .
COPY NuGet.config .
RUN dotnet restore
COPY . .
RUN dotnet build
