FROM golang:latest as Builder

WORKDIR /app

COPY ../../../go.mod ../../../go.sum ./

RUN go mod download

COPY . .

WORKDIR /app/packages/content

RUN GOOS=linux GOARCH=arm64 go build -o main .

FROM golang:latest
COPY --from=Builder /app/packages/content/main /main
# CMD ["tail", "-f", "/dev/null"]
CMD ["/main"]