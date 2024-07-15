FROM golang:latest AS builder

WORKDIR /app

COPY ../../../go.mod ../../../go.sum ./

RUN go mod download

COPY . .

WORKDIR /app/packages/service-authentication

RUN GOOS=linux GOARCH=arm64 go build -o server ./cmd/server/main.go

FROM golang:latest

COPY --from=builder /app/packages/service-authentication/server /server

EXPOSE 4001

CMD ["/server"]