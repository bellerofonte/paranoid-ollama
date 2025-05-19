#!/bin/bash

set -e

echo "🚀 Starting Ollama server in background..."
ollama serve &

echo "⏳ Waiting for Ollama API to become available..."
until curl -s http://localhost:11434/api/tags >/dev/null; do
  sleep 1
done

MODEL_NAME="deepseek-coder:33b"
echo "🧠 Waiting for model $MODEL_NAME to appear..."
until curl -s http://localhost:11434/api/tags | grep -q "$MODEL_NAME"; do
  sleep 1
done

echo "⚡ Warming up model $MODEL_NAME..."
curl -s http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"$MODEL_NAME\", \"prompt\": \"ping\"}" > /dev/null

echo "✅ Ready. Ollama running and model preloaded."
wait
