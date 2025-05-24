FROM ollama/ollama

# Install necessary tools
RUN apt update && apt install -y curl wget net-tools && apt clean

# Create a directory for models and set it as working directory
WORKDIR /root/.ollama

# Set the model name (can be overridden at build time)
ARG MODEL_NAME="codellama:13b-code"

# Start Ollama server, wait for it to be ready, download the model, then stop the server
RUN nohup sh -c "ollama serve &" && \
    echo "Waiting for Ollama server to be ready..." && \
    until curl -s http://localhost:11434/api/tags >/dev/null 2>&1; do \
        echo "Waiting for Ollama server..." && \
        sleep 1; \
    done && \
    echo "Ollama server is ready. Pulling model: ${MODEL_NAME}" && \
    ollama pull ${MODEL_NAME} && \
    echo "Model ${MODEL_NAME} successfully downloaded" && \
    pkill ollama

# Set the default command
ENTRYPOINT ["/bin/bash", "-c", "ollama serve"]
