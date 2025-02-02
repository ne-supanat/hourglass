# Use the pre-built Ollama image from Docker Hub as the base image
FROM ollama/ollama:latest

# Expose the port that Ollama uses
EXPOSE 11434

# Optionally, you can define volumes or other settings here
VOLUME ["/root/.ollama"]

# Command to run ollama pull and then start the service
# CMD ["/bin/sh", "-c", "ollama pull gemma2:2b && ollama"]

# Use ENTRYPOINT to mimic terminal behavior
# ENTRYPOINT ["/bin/sh", "-c", "ollama pull gemma2:2b && ollama"]

# RUN ollama pull gemma2:2b