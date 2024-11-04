FROM ollama/ollama:latest

# Listen on all interfaces, port 8080
ENV OLLAMA_HOST=0.0.0.0:8080

# Store model weight files in /models
ENV OLLAMA_MODELS=/models

# Reduce logging verbosity
ENV OLLAMA_DEBUG=false

# Never unload model weights from the GPU
ENV OLLAMA_KEEP_ALIVE=-1

# Store the model weights in the container image
ENV MODEL=llama3.2:3b

# Create a group and user for updates
RUN groupadd --gid 10014 updates && \
    useradd --no-create-home --uid 10014 -g updates updatesuser && \
    mkdir -p /home/updatesuser && \
    chown -R updatesuser:updates /home/updatesuser

# Pull the model weights
RUN su - updatesuser -c "ollama serve & sleep 5 && ollama pull llama3.2:3b"

# Start Ollama
ENTRYPOINT ["ollama", "serve"]