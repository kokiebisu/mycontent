FROM golang:latest as Builder

WORKDIR /app

COPY ../../../go.mod ../../../go.sum ./

RUN go mod download

COPY . .

WORKDIR /app/packages/service-content

RUN GOOS=linux GOARCH=arm64 go build -o main .

FROM golang:latest

COPY --from=Builder /app/packages/service-content/main /main

EXPOSE 8080

CMD ["/main"]