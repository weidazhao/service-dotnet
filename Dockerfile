FROM microsoft/dotnet:1.0.0-preview1

WORKDIR /dotnetapp

COPY ./bin/Release/netcoreapp1.0/publish/ ./

ENTRYPOINT ["dotnet", "service-dotnet.dll"]