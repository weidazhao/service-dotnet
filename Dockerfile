FROM microsoft/dotnet-preview

CMD ["dotnet", "run"]

WORKDIR /app
COPY project.json .
RUN dotnet restore
COPY . .
RUN dotnet build
