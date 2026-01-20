# ===== Build stage =====
FROM --platform=linux/amd64 golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .
RUN go build -o app

# ===== Runtime stage =====
FROM --platform=linux/amd64 alpine:latest

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]
