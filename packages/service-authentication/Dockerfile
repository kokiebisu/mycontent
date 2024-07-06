FROM golang:latest as Builder

WORKDIR /app

COPY ../../../go.mod ../../../go.sum ./

RUN go mod download

COPY . .

WORKDIR /app/packages/service-blog

RUN GOOS=linux GOARCH=arm64 go build -o main .

FROM golang:latest

COPY --from=Builder /app/packages/service-blog/main /main

EXPOSE 4001

CMD ["/main"]