FROM microsoft/dotnet:1.0.0-rc2-core

WORKDIR /dotnetapp

COPY ./publishOutput/ .

ENTRYPOINT ["dotnet", "service-dotnet.dll"]