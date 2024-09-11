package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	// Get the hostname of the system
	hostname, err := os.Hostname()
	if err != nil {
		log.Fatalf("Failed to retrieve hostname: %v", err)
	}

	// Log the hostname when starting the server
	log.Printf("Starting server on host: %s", hostname)

	// Start a simple HTTP server
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "v01 Hello from %s!", hostname)
	})

	log.Fatal(http.ListenAndServe(":8080", nil))
}
