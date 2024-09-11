# Stage 1: Build the Go application
FROM golang:1.23.0 AS builder

WORKDIR /app

# Copy the Go modules files and download dependencies
#COPY go.mod .
#COPY go.sum .
#RUN go mod download
COPY main.go .
RUN go fmt main.go
RUN go mod init app
RUN go mod tidy

# Copy the rest of the application source code
#COPY . .

# Build the Go application
RUN CGO_ENABLED=0 GOOS=linux go build -o app .

# Stage 2: Create the final Docker image
FROM debian:12

# Copy the built executable from the builder stage
COPY --from=builder /app/app /usr/local/bin/app

# Expose the port on which the server will listen
EXPOSE 8080

# Command to run the HTTP server when the container starts
CMD ["/usr/local/bin/app"]
