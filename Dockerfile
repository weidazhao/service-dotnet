FROM microsoft/dotnet-preview

RUN mkdir /app
WORKDIR /app
COPY . /app
RUN cd /app && dotnet restore && dotnet build

EXPOSE 80
CMD ["dotnet", "run"]