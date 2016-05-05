FROM microsoft/dotnet-preview

CMD ["dotnet", "run"]

WORKDIR /app
COPY . .
RUN dotnet restore && dotnet build