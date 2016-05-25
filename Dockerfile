FROM microsoft/dotnet:1.0.0-preview1

WORKDIR /dotnetapp

COPY ./publishOutput/ ./

ENTRYPOINT ["dotnet", "service-dotnet.dll"]