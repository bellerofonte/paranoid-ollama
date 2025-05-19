#!/bin/bash

set -e

echo "🕒 Waiting for Ollama to start..."
until curl -s http://ollama:11434/api/tags >/dev/null; do
  sleep 1
done

MODEL_NAME="deepseek-coder:33b"
if curl -s http://ollama:11434/api/tags | grep -q "$MODEL_NAME"; then
  echo "✅ Model '$MODEL_NAME' already exists. Skipping pull."
else
  echo "⬇️ Pulling model '$MODEL_NAME'..."
  ollama pull "$MODEL_NAME"
fi
