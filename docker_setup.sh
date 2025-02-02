#!/bin/sh

# Build image
docker build -t ollama_hourglass .        

# Run the container
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama_hourglass ollama_hourglass:latest

# Wait for the container to start
sleep 5

# Pull the model
docker exec ollama_hourglass ollama pull gemma2:2b