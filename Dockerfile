FROM ollama/ollama

RUN apt update && apt install -y curl wget net-tools && apt clean
