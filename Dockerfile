# Use the official Golang image to build the application
FROM golang:1.18 AS builder
WORKDIR /app
COPY . .
RUN go mod init myapp || true
RUN CGO_ENABLED=0 GOOS=linux go build -o myapp .

# Use a minimal image for the final container
FROM scratch
WORKDIR /
COPY --from=builder /app/myapp .
EXPOSE 8080
CMD ["/myapp"]
