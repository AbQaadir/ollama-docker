FROM ollama/ollama:latest

# Create necessary directories and set permissions
RUN mkdir -p /models && \
    mkdir -p /.ollama && \
    mkdir -p /home/updatesuser/.ollama && \
    chown -R 10014:10014 /models && \
    chown -R 10014:10014 /.ollama && \
    chown -R 10014:10014 /home/updatesuser && \
    chmod 755 /models && \
    chmod 755 /.ollama && \
    chmod 755 /home/updatesuser/.ollama

# Set environment variables
ENV OLLAMA_HOST=0.0.0.0:8080
ENV OLLAMA_MODELS=/models
ENV OLLAMA_DEBUG=false
ENV OLLAMA_KEEP_ALIVE=-1
ENV MODEL=llama3.2:3b
ENV HOME=/home/updatesuser

# Switch to the updatesuser
USER 10014

# Pull the model weights
RUN ollama serve & sleep 5 && ollama pull llama3.2:3b

# Start Ollama
ENTRYPOINT ["ollama", "serve"]
